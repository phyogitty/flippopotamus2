import 'package:flutter/material.dart';
import 'package:flippopotamus/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:flippopotamus/models/user_data.dart';
import 'package:flippopotamus/objects/time_play.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class SummaryScreen extends StatefulWidget {
  static const String id = 'summary_screen';

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen>
    with TickerProviderStateMixin {
  AnimationController controller;
  AnimationController controller2;
  Animation animation;
  Animation animation2;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    controller2 =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
//    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation2 = CurvedAnimation(parent: controller2, curve: Curves.linear);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    controller2.forward();
    controller2.addListener(() {
      setState(() {});
    });

    animation = Tween<Offset>(
      begin: const Offset(0, 300.0),
      end: const Offset(0, 280.0),
    ).animate(controller);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        controller.forward();
      } else if (status == AnimationStatus.completed) {
        // you frigging need this; otherwise, the code will break
        controller.reverse(from: 1);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    double width = MediaQuery.of(context).size.width; // screen width
//    double height = MediaQuery.of(context).size.height;
    double widthG = Provider.of<UserData>(context).row % 2 == 1
        ? Provider.of<UserData>(context).row * 75.0
        : 4 * 75.0;

//    double xToTranslate = (width - widthG) / 2;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            transform: Matrix4Transform()
//            .rotateDegrees(360 * animation.value, origin: Offset(25, 25))
                .translate(x: animation2.value, y: 200 * animation2.value)
                .matrix4,
            child: Container(
                height: 2 * 100.0 * animation2.value,
                width: widthG * animation2.value, // works for 2 rows or 4 rows
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
                        color: Colors.yellow,
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
          Transform.translate(
            offset: animation.value,
            child: Center(
              child: Container(
                height: 50,
                width: 150,
                color: Colors.blue,
                child: RaisedButton(
                  child: Text('Play Again', style: TextStyle(fontSize: 23)),
                  onPressed: () {
                    Provider.of<UserData>(context, listen: false).resetAll();
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Transform.translate(
            offset: animation.value,
            child: Center(
              child: Container(
                height: 50,
                width: 150,
                color: Colors.blue,
                child: RaisedButton(
                  child: Text('Quit', style: TextStyle(fontSize: 30)),
                  onPressed: () {
                    Provider.of<UserData>(context, listen: false).resetAll();
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 30,
            width: 30,
            child: Text('', style: TextStyle(fontSize: 30)),
          )
        ],
      ),
    );
  }
}
