import 'dart:collection';
import 'dart:math';
import 'package:flippopotamus/constants.dart';
import 'package:flippopotamus/objects/level_option.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flippopotamus/objects/theme_option.dart';
import 'package:flippopotamus/objects/time_play.dart';

class UserData extends ChangeNotifier {
  // DATA

  PlayTime playedDuration;
  ThemeOption _selectedTheme;
  LevelOption _selectedLevel;

  List<String> shuffledElements = []; // contains all the elements to display
  List<String> playedElements = []; // only unique elements to play
  Map<String, Function> revealAfterSolved = {};
  int flipCount = 0;
  String _firstFlipped = '';
  String _secondFlipped = '';
  String _currentFlipped = '';

  Function _secondOnPress;
  Function _firstOnPress;
  Function _currentOnPress;

  Function _previousOnSolved;
  Function _currentOnSolved;

  Function startGameTimer;
  Function endGame;

  int solvedCount = 0;
  bool gameEnd = false;
  bool alreadyStarted = false;

  // SETTERS

  void setRevealCard(String element, Function onSolved) {
//    revealOnPressAfterSolved[element] = onPress;
    revealAfterSolved[element] = onSolved;
  }

  void setTheme(ThemeOption selectedOption) {
    _selectedTheme = selectedOption;
  }

  void setPlayedDuration(PlayTime duration) {
    playedDuration = duration;
  }

  void setEndGameFunc(Function end) {
    endGame = end;
  }

  void setLevel(LevelOption selectedOption) {
    _selectedLevel = selectedOption;
    int row = _selectedLevel.getRow();
    int column = _selectedLevel.getColumn();
    int numCard = row * column;
    int numElement = numCard ~/ 2;

    List<String> elements =
        _selectedTheme.getCollection().sublist(0, numElement);
    List<String> temp = _selectedTheme.getCollection().sublist(0, numElement);
    for (String elem in temp) {
      elements.add(elem);
      playedElements.add(elem);
    }

    while (elements.length > 0) {
      int index = Random().nextInt(elements.length);
      shuffledElements.add(elements[index]);
      elements.removeAt(index);
    }
  }

  void setCurrentFlip(String flippedCard, Function onPress, Function onSolved) {
    _firstFlipped = _secondFlipped;
    _secondFlipped = _currentFlipped;
    _currentFlipped = flippedCard;

    _firstOnPress = _secondOnPress;
    _secondOnPress = _currentOnPress;
    _currentOnPress = onPress;

    _previousOnSolved = _currentOnSolved;
    _currentOnSolved = onSolved;

    if (_secondFlipped != '') {
      if ((_firstFlipped != '') && _secondFlipped != _firstFlipped) {
        _secondOnPress();
        _firstOnPress();
        _firstFlipped = '';
        _secondFlipped = '';
      } else if (_secondFlipped == _currentFlipped) {
        _previousOnSolved(); // one of the card shrinks to the center
        _currentOnSolved(); // another one shrinks to the center
//        revealOnPressAfterSolved[_currentFlipped]();
        revealAfterSolved[_currentFlipped]();
        solvedCount++;
        if (solvedCount == (row * 2)) {
          gameEnd = true;
          endGame();
          notifyListeners();
        }
        _secondFlipped = '';
        _currentFlipped = '';
      }
    }
  }

  void setStartGameTimer(Function startTimer) {
    startGameTimer = startTimer;
  }

  void startGame() {
    if (alreadyStarted == false) {
      alreadyStarted = true;
      startGameTimer();
    }
  }

  void resetAll() {
    shuffledElements = [];
    playedElements = [];
//    revealOnPressAfterSolved = {};
    revealAfterSolved = {};
    flipCount = 0;

    _firstFlipped = '';
    _secondFlipped = '';
    _currentFlipped = '';

    _secondOnPress = null;
    _firstOnPress = null;
    _currentOnPress = null;

    _previousOnSolved = null;
    _currentOnSolved = null;

    endGame = null;

    solvedCount = 0;
    gameEnd = false;
    alreadyStarted = false;
  }

  // GETTERS

  PlayTime get gameDuration {
    return playedDuration;
  }

  ThemeOption get userTheme {
    return _selectedTheme;
  }

  LevelOption get userLevel {
    return _selectedLevel;
  }

  int get row {
    return _selectedLevel.getRow();
  }

  int get column {
    return _selectedLevel.getColumn();
  }

  UnmodifiableListView<String> get gameCardHolders {
    return UnmodifiableListView(shuffledElements);
  }

  UnmodifiableListView<String> get getPlayedElements {
    return UnmodifiableListView(playedElements);
  }
}
