import 'package:flippopotamus/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flippopotamus/models/user_data.dart';

class ReusableGameCard extends StatefulWidget {
  String element;
  bool isGameCard;
  Color frontColor;
  Color backColor;
  ReusableGameCard(
      {this.element, this.isGameCard, this.frontColor, this.backColor});

  @override
  _ReusableGameCardState createState() => _ReusableGameCardState(
      element: this.element,
      isGameCard: this.isGameCard,
      frontColor: this.frontColor,
      backColor: this.backColor);
}

class _ReusableGameCardState extends State<ReusableGameCard>
    with SingleTickerProviderStateMixin {
  String element = '';
  bool isGameCard;
  Color frontColor;
  Color backColor;
  _ReusableGameCardState(
      {this.element, this.isGameCard, this.frontColor, this.backColor});

  AnimationController controller;
  Animation animation;
  AnimationStatus animationStatus;
  bool solved;
  @override
  void initState() {
    super.initState();

    solved = false;
    controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });

    animation.addStatusListener((status) {
      animationStatus = status;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onFlipTap() {
    if (animationStatus == AnimationStatus.dismissed) {
      setState(() {
        controller.forward();
      });
    } else if (animationStatus == AnimationStatus.completed) {
      setState(() {
        controller.reverse(from: 1);
      });
    }
  }

  void onFlipSolved() {
    setState(() {
      solved = true;
      controller.reverse(from: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isGameCard) {
      Provider.of<UserData>(context).setOnPress(element, onFlipTap, () {
        setState(() {
          solved = false;
          controller.reverse(from: 1);
        });
      });
    }
    return GestureDetector(
      onTap: isGameCard
          ? () {
              Provider.of<UserData>(context, listen: false).startGame();
              setState(() {
                onFlipTap();
                Provider.of<UserData>(context, listen: false)
                    .setCurrentFlip(element, onFlipTap, onFlipSolved);
              });
            }
          : () {}, // do nothing is not game card
      child: solved
          ? Transform.scale(
              scale: animation.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: backColor,
                ),
                alignment: Alignment.center,
//                height: 50,
//                width: 50,
                child: Text(element, style: TextStyle(fontSize: 50)),
              ),
            )
          : Transform(
              transform: Matrix4.identity()
//                          ..setEntry(3, 2, 0.002)
                ..rotateY(pi * animation.value),
              alignment: FractionalOffset.center,
              child: animation.value * pi <=
                      1.5640821149756443 // change the display at pi/2 (90 degree)
                  ? Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: backColor,
                        ),
                        alignment: Alignment.center,
//                          height: 50,
//                          width: 50,
                        child: Text(element, style: TextStyle(fontSize: 50)),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: frontColor,
                        ),
                        alignment: Alignment.center,
//                        height: 50,
//                        width: 50,
                      ),
                    )),
    );
  }
}
