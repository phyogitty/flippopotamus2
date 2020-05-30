import 'package:flippopotamus/constants.dart';
import 'package:flutter/material.dart';

class BouncyButton extends StatelessWidget {
  const BouncyButton({
    Key key,
    @required this.label,
    @required this.onPress,
    @required this.bounceAnimation,
  }) : super(key: key);

  final Animation bounceAnimation;
  final String label;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
//      offset: Offset(30, 30),
      offset: bounceAnimation.value,
      child: Center(
        child: RaisedButton(
          elevation: 15,
          color: thirdVariant,
          child: Text(label,
              style: TextStyle(
                  fontFamily: 'Quantico',
                  fontSize: 30,
                  color: primaryVariant2)),
          onPressed: onPress,
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
