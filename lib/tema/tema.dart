import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// CLASE QUE CONTIENE LOS TEMAS DE LA APLICACION.
/// 
/// LA CONFIGURACION DEL TEMA ESTABLECIDO EN LA APLICACION
/// SE GUARDA EN SHARED PREFERENCES.
///
class Tema extends ChangeNotifier{
  ThemeData _themeData = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF009638),
      secondary: Colors.deepOrange,
      surface: Colors.white,
      background: Colors.white,
      error: Colors.red,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
    ),
  );

  final ThemeData _temaClaro = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: Colors.green,
      secondary: Colors.deepOrange,
      surface: Colors.white,
      background: Colors.white,
      error: Colors.red,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
    ),
  );
  
  final ThemeData _temaOscuro = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.dark(
      primary: Colors.green,
      secondary: Colors.greenAccent,
      surface: Colors.grey[800]!,
      background: Colors.black,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
    ),
  );

  ThemeData getTheme() => _themeData;

  void toggleTheme() {
    _themeData = _themeData == _temaClaro ? _temaOscuro : _temaClaro;
    saveTheme();
    notifyListeners();
  }

  void saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', _themeData == _temaOscuro);
  }

  Future<void> loadTheme(SharedPreferences prefs) async {
    bool darkMode = prefs.getBool('darkMode') ?? false;
    _themeData = darkMode ? _temaOscuro : _temaClaro;
    notifyListeners();
  }
}