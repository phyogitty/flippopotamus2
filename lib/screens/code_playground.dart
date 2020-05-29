import 'package:flutter/material.dart';

class PlayGround extends StatefulWidget {
  static const String id = 'code_playground';

  @override
  _PlayGroundState createState() => _PlayGroundState();
}

class _PlayGroundState extends State<PlayGround> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
            height: 100,
            width: 100,
            duration: Duration(seconds: 2),
            color: Colors.green,
            curve: Curves.bounceIn,
            child: Text('Hello')),
      ),
    );
  }
}
