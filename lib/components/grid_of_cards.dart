import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flippopotamus/components/game_card.dart';

class CardsGrid extends StatelessWidget {
  UnmodifiableListView<String> cardHolders;
  int column;
  bool isGameCard;
  CardsGrid({this.cardHolders, this.column, this.isGameCard});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: column,
      children: List.generate(cardHolders.length, (index) {
        return ReusableGameCard(
          element: cardHolders[index],
          isGameCard: isGameCard,
        );
      }),
    );
  }
}
