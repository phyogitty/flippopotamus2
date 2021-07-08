import 'package:flippopotamus/objects/theme_option.dart';
import 'package:flippopotamus/screens/choose_level.dart';
import 'package:flutter/material.dart';
import 'package:flippopotamus/components/reusable_option_card.dart';
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
  bool chooseDone = false;
  List<Widget> getOptions() {
    List<ReusableOptionCard> allThemeCards = [];
    for (ThemeOption theme in kThemes) {
      allThemeCards.add(ReusableOptionCard(
        description: theme.getDescription(),
        onPress: () {
          setState(() {
            selectedTheme = theme;
            chooseDone = true;
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
        padding: EdgeInsets.only(top: 70),
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
              Expanded(
                child: Container(
                  child: ListView(
                    children: getOptions(),
                  ),
                ),
              ),
              chooseDone
                  ? FlatButton(
                      onPressed: () {
                        Provider.of<UserData>(context, listen: false)
                            .setTheme(selectedTheme);
                        Navigator.pushNamed(context, LevelScreen.id);
                      },
                      child: Container(
                        height: 80,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Next > ',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: thirdVariant,
                                  fontFamily: 'Quantico',
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Choose Level',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: secondaryColor,
                                  fontFamily: 'Quantico'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(height: 80)
            ],
          ),
        ),
      ),
    );
  }
}
