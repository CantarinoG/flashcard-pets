import 'package:flutter/material.dart';

class ThemedBottomNavBar extends StatelessWidget {
  final int _currentIndex;
  final Function(int) _onItemTapped;
  const ThemedBottomNavBar(this._currentIndex, this._onItemTapped, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? bodyStyle = Theme.of(context).textTheme.bodySmall;
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onItemTapped,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      selectedLabelStyle: bodyStyle,
      unselectedLabelStyle: bodyStyle,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "Principal",
            backgroundColor: primaryColor),
        BottomNavigationBarItem(
            icon: const Icon(Icons.pets),
            label: "Pets",
            backgroundColor: primaryColor),
        BottomNavigationBarItem(
            icon: const Icon(Icons.diversity_3),
            label: "Social",
            backgroundColor: primaryColor),
        BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "Perfil",
            backgroundColor: primaryColor),
      ],
    );
  }
}
