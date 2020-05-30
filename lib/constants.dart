import 'package:flippopotamus/objects/theme_option.dart';
import 'package:flippopotamus/objects/level_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Themes { emojis, fruits, animals, food, plants, seaAnimals }

enum Levels { easy, medium, hard }
Color primaryColor = Color(0xFFFF8F00);
Color primaryVariant = Color(0xFFFFECB3);
Color primaryVariant2 = Color(0xFFFFF8E1);
//Color primaryColor = Color(0xFF9E9D24);
//Color primaryVariant = Color(0xFFF0F4C3);
Color secondaryColor = Color(0xFF26C6DA);
Color secondaryVariant = Color(0xFFB2EBF2);
Color secondaryVariant2 = Color(0xFFE3F2FD);
Color thirdColor = Color(0xFF7B1FA2);
Color thirdVariant = Color(0xFFCE93D8);
Color thirdVariant2 = Color(0xFFF3E5F5);

List<ThemeOption> kThemes = [
  ThemeOption(
      description: 'Facial emojis',
      type: Themes.emojis,
      labelIcon: '😉',
      collection: ['🤩', '🥶', '😘', '😈', '😂', '🤓', '🥳', '😷']),
  ThemeOption(
      description: 'Fruits',
      type: Themes.fruits,
      labelIcon: '🍓',
      collection: ['🍏', '🍊', '🍓', '🍋', '🍌', '🍉', '🥥', '🍇']),
  ThemeOption(
      description: 'Animals',
      type: Themes.animals,
      labelIcon: '🐶',
      collection: ['🦄', '🙉', '🐶', '🐨', '🐷', '🦋', '🦁', '🐣']),
  ThemeOption(
      description: 'Sea Animals',
      type: Themes.seaAnimals,
      labelIcon: '🐳',
      collection: ['🐳', '🦀', '🐠', '🐡', '🐚', '🐙', '🦈', '🦐']),
  ThemeOption(
      description: 'Food',
      type: Themes.food,
      labelIcon: '🍕',
      collection: ['🍩', '🌭', '🍟', '🍚', '🍕', '🍿', '🥨', '🌮']),
  ThemeOption(
      description: 'Plants',
      type: Themes.plants,
      labelIcon: '🎄',
      collection: ['🌴', '🌻', '🌾', '🌷', '🌳', '🍄', '🌵', '🎄']),
];

List<LevelOption> kLevels = [
  LevelOption(
    description: 'Easy',
    type: Levels.easy,
    icon: Icon(Icons.looks_one, size: 40, color: primaryVariant),
    row: 2,
    column: 4,
  ),
  LevelOption(
      description: 'Medium',
      icon: Icon(Icons.looks_two, size: 50, color: primaryVariant),
      type: Levels.medium,
      row: 3,
      column: 4),
  LevelOption(
      description: 'Hard',
      type: Levels.hard,
      icon: Icon(Icons.looks_3, size: 60, color: primaryVariant),
      row: 4,
      column: 4),
];
