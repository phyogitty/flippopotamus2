import 'package:flippopotamus/models/user_data.dart';
import 'package:flippopotamus/screens/choose_level.dart';
import 'package:flippopotamus/screens/choose_theme_screen.dart';
import 'package:flippopotamus/screens/code_playground.dart';
import 'package:flippopotamus/screens/play_screen.dart';
import 'package:flippopotamus/screens/summary_screen.dart';
import 'package:flippopotamus/screens/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flippopotamus/models/user_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserData(),
        )
      ],
      child: MaterialApp(
        initialRoute: WelcomeScreen.id,
//        home: WelcomeScreen(),
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LevelScreen.id: (context) => LevelScreen(),
          ThemeScreen.id: (context) => ThemeScreen(),
          PlayScreen.id: (context) => PlayScreen(),
          SummaryScreen.id: (context) => SummaryScreen(),
          PlayGround.id: (context) => PlayGround(),
        },
      ),
    );
  }
}
