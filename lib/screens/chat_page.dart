import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/constants/colors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    try {
      socket = IO.io('http://127.0.0.1:8000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.on("error", (data) => print('error'));
      socket.connect();
      // socket.on('connect', (_) => print('connect: ${socket.id}'));
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Group chat",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(children: [
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                    // hintText: const Text("Type here..."),
                    hintText: "Type here...",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor))),
              )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(FluentIcons.send_16_filled))
            ],
          ),
        )
      ]),
    );
  }
}
