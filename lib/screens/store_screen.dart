import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/store_card.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/user_stats_header.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  void _buyBasicChest() {
    //...
  }

  void _buyMediumChest() {
    //...
  }

  void _buySuperiorChest() {
    //...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemedAppBar("Loja"),
      body: ScreenLayout(
        child: Column(
          children: [
            const UserStatsHeader(),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView(
                children: [
                  StoreCard(
                    "Baú Básico",
                    "Geralmente contém um pet de raridade comum. Pequena chance de conter um pet de raridade incomum.",
                    "assets/images/chests/chest0.png",
                    100,
                    0,
                    onBuy: _buyBasicChest,
                  ),
                  StoreCard(
                    "Baú Médio",
                    "Geralmente contém um pet de raridade incomum. Pequena chance de conter um pet de raridade rara.",
                    "assets/images/chests/chest1.png",
                    300,
                    10,
                    onBuy: _buyMediumChest,
                  ),
                  StoreCard(
                    "Baú Superior",
                    "Geralmente contém um pet de raridade rara. Pequena chance de conter um pet de raridade épica.",
                    "assets/images/chests/chest2.png",
                    500,
                    30,
                    onBuy: _buySuperiorChest,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
