import 'package:flippopotamus/constants.dart';
import 'package:flippopotamus/screens/choose_theme_screen.dart';
import 'package:flutter/material.dart';
import 'package:flippopotamus/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:flippopotamus/models/user_data.dart';
import 'package:flippopotamus/objects/time_play.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:flippopotamus/components/bouncy_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';

class SummaryScreen extends StatefulWidget {
  static const String id = 'summary_screen';

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen>
    with TickerProviderStateMixin {
  static const double yToTranslate = 70.0;
  AnimationController bounceController;
  AnimationController matrixController;
  AnimationController textController;

  Animation bounceAnimation;
  Animation matrixAnimation;
  Animation textAnimation;
  @override
  void initState() {
    super.initState();
    bounceController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    matrixController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    textController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
//    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    matrixAnimation =
        CurvedAnimation(parent: matrixController, curve: Curves.linear);
    textAnimation =
        CurvedAnimation(parent: textController, curve: Curves.linear);
    bounceAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -20),
    ).animate(bounceController);

    bounceController.forward();
    bounceController.addListener(() {
      setState(() {});
    });
    matrixController.forward();
    matrixController.addListener(() {
      setState(() {});
    });
    Timer(Duration(seconds: 2), () {
      textController.forward();
      textController.addListener(() {
        setState(() {});
      });
    });

    bounceAnimation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        bounceController.forward();
      } else if (status == AnimationStatus.completed) {
        // you frigging need this; otherwise, the code will break
        bounceController.reverse(from: 1);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    bounceController.dispose();
    matrixController.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    double width = MediaQuery.of(context).size.width; // screen width
//    double height = MediaQuery.of(context).size.height;
    PlayTime duration = Provider.of<UserData>(context).gameDuration;
    double widthG = Provider.of<UserData>(context).row % 2 == 1
        ? Provider.of<UserData>(context).row * 75.0
        : 4 * 75.0;

//    double xToTranslate = (width - widthG) / 2;
    return Scaffold(
      backgroundColor: primaryVariant2,
      body: SafeArea(
        child: Column(
          children: <Widget>[
//          Positioned(
//            top: 30,
//            child: Text('Heelo'),
//          ),
            SizedBox(height: 60),
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
                  textStyle: TextStyle(fontSize: 35.0, fontFamily: "Quantico"),
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
            Container(
              transform: Matrix4Transform()
//            .rotateDegrees(360 * animation.value, origin: Offset(25, 25))
                  .translate(
                      x: matrixAnimation.value,
                      y: yToTranslate * matrixAnimation.value)
                  .matrix4,
              child: Container(
                  height: Provider.of<UserData>(context).row < 3
                      ? 100.0 * matrixAnimation.value
                      : 2 * 100.0 * matrixAnimation.value,
                  width: widthG *
                      matrixAnimation.value, // works for 2 rows or 4 rows
                  child: GridView.count(
                    crossAxisCount: Provider.of<UserData>(context).row % 2 == 1
                        ? Provider.of<UserData>(context).row
                        : Provider.of<UserData>(context).column,
                    children: List.generate(
                        Provider.of<UserData>(context).getPlayedElements.length,
                        (index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: secondaryVariant,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text(
                              Provider.of<UserData>(context)
                                  .getPlayedElements[index],
                              style: TextStyle(fontSize: 50)),
                        ),
                      );
                    }),
                  )),
            ),
            SizedBox(height: yToTranslate * 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                  child: Text(
                    'Level: ',
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Quantico',
                        color:
                            Color.fromRGBO(123, 31, 162, textAnimation.value)),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Text(
                    '${Provider.of<UserData>(context).userLevel.getDescription()}',
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Quantico',
                        color:
                            Color.fromRGBO(255, 143, 0, textAnimation.value)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Text(
                'You completed the game in:',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Quantico',
                    color: Color.fromRGBO(123, 31, 162, textAnimation.value)),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Text(
                duration.minutes == 0
                    ? '${duration.seconds} seconds'
                    : '${duration.minutes} minutes ${duration.seconds} seconds',
                style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Quantico',
                    color: Color.fromRGBO(38, 198, 218, textAnimation.value)),
              ),
            ),
            SizedBox(height: 60),
            BouncyButton(
              label: 'Play Again',
              bounceAnimation: bounceAnimation,
              onPress: () {
                Provider.of<UserData>(context, listen: false).resetAll();
                Navigator.pushNamed(context, ThemeScreen.id);
              },
            ),
            SizedBox(height: 30),
            BouncyButton(
              bounceAnimation: bounceAnimation,
              label: 'Exit Game',
              onPress: () {
                Provider.of<UserData>(context, listen: false).resetAll();
                Navigator.pushNamed(context, WelcomeScreen.id);
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
