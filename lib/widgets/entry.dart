import 'package:flutter/material.dart';
import 'package:fooder_web/models/entry.dart';
import 'dart:core';


class EntryWidget extends StatelessWidget {
  final Entry entry;

  const EntryWidget({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  entry.product.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Text("${entry.calories.toStringAsFixed(2)} kcal"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "carb: ${entry.carb.toStringAsFixed(2)}",
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                "fat: ${entry.fat.toStringAsFixed(2)}",
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                "protein: ${entry.protein.toStringAsFixed(2)}",
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                "amount: ${entry.grams.toStringAsFixed(2)}",
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
