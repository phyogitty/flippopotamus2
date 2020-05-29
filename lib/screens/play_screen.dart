import 'package:flippopotamus/components/grid_of_cards.dart';
import 'package:flippopotamus/screens/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flippopotamus/models/user_data.dart';
import 'package:flippopotamus/objects/time_play.dart';
import 'package:flip_card/flip_card.dart';
import 'dart:async';
import 'dart:math';

class PlayScreen extends StatefulWidget {
  static const String id = 'play_screen';

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
    with SingleTickerProviderStateMixin {
  bool disappear = false;
  BuildContext buildContext;
  List<String> flips = [];
  Timer _timer;
  int time = 0;
  bool finished = false;

  void startGameTimer() {
    // start the game timer
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        if (finished) {
          timer.cancel();
        } else {
          time = time + 1;
        }
      });
    });
  }

//  AnimationController controller;
//  Animation animation;
//  @override
//  void initState() {
//    super.initState();
//    controller =
//        AnimationController(duration: Duration(seconds: 1), vsync: this);
//    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
//    controller.forward();
//    controller.addListener(() {
//      setState(() {});
//    });
//  }
  void endGame() {
    finished = true;

    Timer(Duration(seconds: 2), () {
      Navigator.pushNamed(context, SummaryScreen.id);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserData>(context).setStartGameTimer(startGameTimer);
    buildContext = context;
    Provider.of<UserData>(context).setEndGameFunc(endGame);

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      height: Provider.of<UserData>(context).row * 110.0,
                      color: Colors.yellow,
                      child: CardsGrid(
                        isGameCard: true,
                        column: Provider.of<UserData>(context).column,
                        cardHolders:
                            Provider.of<UserData>(context).gameCardHolders,
                      ),
                    ),
                  ),
                  Container(
                      color: Colors.pink,
                      child: Text(
                        PlayTime(timeVal: time).getStringFormat(),
                        style: TextStyle(fontSize: 50),
                      )),

                  // 250 for 3 rows, 6 elements
                  Container(
                    height: 2 * 75.0,
                    width: Provider.of<UserData>(context).row % 2 == 1
                        ? Provider.of<UserData>(context).row * 75.0
                        : 4 * 75.0, // works for 2 rows or 4 rows
                    child: CardsGrid(
                      isGameCard: false,
                      column: Provider.of<UserData>(context).row % 2 == 1
                          ? Provider.of<UserData>(context).row
                          : Provider.of<UserData>(context).column,
                      cardHolders:
                          Provider.of<UserData>(context).getPlayedElements,
                    ),
                  ),
                ]),
//          ]),
          ),
        ),
      ),
    );
  }
}
