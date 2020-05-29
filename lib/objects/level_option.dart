import 'package:flutter/cupertino.dart';
import 'package:flippopotamus/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LevelOption {
  List<String> collection;
  String labelIcon; // can be image too
  Levels type;
  String description;
  int row;
  int column;
  Icon icon;
  LevelOption(
      {this.row,
      this.column,
      this.labelIcon,
      this.type,
      this.icon,
      @required this.description});

  String getLabelIcon() {
    return this.labelIcon;
  }

  String getDescription() {
    return this.description;
  }

  Levels getType() {
    return this.type;
  }

  int getRow() {
    return this.row;
  }

  int getColumn() {
    return this.column;
  }

  Icon getIcon() {
    return this.icon;
  }
}
