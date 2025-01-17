import 'package:firebase_core/firebase_core.dart';
import 'package:flashcard_pets/firebase_options.dart';
import 'package:flashcard_pets/providers/constants/avatar_data_provider.dart';
import 'package:flashcard_pets/providers/constants/award_data_provider.dart';
import 'package:flashcard_pets/providers/constants/pet_bio_data_provider.dart';
import 'package:flashcard_pets/providers/constants/subject_data_provider.dart';
import 'package:flashcard_pets/providers/dao/collection_dao.dart';
import 'package:flashcard_pets/providers/dao/flashcard_dao.dart';
import 'package:flashcard_pets/providers/dao/media_dao.dart';
import 'package:flashcard_pets/providers/dao/pet_dao.dart';
import 'package:flashcard_pets/providers/services/base_64_conversor.dart';
import 'package:flashcard_pets/providers/services/firebase_auth_provider.dart';
import 'package:flashcard_pets/providers/services/firebase_social_provider.dart';
import 'package:flashcard_pets/providers/services/sm2_calculator.dart';
import 'package:flashcard_pets/providers/services/standard_game_elements_calculations.dart';
import 'package:flashcard_pets/providers/services/sync_provider.dart';
import 'package:flashcard_pets/providers/services/user_json_data_provider.dart';
import 'package:flashcard_pets/providers/services/uuid_provider.dart';
import 'package:flashcard_pets/screens/navigation_screen.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Error initializing Firebase: $e");
  }

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
    MediaDao mediaDaoProvider = MediaDao();

    UserJsonDataProvider userDataProvider = UserJsonDataProvider();

    UuidProvider idProvider = UuidProvider();
    Sm2Calculator sm2Provider = Sm2Calculator();
    StandardGameElementsCalculations gameElementCalcProvider =
        StandardGameElementsCalculations();
    Base64Conversor base64ConversorProvider = Base64Conversor();
    FirebaseAuthProvider firebaseAuthProvider = FirebaseAuthProvider();
    SyncProvider syncProvider = SyncProvider();
    FirebaseSocialProvider firebaseSocialProvider = FirebaseSocialProvider();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => subjectDataProvider),
        ChangeNotifierProvider(create: (_) => awardDataProvider),
        ChangeNotifierProvider(create: (_) => avatarDataProvider),
        ChangeNotifierProvider(create: (_) => petBioDataProvider),
        ChangeNotifierProvider(create: (_) => collectionDaoProvider),
        ChangeNotifierProvider(create: (_) => flashcardDaoProvider),
        ChangeNotifierProvider(create: (_) => petDaoProvider),
        ChangeNotifierProvider(create: (_) => mediaDaoProvider),
        ChangeNotifierProvider(create: (_) => userDataProvider),
        ChangeNotifierProvider(create: (_) => idProvider),
        ChangeNotifierProvider(create: (_) => sm2Provider),
        ChangeNotifierProvider(create: (_) => gameElementCalcProvider),
        ChangeNotifierProvider(create: (_) => base64ConversorProvider),
        ChangeNotifierProvider(create: (_) => firebaseAuthProvider),
        ChangeNotifierProvider(create: (_) => syncProvider),
        ChangeNotifierProvider(create: (_) => firebaseSocialProvider),
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
