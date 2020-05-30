import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'choose_theme_screen.dart';
import 'package:flippopotamus/components/reusable_card_welcome.dart';
import 'package:flippopotamus/components/bouncy_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flippopotamus/constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController bounceController;
  Animation animation;
  Animation bounceAnimation;
  bool isFront = true;

  AnimationController textController;
  Animation textAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    bounceController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    bounceAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -20),
    ).animate(bounceController);
    controller.forward();
    bounceController.forward();

//    textController =
//        AnimationController(duration: Duration(seconds: 1), vsync: this);
//    textAnimation = CurvedAnimation(parent: controller, curve: Curves.linear);
//    textController.forward();
//    textController.addListener(() {
//      setState(() {});
//    });
    controller.addListener(() {
      setState(() {});
    });

    bounceAnimation.addListener(() {
      setState(() {});
    });

    bounceAnimation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        bounceController.forward();
      } else if (status == AnimationStatus.completed) {
        // you frigging need this; otherwise, the code will break
        bounceController.reverse(from: 1);
      }
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        Timer(Duration(seconds: 3), () {
          controller.forward();
        });
        isFront = true;
      } else if (status == AnimationStatus.completed) {
        // you frigging need this; otherwise, the code will break
        Timer(Duration(seconds: 3), () {
          controller.reverse(from: 1);
        });
        isFront = false;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 250.0,
                  child: ColorizeAnimatedTextKit(
                      repeatForever: true,
                      onTap: () {
                        print("Tap Event");
                      },
                      text: [
                        "Flippopotamus",
                        "Flippopotamus",
                        "Flippopotamus",
                      ],
                      textStyle:
                          TextStyle(fontSize: 35.0, fontFamily: "Quantico"),
                      colors: [
                        primaryColor,
                        secondaryColor,
                        thirdColor,
                        thirdVariant
                      ],
                      textAlign: TextAlign.start,
                      alignment:
                          AlignmentDirectional.topStart // or Alignment.topLeft
                      ),
                ),
//                Text('Flippopotamus',
//                    style: TextStyle(fontFamily: 'Quantico', fontSize: 30)),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ReusableCard(label: 'Flip', colour: secondaryVariant),
                    Transform(
                        transform: Matrix4.identity()
//                          ..setEntry(3, 2, 0.002)
                          ..rotateY(pi * animation.value),
                        alignment: FractionalOffset.center,
                        child: animation.value * pi <=
                                1.5640821149756443 // change the display at pi/2 (90 degree)
                            ? ReusableCard(label: '🐼', colour: primaryColor)
                            : ReusableCard(label: 'oq', colour: thirdColor)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Transform(
                        transform: Matrix4.identity()
                          ..rotateY(pi * animation.value),
                        alignment: FractionalOffset.center,
                        child: animation.value * pi <=
                                1.5640821149756443 // change the display at pi/2 (90 degree)
                            ? ReusableCard(label: 'po', colour: secondaryColor)
                            : ReusableCard(label: '🐼', colour: thirdVariant)),
                    ReusableCard(label: 'tamus', colour: primaryVariant),

//                    ReusableStaticCard(label: 'tamus'),
                  ],
                ),
                SizedBox(height: 80),
                BouncyButton(
                  label: 'Start Game',
                  bounceAnimation: bounceAnimation,
                  onPress: () {
                    Navigator.pushNamed(context, ThemeScreen.id);
                  },
                ),

//                Text(
//                  "Good Job",
//                  style: TextStyle(
//                      fontSize: 40,
//                      color: Color.fromRGBO(0, 0, 0, textAnimation.value)),
//                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
