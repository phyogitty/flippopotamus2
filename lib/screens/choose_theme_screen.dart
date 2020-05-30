import 'package:flippopotamus/objects/theme_option.dart';
import 'package:flippopotamus/screens/choose_level.dart';
import 'package:flutter/material.dart';
import 'package:flippopotamus/components/reusable_card_theme.dart';
import 'package:flippopotamus/constants.dart';
import 'package:provider/provider.dart';
import 'package:flippopotamus/models/user_data.dart';

class ThemeScreen extends StatefulWidget {
  static const String id = 'choose_theme_screen';

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  ThemeOption selectedTheme;
  List<Widget> getOptions() {
    List<ReusableThemeCard> allThemeCards = [];
    for (ThemeOption theme in kThemes) {
      allThemeCards.add(ReusableThemeCard(
        description: theme.getDescription(),
        onPress: () {
          setState(() {
            selectedTheme = theme;
          });
        },
        colour: selectedTheme == theme ? secondaryColor : Colors.white,
        leading: Text(theme.getLabelIcon(), style: TextStyle(fontSize: 50)),
      ));
    }
    return allThemeCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100),
        color: primaryVariant2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Choose Theme',
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
          Provider.of<UserData>(context, listen: false).setTheme(selectedTheme);
          Navigator.pushNamed(context, LevelScreen.id);
        },
      ),
    );
  }
}
