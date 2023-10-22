import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({super.key, this.controller, required this.title});
  final TextEditingController? controller;
  final String title;
  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: TextStyle(color: const Color.fromARGB(176, 255, 255, 255)),
      cursorColor: Colors.white,
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          hoverColor: Colors.white,
          labelText: widget.title,
          labelStyle: TextStyle(
              fontSize: 20, color: const Color.fromARGB(170, 244, 67, 54))),
    );
  }
}
