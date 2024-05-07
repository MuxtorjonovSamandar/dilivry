import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xizmatdamiz/frontend/screens/home/home.dart';
import 'package:xizmatdamiz/frontend/screens/verification/emailverify.dart';

import 'package:xizmatdamiz/frontend/style/color.dart';
import 'package:xizmatdamiz/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(
        fontFamily: GoogleFonts.rubik().fontFamily,
        iconTheme: IconThemeData(color: RGBcolor().mainColor),
      ),
    );
  }
}
