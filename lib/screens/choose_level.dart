import 'package:flutter/material.dart';
import 'package:flippopotamus/constants.dart';
import 'package:flippopotamus/objects/level_option.dart';
import 'package:flippopotamus/components/reusable_card_theme.dart';
import 'package:flippopotamus/screens/play_screen.dart';
import 'package:provider/provider.dart';
import 'package:flippopotamus/models/user_data.dart';

class LevelScreen extends StatefulWidget {
  static const String id = 'choose_level_screen';

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  LevelOption selectedLevel;
  List<Widget> getOptions() {
    List<ReusableThemeCard> allLevelCards = [];
    for (LevelOption level in kLevels) {
      allLevelCards.add(ReusableThemeCard(
        description: level.getDescription(),
        onPress: () {
          setState(() {
            selectedLevel = level;
          });
        },
        colour: selectedLevel == level ? primaryColor : Colors.white,
        leading: level.getIcon(),
      ));
    }
    return allLevelCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100),
        color: secondaryVariant2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Choose Level',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Quantico',
                    color: thirdVariant,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  child: ListView(
                    children: getOptions(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<UserData>(context, listen: false).setLevel(selectedLevel);
          Navigator.pushNamed(context, PlayScreen.id);
        },
      ),
    );
  }
}
