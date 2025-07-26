import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../helpers/prefs_helper.dart';
import '../utils/app_constant.dart';



class SocketServices {
  static final SocketServices _socketApi = SocketServices._internal();
   IO.Socket? socket;
  static String? token;

  factory SocketServices() => _socketApi;

  SocketServices._internal();

  Future<void> init() async {

    // if(socket.connected){
    //   disconnect(isManual: true);
    // }

    token = await PrefsHelper.getString(AppConstants.bearerToken) ?? "";

    print("-------------------------------------------------------------\n Socket call \n token = $token");

    socket = IO.io(
        'https://api.valentinesproservice.com?token=$token',
        // '${ApiConstants.imageBaseUrl}?token=$token',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNew()
            .enableReconnection()
            .build()
    );

    _setupSocketListeners(token.toString());
    socket?.connect(); // Ensure connection starts
  }

  void _setupSocketListeners(String token) {
    socket?.onConnect((_) {
      print('========> Socket connected: ${socket?.connected}');
    });

    socket?.onConnectError((err) {
      print('========> Socket connect error: $err');
    });

    // socket.onDisconnect((_) {
    //   print('========> Socket disconnected! Attempting to reconnect...');
    //   Future.delayed(Duration(seconds: 2), () {
    //     if (!socket.connected) {
    //       socket.connect(); // Force reconnect if needed
    //     }
    //   });
    // });

    socket?.onReconnect((_) {
      // init();
      print('========> Socket reconnecting...');
    });

    socket?.onReconnect((_) {
      print('========> Socket reconnected! $token');
      // init();
    });

    socket?.onError((error) {
      print('========> Socket error: $error');
    });
  }

  Future<dynamic> emitWithAck(String event, dynamic body) async {
    Completer<dynamic> completer = Completer<dynamic>();
    socket?.emitWithAck(event, body, ack: (data) {
      completer.complete(data ?? 1);
    });
    return completer.future;
  }

  void emit(String event, dynamic body) {
    if (body != null) {
      socket?.emit(event, body);
      print('===========> Emit $event \n $body');
    }
  }


  void disconnect({bool isManual = false}) {
    if (isManual) {
      socket?.clearListeners();
      socket?.disconnect();
      socket?.destroy();
      print('========> Socket manually disconnected');
    } else {
      socket?.disconnect();
      print('========> Socket disconnected without destroying');
    }
  }

}
