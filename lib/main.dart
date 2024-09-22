import 'package:flashcard_pets/data_providers/i_data_provider.dart';
import 'package:flashcard_pets/data_providers/subject_data_provider.dart';
import 'package:flashcard_pets/models/subject.dart';
import 'package:flashcard_pets/screens/navigation_screen.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    IDataProvider<Subject> subjectDataProvider = SubjectDataProvider();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => subjectDataProvider),
      ],
      child: MaterialApp(
        title: 'Flashcard Pets',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: NavigationScreen(),
      ),
    );
  }
}
