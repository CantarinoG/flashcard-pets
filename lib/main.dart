import 'package:flashcard_pets/models/award.dart';
import 'package:flashcard_pets/models/collection.dart';
import 'package:flashcard_pets/models/flashcard.dart';
import 'package:flashcard_pets/models/pet.dart';
import 'package:flashcard_pets/models/pet_bio.dart';
import 'package:flashcard_pets/models/subject.dart';
import 'package:flashcard_pets/models/user.dart';
import 'package:flashcard_pets/providers/constants/avatar_data_provider.dart';
import 'package:flashcard_pets/providers/constants/award_data_provider.dart';
import 'package:flashcard_pets/providers/constants/i_data_provider.dart';
import 'package:flashcard_pets/providers/constants/pet_bio_data_provider.dart';
import 'package:flashcard_pets/providers/constants/subject_data_provider.dart';
import 'package:flashcard_pets/providers/dao/collection_dao.dart';
import 'package:flashcard_pets/providers/dao/flashcard_dao.dart';
import 'package:flashcard_pets/providers/dao/i_dao.dart';
import 'package:flashcard_pets/providers/dao/pet_dao.dart';
import 'package:flashcard_pets/providers/services/i_game_elements_calculations.dart';
import 'package:flashcard_pets/providers/services/i_id_provider.dart';
import 'package:flashcard_pets/providers/services/i_json_data_provider.dart';
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
    IDataProvider<Subject> subjectDataProvider = SubjectDataProvider();
    IDataProvider<Award> awardDataProvider = AwardDataProvider();
    IDataProvider<String> avatarDataProvider = AvatarDataProvider();
    IDataProvider<PetBio> petBioDataProvider = PetBioDataProvider();
    IDao<Collection> collectionDaoProvider = CollectionDao();
    IDao<Flashcard> flashcardDaoProvider = FlashcardDao();
    IDao<Pet> petDaoProvider = PetDao();
    IIdProvider idProvider = UuidProvider();
    Sm2Calculator sm2Provider = Sm2Calculator();
    IGameElementsCalculations gameElementCalcProvider =
        StandardGameElementsCalculations();
    IJsonDataProvider<User> userDataProvider = UserJsonDataProvider();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => subjectDataProvider),
        ChangeNotifierProvider(create: (_) => awardDataProvider),
        ChangeNotifierProvider(create: (_) => avatarDataProvider),
        ChangeNotifierProvider(create: (_) => petBioDataProvider),
        ChangeNotifierProvider(create: (_) => collectionDaoProvider),
        ChangeNotifierProvider(create: (_) => flashcardDaoProvider),
        ChangeNotifierProvider(create: (_) => petDaoProvider),
        ChangeNotifierProvider(create: (_) => idProvider),
        ChangeNotifierProvider(create: (_) => sm2Provider),
        ChangeNotifierProvider(create: (_) => userDataProvider),
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
