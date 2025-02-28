import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:umbrella_care/core/app_core.dart';
import 'package:umbrella_care/core/utils/screen_utils.dart';
import 'package:umbrella_care/src/splashScreen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtils.init(
      context,
      designSize: const Size(393, 852),
    );
    return KhaltiScope(
      publicKey: AppCore.khaltiPublicKey,
      builder: (context, navigatorKey) => MaterialApp(
        navigatorKey: navigatorKey,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ne', 'NP'),
        ],
        localizationsDelegates: const [KhaltiLocalizations.delegate],
        debugShowCheckedModeBanner: false,
        theme: _themeData,
        home: const SplashScreen(),
      ),
    );
  }
}

ThemeData _themeData = ThemeData().copyWith(
  scaffoldBackgroundColor: AppColors.white,
  textTheme: GoogleFonts.poppinsTextTheme(),
);
