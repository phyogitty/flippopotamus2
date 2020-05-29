import 'package:flutter/material.dart';

class ReusableThemeCard extends StatelessWidget {
  String description;
  Function onPress;
  Color colour;
  Widget leading;
  ReusableThemeCard(
      {@required this.description,
      @required this.onPress,
      this.colour,
      this.leading});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Card(
        elevation: 10,
        color: colour,
        child: Container(
            height: 120,
            width: 120,
            margin: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                leading,
                Text(description, style: TextStyle(fontSize: 35))
              ],
            )),
      ),
    );
  }
}
