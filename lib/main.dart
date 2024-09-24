import 'package:flashcard_pets/models/award.dart';
import 'package:flashcard_pets/models/collection.dart';
import 'package:flashcard_pets/models/subject.dart';
import 'package:flashcard_pets/providers/constants/avatar_data_provider.dart';
import 'package:flashcard_pets/providers/constants/award_data_provider.dart';
import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flashcard_pets/providers/constants/subject_data_provider.dart';
import 'package:flashcard_pets/providers/dao/collection_dao.dart';
import 'package:flashcard_pets/providers/dao/i_dao.dart';
import 'package:flashcard_pets/screens/navigation_screen.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //Mocked data
  final bool _isLightMode = false;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    IDataProvider<Subject> subjectDataProvider = SubjectDataProvider();
    IDataProvider<Award> awardDataProvider = AwardDataProvider();
    IDataProvider<String> avatarDataProvider = AvatarDataProvider();
    IDao<Collection> collectionDaoProvider = CollectionDao();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => subjectDataProvider),
        ChangeNotifierProvider(create: (_) => awardDataProvider),
        ChangeNotifierProvider(create: (_) => avatarDataProvider),
        ChangeNotifierProvider(create: (_) => collectionDaoProvider),
      ],
      child: MaterialApp(
        title: 'Flashcard Pets',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: _isLightMode ? ThemeMode.light : ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: NavigationScreen(),
      ),
    );
  }
}
