import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flippopotamus/constants.dart';
import 'package:flutter/foundation.dart';

class ThemeOption {
  List<String> collection;
  String labelIcon; // can be image too
  Themes type;
  String description;
  ThemeOption(
      {this.collection, this.labelIcon, this.type, @required this.description});

  String getLabelIcon() {
    return this.labelIcon;
  }

  String getDescription() {
    return this.description;
  }

  Themes getType() {
    return this.type;
  }

  UnmodifiableListView<String> getCollection() {
    return UnmodifiableListView(collection);
  }
}
