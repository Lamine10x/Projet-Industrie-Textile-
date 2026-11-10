import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app_colors.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const JCocoManagementApp());
}

class JCocoManagementApp extends StatelessWidget {
  const JCocoManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.plusJakartaSansTextTheme(
      Theme.of(context).textTheme,
    );

    return MaterialApp(
      title: 'JCOCO Management APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.terracotta,
          primary: AppColors.terracotta,
          secondary: AppColors.indigo900,
          surface: const Color(0xFFFBF9F5),
        ),
        textTheme: textTheme,
        scaffoldBackgroundColor: const Color(0xFFFBF9F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFBF9F5),
          elevation: 0,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
