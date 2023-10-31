import 'dart:async';

import 'package:flutter/material.dart';

class Streem extends StatefulWidget {
  const Streem({super.key});

  @override
  State<Streem> createState() => _StreemState();
}

class _StreemState extends State<Streem> {
  final controller = StreamController();
  Future<void> addStreamData() async {
    for (int i = 0; i < 100; i++) {
      await Future.delayed(Duration(milliseconds: 500));
      controller.sink.add(i);
    }
  }

  @override
  void initState() {
    addStreamData();
    super.initState();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: controller.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        return Scaffold(
            body: Center(
                child: Text(
          "stream data : ${snapshot.data}",
          style: TextStyle(color: Colors.black),
        )));
      },
    );
  }
}
