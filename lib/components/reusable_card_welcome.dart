import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  String label;
  ReusableCard({this.label});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
          height: 120,
          width: 120,
          alignment: Alignment.center,
          child: Text(label, style: TextStyle(fontSize: 35))),
    );
  }
}
