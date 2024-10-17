import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/widgets.dart';
import 'package:flutter_system_proxy/flutter_system_proxy.dart';
import 'package:rxdart/rxdart.dart';
import 'package:web_socket_channel/io.dart';

import 'package:flutter_deriv_api/api/models/enums.dart';
import 'package:flutter_deriv_api/basic_api/generated/forget_all_receive.dart';
import 'package:flutter_deriv_api/basic_api/generated/forget_receive.dart';
import 'package:flutter_deriv_api/basic_api/request.dart';
import 'package:flutter_deriv_api/basic_api/response.dart';
import 'package:flutter_deriv_api/helpers/helpers.dart';
import 'package:flutter_deriv_api/services/connection/api_manager/base_api.dart';
import 'package:flutter_deriv_api/services/connection/api_manager/connection_information.dart';
import 'package:flutter_deriv_api/services/connection/call_manager/base_call_manager.dart';
import 'package:flutter_deriv_api/services/connection/call_manager/call_history.dart';
import 'package:flutter_deriv_api/services/connection/call_manager/call_manager.dart';
import 'package:flutter_deriv_api/services/connection/call_manager/exceptions/call_manager_exception.dart';
import 'package:flutter_deriv_api/services/connection/call_manager/subscription_manager.dart';

/// This class is for handling Binary API connection and calling Binary APIs.
class BinaryAPI extends BaseAPI {
  /// Initializes [BinaryAPI] instance.
  BinaryAPI({
    String? key,
    bool enableDebug = false,
    this.proxyAwareConnection = false,
  }) : super(key: key ?? '${UniqueKey()}', enableDebug: enableDebug);

  static const Duration _disconnectTimeOut = Duration(seconds: 5);
  static const Duration _websocketConnectTimeOut = Duration(seconds: 10);

  /// A flag to indicate if the connection is proxy aware.
  final bool proxyAwareConnection;

  /// Represents the active websocket connection.
  ///
  /// This is used to send and receive data from the websocket server.
  IOWebSocketChannel? _webSocketChannel;

  /// Stream subscription to API data.
  StreamSubscription<Map<String, dynamic>?>? _webSocketListener;

  /// Call manager instance.
  CallManager? _callManager;

  /// Subscription manager instance.
  SubscriptionManager? _subscriptionManager;

  /// Gets API call history.
  CallHistory? get callHistory => _callManager?.callHistory;

  /// Gets API subscription history.
  CallHistory? get subscriptionHistory => _subscriptionManager?.callHistory;

  @override
  Future<void> connect(
    ConnectionInformation? connectionInformation, {
    ConnectionCallback? onOpen,
    ConnectionCallback? onDone,
    ConnectionCallback? onError,
    bool printResponse = false,
  }) async {
    _resetCallManagers();

    final Uri uri = Uri(
      scheme: 'wss',
      host: connectionInformation!.endpoint,
      path: '/websockets/v3',
      queryParameters: <String, dynamic>{
        // The Uri.queryParameters only accept Map<String, dynamic/*String|Iterable<String>*/>.
        'app_id': connectionInformation.appId,
        'l': connectionInformation.language,
        'brand': connectionInformation.brand,
      },
    );

    _logDebugInfo('connecting to $uri.');

    await _setUserAgent();

    HttpClient? client;

    if (proxyAwareConnection) {
      final String proxy = await FlutterSystemProxy.findProxyFromEnvironment(
          uri.toString().replaceAll('wss', 'https'));

      client = HttpClient()
        ..userAgent = WebSocket.userAgent
        ..findProxy = (Uri uri) => proxy;
    }

    // Initialize connection to websocket server.
    _webSocketChannel = IOWebSocketChannel.connect('$uri',
        pingInterval: _websocketConnectTimeOut, customClient: client);

    _webSocketListener = _webSocketChannel?.stream
        .map<Map<String, dynamic>?>((Object? result) => jsonDecode('$result'))
        .listen(
      (Map<String, dynamic>? message) {
        onOpen?.call(key);

        if (message != null) {
          _handleResponse(message, printResponse: printResponse);
        }
      },
      onDone: () async {
        _logDebugInfo('the websocket is closed.');

        onDone?.call(key);
      },
      onError: (Object error) {
        _logDebugInfo(
          'the websocket connection is closed with error.',
          error: error,
        );

        onError?.call(key);
      },
    );

    _logDebugInfo('send initial message.');
  }

  void _resetCallManagers() {
    _callManager = CallManager(this);
    _subscriptionManager = SubscriptionManager(this);
  }

  @override
  void addToChannel(Map<String, dynamic> request) {
    try {
      _webSocketChannel?.sink.add(utf8.encode(jsonEncode(request)));
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      _logDebugInfo('error while adding to channel.', error: error);
    }
  }

  @override
  Future<T> call<T>({
    required Request request,
    List<String> nullableKeys = const <String>[],
  }) async {
    final Response response = await (_callManager ??= CallManager(this))(
      request: request,
      nullableKeys: nullableKeys,
    );

    if (response is T) {
      return response as T;
    }

    throw CallManagerException(message: 'Unexpected response');
  }

  @override
  Stream<Response>? subscribe({
    required Request request,
    int cacheSize = 0,
    RequestCompareFunction? comparePredicate,
  }) =>
      (_subscriptionManager ??= SubscriptionManager(this))(
        request: request,
        cacheSize: cacheSize,
        comparePredicate: comparePredicate,
      );

  @override
  Future<ForgetReceive> unsubscribe({required String subscriptionId}) =>
      (_subscriptionManager ??= SubscriptionManager(this)).unsubscribe(
        subscriptionId: subscriptionId,
      );

  @override
  Future<ForgetAllReceive> unsubscribeAll({
    required ForgetStreamType method,
  }) =>
      (_subscriptionManager ??= SubscriptionManager(this))
          .unsubscribeAll(method: method);

  @override
  Future<void> disconnect() async {
    try {
      await _webSocketListener?.cancel();

      await _webSocketChannel?.sink.close().timeout(
            _disconnectTimeOut,
            onTimeout: () => throw TimeoutException('Could not close sink.'),
          );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      _logDebugInfo('disconnect error.', error: e);
    } finally {
      _webSocketListener = null;
      _webSocketChannel = null;
    }
  }

  /// Handles responses that come from server, by using its reqId,
  /// and completes caller's Future or add the response to caller's stream if it was a subscription call.
  void _handleResponse(
    Map<String, dynamic> response, {
    required bool printResponse,
  }) {
    try {
      _logDebugInfo('the websocket is connected.');

      // Make sure that the received message is a map and it's parsable otherwise it throws an exception.
      final Map<String, dynamic> message = Map<String, dynamic>.from(response);

      if (printResponse) {
        _logDebugInfo('api response: $message.');
      }

      if (message.containsKey('req_id')) {
        final int requestId = message['req_id'];

        _logDebugInfo('have request id: $requestId.');

        if (_callManager?.contains(requestId) ?? false) {
          _callManager!.handleResponse(
            requestId: requestId,
            response: message,
          );
        } else if (_subscriptionManager?.contains(requestId) ?? false) {
          _subscriptionManager!.handleResponse(
            requestId: requestId,
            response: message,
          );
        } else {
          _logDebugInfo(
            '$runtimeType $requestId, does not match anything in our pending queue.',
          );
        }
      } else {
        _logDebugInfo('no req_id, ignoring.');
      }
    } on Exception catch (e) {
      _logDebugInfo('failed to process $response.', error: e);
    }
  }

  Future<void> _setUserAgent() async {
    final String userAgent = await getUserAgent();

    if (userAgent.isNotEmpty) {
      WebSocket.userAgent = userAgent;
    }
  }

  void _logDebugInfo(String message, {Object? error}) {
    if (enableDebug) {
      dev.log('$runtimeType $key $message', error: error);
    }
  }
}

/// This class is for handling Binary API connection and calling Binary APIs.
class IsolateWrappingAPI extends BaseAPI {
  /// Initializes [BinaryAPI] instance.
  IsolateWrappingAPI({
    String? key,
    bool enableDebug = false,
    this.proxyAwareConnection = false,
  }) : super(key: key ?? '${UniqueKey()}', enableDebug: enableDebug) {
    Isolate.spawn(_isolateTask, _isolateIncomingPort.sendPort);

    _isolateIncomingPort.listen((dynamic message) {
      if (message is SendPort) {
        _isolateSendPort = message;
      }

      // Check for other messages coming out from Isolate.
    });
  }

  static const Duration _disconnectTimeOut = Duration(seconds: 5);

  final ReceivePort _isolateIncomingPort = ReceivePort();
  SendPort? _isolateSendPort;
  int _eventId = 0;

  int get _getEventId => _eventId++;

  /// A flag to indicate if the connection is proxy aware.
  final bool proxyAwareConnection;

  /// Represents the active websocket connection.
  ///
  /// This is used to send and receive data from the websocket server.
  IOWebSocketChannel? _webSocketChannel;

  /// Stream subscription to API data.
  StreamSubscription<Map<String, dynamic>?>? _webSocketListener;

  /// Call manager instance.
  CallManager? _callManager;

  /// Subscription manager instance.
  SubscriptionManager? _subscriptionManager;

  /// Gets API call history.
  CallHistory? get callHistory => _callManager?.callHistory;

  /// Gets API subscription history.
  CallHistory? get subscriptionHistory => _subscriptionManager?.callHistory;

  @override
  Future<void> connect(
    ConnectionInformation? connectionInformation, {
    ConnectionCallback? onOpen,
    ConnectionCallback? onDone,
    ConnectionCallback? onError,
    bool printResponse = false,
  }) async {
    _isolateSendPort?.send(_WSConnectConfig(
      connectionInformation: connectionInformation,
      onOpen: onOpen,
      onError: onError,
      onClosed: onDone,
      printResponse: printResponse,
    ));
  }

  @override
  void addToChannel(Map<String, dynamic> request) => _isolateSendPort
      ?.send(_AddToChannelEvent(request: request, eventId: _getEventId));

  @override
  Future<T> call<T>({
    required Request request,
    List<String> nullableKeys = const <String>[],
  }) async {
    final event = _CallEvent<T>(request: request, eventId: _getEventId);
    _isolateSendPort?.send(event);
    return event.completer.future;
  }

  @override
  Stream<Response>? subscribe({
    required Request request,
    int cacheSize = 0,
    RequestCompareFunction? comparePredicate,
  }) {
    final BehaviorSubject<Response> stream = BehaviorSubject<Response>();
    _isolateSendPort?.send(_SubEvent<Response>(
      request: request,
      eventId: _getEventId,
      stream: stream,
    ));
    return stream;
  }

  @override
  Future<ForgetReceive> unsubscribe({required String subscriptionId}) =>
      (_subscriptionManager ??= SubscriptionManager(this)).unsubscribe(
        subscriptionId: subscriptionId,
      );

  @override
  Future<ForgetAllReceive> unsubscribeAll({
    required ForgetStreamType method,
  }) =>
      (_subscriptionManager ??= SubscriptionManager(this))
          .unsubscribeAll(method: method);

  @override
  Future<void> disconnect() async {
    try {
      await _webSocketListener?.cancel();

      await _webSocketChannel?.sink.close().timeout(
            _disconnectTimeOut,
            onTimeout: () => throw TimeoutException('Could not close sink.'),
          );
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      _logDebugInfo('disconnect error.', error: e);
    } finally {
      _webSocketListener = null;
      _webSocketChannel = null;
    }
  }

  void _logDebugInfo(String message, {Object? error}) {
    if (enableDebug) {
      dev.log('$runtimeType $key $message', error: error);
    }
  }
}

void _isolateTask(SendPort sendPort) {
  final ReceivePort receivePort = ReceivePort();

  final BinaryAPI binaryAPI = BinaryAPI();

  sendPort.send(receivePort.sendPort);

  receivePort.listen((dynamic message) async {
    if (message is _WSConnectConfig) {
      await binaryAPI.connect(message.connectionInformation);
      // Connect WS
    }

    switch (message) {
      case _AddToChannelEvent():
        binaryAPI.addToChannel(message.request);
        break;
      case _CallEvent():
        final response = await binaryAPI.call(request: message.request);
        message.completer.complete(response);
        break;

      case _SubEvent():
        final stream = binaryAPI.subscribe(request: message.request);
        stream?.listen((event) {
          message.stream.add(event);
        });
        break;
    }
  });
}

class _WSConnectConfig {
  _WSConnectConfig({
    this.onOpen,
    this.onError,
    this.onClosed,
    this.connectionInformation,
    this.printResponse = false,
  });

  final ConnectionInformation? connectionInformation;

  final ConnectionCallback? onOpen;
  final ConnectionCallback? onError;
  final ConnectionCallback? onClosed;
  final bool printResponse;
}

sealed class _IsolateEvent {
  _IsolateEvent({required this.eventId});

  final int eventId;
}

class _AddToChannelEvent extends _IsolateEvent {
  _AddToChannelEvent({required this.request, required super.eventId});

  final Map<String, dynamic> request;
}

class _CallEvent<T> extends _IsolateEvent {
  _CallEvent({required this.request, required super.eventId});

  final Request request;
  final Completer<T> completer = Completer<T>();
}

class _SubEvent<T> extends _IsolateEvent {
  _SubEvent({
    required this.request,
    required super.eventId,
    required this.stream,
  });

  final Request request;

  final BehaviorSubject<T> stream;
}
