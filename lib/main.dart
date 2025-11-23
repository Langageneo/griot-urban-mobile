import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:griot_urban_app/constants/colors.dart';
import 'package:griot_urban_app/screens/feed_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env'); // Charge les variables d'environnement
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Griot Urban Culture',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const FeedScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
