import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'choose_theme_screen.dart';
import 'package:flippopotamus/components/reusable_card_welcome.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        Timer(Duration(seconds: 3), () {
          controller.forward();
        });
        isFront = true;
      } else if (status == AnimationStatus.completed) {
        // you frigging need this; otherwise, the code will break
        Timer(Duration(seconds: 5), () {
          controller.reverse(from: 1);
        });
        isFront = false;
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
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
                Text('Flippopotamus', style: TextStyle(fontSize: 30)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ReusableCard(
                      label: 'Flip',
                    ),
                    Transform(
                        transform: Matrix4.identity()
//                          ..setEntry(3, 2, 0.002)
                          ..rotateY(pi * animation.value),
                        alignment: FractionalOffset.center,
                        child: animation.value * pi <=
                                1.5640821149756443 // change the display at pi/2 (90 degree)
                            ? ReusableCard(
                                label: '🐼',
                              )
                            : ReusableCard(
                                label: 'oq',
                              )),
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
                            ? ReusableCard(
                                label: 'po',
                              )
                            : ReusableCard(
                                label: '🐼',
                              )),
                    ReusableCard(label: 'tamus'),

//                    ReusableStaticCard(label: 'tamus'),
                  ],
                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    FlipCard(
//                      direction: FlipDirection.HORIZONTAL, // default
//                      front: Container(
//                        color: Colors.blue,
//                        height: 100,
//                        width: 100,
//                        alignment: Alignment.center,
//                        child: Icon(Icons.smartphone, color: Colors.white),
//                      ),
//
//                      back: Container(
//                        color: Colors.blue,
//                        height: 100,
//                        width: 100,
//                        alignment: Alignment.center,
//                        child: Text(
//                          'Back',
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                            color: Colors.white,
//                          ),
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
                SizedBox(height: 30),
                Container(
                  color: Colors.black,
                  child: FlatButton(
                    child: Text(
                      'Start',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, ThemeScreen.id);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//                    Transform(
//                      transform: Matrix4.identity()
//                        ..rotateY(pi * animation.value),
//                      alignment: FractionalOffset.center,
//                      child: animation.value * pi <=
//                              1.5640821149756443 // change the display at pi/2 (90 degree)
//                          ? Container(
//                              height: 200,
//                              width: 200,
//                              color: Colors.blue,
//                              alignment: Alignment.center,
//                              child:
//                                  Text('Po0o', style: TextStyle(fontSize: 70)),
//                            )
//                          : Container(
//                              height: 200,
//                              width: 200,
//                              color: Colors.blue,
//                              alignment: Alignment.center,
//                              child:
//                                  Text('HHHH', style: TextStyle(fontSize: 70)),
//                            ),
//                    ),
