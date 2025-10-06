import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  
  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  ThemeData get lightTheme => ThemeData(
    primaryColor: const Color(0xFFF0B81B),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFF0B81B),
      secondary: Colors.black,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    useMaterial3: true,
  );

  ThemeData get darkTheme => ThemeData.dark().copyWith(
    primaryColor: const Color(0xFFF0B81B),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFFF0B81B),
      secondary: const Color(0xFFf8d47a),
      surface: Colors.grey[900]!,
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900]!,
      elevation: 0,
    ),
  );
}// TODO Implement this library.