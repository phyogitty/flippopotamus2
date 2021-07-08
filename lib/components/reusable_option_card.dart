import 'package:flutter/material.dart';
import 'package:flippopotamus/constants.dart';

class ReusableOptionCard extends StatelessWidget {
  String description;
  Function onPress;
  Color colour;
  Widget leading;
  ReusableOptionCard(
      {@required this.description,
      @required this.onPress,
      this.colour,
      this.leading});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress, // change the color of the card when the card is selected
      child: Card(
        elevation: 10,
        color: colour,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0),
        ),
        child: Container(
            height: 100,
            width: 120,
            margin: EdgeInsets.symmetric(horizontal: 30),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                leading,
                Text(description,
                    style: TextStyle(
                        color: thirdColor,
                        fontSize: 35,
                        fontFamily: 'Quantico'))
              ],
            )),
      ),
    );
  }
}
