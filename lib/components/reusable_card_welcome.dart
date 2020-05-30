import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  String label;
  Color colour;
  Color textColor;
  ReusableCard({this.label, this.colour, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
//              boxShadow: [
//                BoxShadow(
//                  color: Colors.blue.withOpacity(0.5),
//                  spreadRadius: 3,
//                  blurRadius: 5,
////                  offset: Offset(0, 3), // changes position of shadow
//                ),
//              ],
              color: colour,
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          child: Text(label,
              style: TextStyle(fontFamily: 'Quantico', fontSize: 40))),
    );
  }
}
