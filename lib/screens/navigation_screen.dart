import 'package:flashcard_pets/screens/collections_main_screen.dart';
import 'package:flashcard_pets/screens/pets_collection_screen.dart';
import 'package:flashcard_pets/screens/self_profile_screen.dart';
import 'package:flashcard_pets/screens/social_screen.dart';
import 'package:flashcard_pets/widgets/themed_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  final List<Map<String, dynamic>> _navigationData = [
    {
      "widget": const CollectionsMainScreen(),
      "appBar": const CollectionMainAppBar(),
      "fab": const CollectionMainFab(),
    },
    {
      "widget": const PetsCollectionScreen(),
      "appBar": const PetsCollectionAppBar(),
      "fab": const PetsCollectionFab(),
    },
    {
      "widget": const SocialScreen(),
      "appBar": const SocialAppBar(),
      "fab": const SocialFab(),
    },
    {
      "widget": SelfProfileScreen(),
      "appBar": const SelfProfileAppBar(),
      "fab": null,
    },
  ];

  NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget._navigationData[_currentIndex]["appBar"],
      body: widget._navigationData[_currentIndex]["widget"],
      bottomNavigationBar: ThemedBottomNavBar(_currentIndex, _onItemTapped),
      floatingActionButton: widget._navigationData[_currentIndex]["fab"],
    );
  }
}
