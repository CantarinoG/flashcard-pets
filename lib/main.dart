import 'package:flashcard_pets/providers/constants/avatar_data_provider.dart';
import 'package:flashcard_pets/providers/constants/award_data_provider.dart';
import 'package:flashcard_pets/providers/constants/pet_bio_data_provider.dart';
import 'package:flashcard_pets/providers/constants/subject_data_provider.dart';
import 'package:flashcard_pets/providers/dao/collection_dao.dart';
import 'package:flashcard_pets/providers/dao/flashcard_dao.dart';
import 'package:flashcard_pets/providers/dao/pet_dao.dart';
import 'package:flashcard_pets/providers/services/sm2_calculator.dart';
import 'package:flashcard_pets/providers/services/standard_game_elements_calculations.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/providers/services/uuid_provider.dart';
import 'package:flashcard_pets/screens/navigation_screen.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    SubjectDataProvider subjectDataProvider = SubjectDataProvider();
    AwardDataProvider awardDataProvider = AwardDataProvider();
    AvatarDataProvider avatarDataProvider = AvatarDataProvider();
    PetBioDataProvider petBioDataProvider = PetBioDataProvider();

    CollectionDao collectionDaoProvider = CollectionDao();
    FlashcardDao flashcardDaoProvider = FlashcardDao();
    PetDao petDaoProvider = PetDao();

    UserJsonDataProvider userDataProvider = UserJsonDataProvider();

    UuidProvider idProvider = UuidProvider();
    Sm2Calculator sm2Provider = Sm2Calculator();
    StandardGameElementsCalculations gameElementCalcProvider =
        StandardGameElementsCalculations();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => subjectDataProvider),
        ChangeNotifierProvider(create: (_) => awardDataProvider),
        ChangeNotifierProvider(create: (_) => avatarDataProvider),
        ChangeNotifierProvider(create: (_) => petBioDataProvider),
        ChangeNotifierProvider(create: (_) => collectionDaoProvider),
        ChangeNotifierProvider(create: (_) => flashcardDaoProvider),
        ChangeNotifierProvider(create: (_) => petDaoProvider),
        ChangeNotifierProvider(create: (_) => userDataProvider),
        ChangeNotifierProvider(create: (_) => idProvider),
        ChangeNotifierProvider(create: (_) => sm2Provider),
        ChangeNotifierProvider(create: (_) => gameElementCalcProvider),
      ],
      child: MaterialApp(
        title: 'Flashcard Pets',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: _themeMode,
        debugShowCheckedModeBanner: false,
        home: NavigationScreen(),
      ),
    );
  }
}
