import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:genlink/screen/profile_setup.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Safe initialization with platform check
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      debugPrint('Firebase initialized successfully');
    }
  } catch (e) {
    debugPrint('Firebase init error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenLink',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,  // Add this for modern theming
      ),
      home: const ProfileSetupScreen(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: child!,
        );
      },  // This comma was missing
    );  // This closing parenthesis was missing
  }
}