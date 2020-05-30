import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flippopotamus/components/game_card.dart';

class CardsGrid extends StatelessWidget {
  UnmodifiableListView<String> cardHolders;
  int column;
  bool isGameCard;
  Color frontColor;
  Color backColor;
  CardsGrid(
      {this.cardHolders,
      this.column,
      this.isGameCard,
      this.frontColor,
      this.backColor});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: column,
      children: List.generate(cardHolders.length, (index) {
        return ReusableGameCard(
          element: cardHolders[index],
          isGameCard: isGameCard,
          frontColor: frontColor,
          backColor: backColor,
        );
      }),
    );
  }
}
