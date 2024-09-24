import 'package:flashcard_pets/data_providers/avatar_data_provider.dart';
import 'package:flashcard_pets/data_providers/award_data_provider.dart';
import 'package:flashcard_pets/data_providers/i_data_provider.dart';
import 'package:flashcard_pets/data_providers/subject_data_provider.dart';
import 'package:flashcard_pets/models/award.dart';
import 'package:flashcard_pets/models/subject.dart';
import 'package:flashcard_pets/screens/navigation_screen.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //Mocked data
  final bool _isLightMode = true;
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    IDataProvider<Subject> subjectDataProvider = SubjectDataProvider();
    IDataProvider<Award> awardDataProvider = AwardDataProvider();
    IDataProvider<String> avatarDataProvider = AvatarDataProvider();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => subjectDataProvider),
        ChangeNotifierProvider(create: (_) => awardDataProvider),
        ChangeNotifierProvider(create: (_) => avatarDataProvider),
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
