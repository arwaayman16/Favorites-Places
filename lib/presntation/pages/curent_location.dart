import 'package:flutter/material.dart';

class PickLocation extends StatelessWidget {
  const PickLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Pick your Location"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: 500,
        height: 900,
        
        child: Image.asset("assets/images/map2.png",fit: BoxFit.cover,)),
    );
  }
}
