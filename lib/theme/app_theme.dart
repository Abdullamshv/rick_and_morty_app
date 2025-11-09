import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color(0xFF00E5FF), // неоновый голубой
    scaffoldBackgroundColor: const Color(0xFFF2F5FA),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF00E5FF),
      secondary: Color(0xFF8E2DE2),
      surface: Color(0xFFFFFFFF),
      background: Color(0xFFF2F5FA),
      error: Color(0xFFFF5252),
    ),
    appBarTheme: AppBarTheme(
      elevation: 4,
      backgroundColor: const Color(0xFF0F2027),
      foregroundColor: Colors.white,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontFamily: 'Orbitron',
        fontSize: 20,
        letterSpacing: 1.2,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      shadowColor: Colors.cyanAccent.withOpacity(0.3),
    ),
    cardTheme: CardThemeData(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white.withOpacity(0.85),
      shadowColor: Colors.cyanAccent.withOpacity(0.3),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF0F2027),
      selectedItemColor: Color(0xFF00E5FF),
      unselectedItemColor: Color(0xFF7F8C8D),
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Orbitron',
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'RobotoMono',
        color: Colors.black54,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF00E5FF),
      foregroundColor: Colors.black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF00E5FF),
    scaffoldBackgroundColor: const Color(0xFF0B0C10),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF00E5FF),
      secondary: Color(0xFF8E2DE2),
      surface: Color(0xFF1F2833),
      background: Color(0xFF0B0C10),
      error: Color(0xFFFF5252),
    ),
    appBarTheme: AppBarTheme(
      elevation: 6,
      backgroundColor: const Color(0xFF1F2833),
      foregroundColor: Colors.white,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontFamily: 'Orbitron',
        fontSize: 20,
        letterSpacing: 1.2,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      shadowColor: Colors.cyanAccent.withOpacity(0.3),
    ),
    cardTheme: CardThemeData(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: const Color(0xFF1F2833),
      shadowColor: Colors.cyanAccent.withOpacity(0.3),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1F2833),
      selectedItemColor: Color(0xFF00E5FF),
      unselectedItemColor: Color(0xFF7F8C8D),
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: 'Orbitron',
        color: Colors.white70,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'RobotoMono',
        color: Colors.white60,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF00E5FF),
      foregroundColor: Colors.black,
    ),
  );

  static void toggleTheme() {
    Get.changeThemeMode(
      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
  }

  static bool get isDarkMode => Get.isDarkMode;
}
