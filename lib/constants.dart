import 'dart:io';

import 'package:flippopotamus/objects/theme_option.dart';
import 'package:flippopotamus/objects/level_option.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

//
enum Themes { emojis, fruits, animals }

enum Levels { easy, medium, hard }

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
      collection: ['🦄', '🙉', '🐶', '🐠 ', '🐷', '🦋', '🦁', '🐣'])
];

List<LevelOption> kLevels = [
  LevelOption(
    description: 'Easy',
    type: Levels.easy,
    icon: Icon(Icons.looks_one, size: 40),
    row: 2,
    column: 4,
  ),
  LevelOption(
      description: 'Medium',
      icon: Icon(Icons.looks_two, size: 50),
      type: Levels.medium,
      row: 3,
      column: 4),
  LevelOption(
      description: 'Hard',
      type: Levels.hard,
      icon: Icon(
        Icons.looks_3,
        size: 60,
      ),
      row: 4,
      column: 4),
];
