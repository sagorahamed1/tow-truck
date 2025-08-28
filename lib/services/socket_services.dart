


import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:towservice/services/api_constants.dart';

import '../main.dart';



class SocketServices {
  static final SocketServices _socketApi = SocketServices._internal();
  late IO.Socket socket;
  static String? token;

  factory SocketServices() {
    return _socketApi;
  }

  SocketServices._internal();

  Future<void> init({String? userId, fcmToken, BuildContext? context}) async {

    // if(socket.connected){
    //   disconnect(isManual: true);
    // }


    socket = IO.io(
        '${ApiConstants.socketBaseUrl}',
        // '${ApiConstants.imageBaseUrl}?token=$token',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableReconnection()
            .enableForceNew()
            .build()
    );

    _setupSocketListeners(token.toString(), context);
    socket.onConnect((_){
      socket.emit("user-connected",{
        "userId" : "$userId",
        "fcmToken" : "$fcmToken"
      });
    }); // Ensure connection starts
  }

  void _setupSocketListeners(String token, BuildContext? context) {
    socket.onConnect((_) {
      print('========> Socket connected: ${socket.connected}');
    });

    socket.onConnectError((err) {
      print('========> Socket connect error: $err');
    });


    socket.onReconnect((_) {
      print('========> Socket reconnected! $token');
      // init();
    });

    socket.onError((error) {
      print('========> Socket error: $error');
    });


    // // Global listen
    // socket.on("negotiate", (data) {
    //   _showGlobalAlert(context!, data);
    // });





    socket.on("negotiate", (data) {
      print("=======> Negotiate data: $data");
      print("==================== name : ${data["uName"]}");

      if(data != null){
        showGlobalAlert(data);
      }

    });



  }

  Future<dynamic> emitWithAck(String event, dynamic body) async {
    Completer<dynamic> completer = Completer<dynamic>();
    socket.emitWithAck(event, body, ack: (data) {
      completer.complete(data ?? 1);
    });
    return completer.future;
  }

  void emit(String event, dynamic body) {
    if (body != null) {
      socket.emit(event, body);
      print('===========> Emit $event \n $body');
    }
  }

  void disconnect({bool isManual = false}) {
    if (isManual) {
      socket.clearListeners(); // Remove all existing listeners
      socket.disconnect();
      socket.destroy();
      print('========> Socket manually disconnected');
    } else {
      socket.disconnect();
      print('========> Socket disconnected without destroying');
    }
  }


}




// void _showGlobalAlert(BuildContext? context, dynamic data) {
//   // যদি context null হয়ে যায় (যেমন app background), তখন navigatorKey ব্যবহার করো
//   final ctx = navigatorKey.currentContext;
//   if (ctx == null) return;
//
//   showDialog(
//     context: ctx,
//     builder: (_) => AlertDialog(
//       title: Text("New Alert"),
//       content: Text(data.toString()),
//       actions: [
//         TextButton(
//           child: Text("OK"),
//           onPressed: () => Navigator.pop(ctx),
//         )
//       ],
//     ),
//   );
//
// }


