import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tema extends ChangeNotifier{
  // ThemeData _themeData = ThemeData.light();
  ThemeData _themeData = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF009638), // Color primario
      secondary: Colors.deepOrange, // Color secundario
      surface: Colors.white, // Color de la superficie
      background: Colors.white, // Color de fondo
      error: Colors.red, // Color de error
      onPrimary: Colors.black, // Color del texto sobre el color primario
      onSecondary: Colors.black, // Color del texto sobre el color secundario
      onSurface: Colors.black, // Color del texto sobre la superficie
      onBackground: Colors.black, // Color del texto sobre el fondo
      onError: Colors.white, // Color del texto para indicar errores
    ),
  );
  

  final ThemeData _temaClaro = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary: Colors.green, // Color primario
      secondary: Colors.deepOrange, // Color secundario
      surface: Colors.white, // Color de la superficie
      background: Colors.white, // Color de fondo
      error: Colors.red, // Color de error
      onPrimary: Colors.black, // Color del texto sobre el color primario
      onSecondary: Colors.black, // Color del texto sobre el color secundario
      onSurface: Colors.black, // Color del texto sobre la superficie
      onBackground: Colors.black, // Color del texto sobre el fondo
      onError: Colors.white, // Color del texto para indicar errores
    ),
  );
  
  final ThemeData _temaOscuro = ThemeData.dark().copyWith(
    // Cambios en el esquema de colores
    colorScheme: ColorScheme.dark(
      primary: Colors.green, // Color primario
      // primaryVariant: Colors.green.shade700, // Variante del color primario
      secondary: Colors.greenAccent, // Color secundario
      // secondaryVariant: Colors.greenAccent.shade700, // Variante del color secundario
      surface: Colors.grey[800]!, // Color de la superficie
      background: Colors.black, // Color de fondo
      error: Colors.red, // Color de error
      onPrimary: Colors.white, // Color del texto sobre el color primario
      onSecondary: Colors.white, // Color del texto sobre el color secundario
      onSurface: Colors.white, // Color del texto sobre la superficie
      onBackground: Colors.white, // Color del texto sobre el fondo
      onError: Colors.white, // Color del texto para indicar errores
    ),
  );

  ThemeData getTheme() => _themeData;

  void toggleTheme() {
    // _themeData = _themeData == ThemeData.light() ? ThemeData.dark() : ThemeData.light();
    // _themeData = _themeData == ThemeData.light() ? _temaOscuro : ThemeData.light();
    _themeData = _themeData == _temaClaro ? _temaOscuro : _temaClaro;
    saveTheme();
    notifyListeners();
  }

  void saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setBool('darkMode', _themeData == ThemeData.dark());
    prefs.setBool('darkMode', _themeData == _temaOscuro);
  }

  Future<void> loadTheme(SharedPreferences prefs) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    bool darkMode = prefs.getBool('darkMode') ?? false;
    // _themeData = darkMode ? ThemeData.dark() : ThemeData.light();
    // _themeData = darkMode ? _temaOscuro : ThemeData.light();
    _themeData = darkMode ? _temaOscuro : _temaClaro;
    notifyListeners();
  }

  // ThemeData _temaClaro(){
  //   return (ThemeData.light().copyWith(
  //     colorScheme: ColorScheme(
  //       brightness: brightness,
  //       primary: primary,
  //       onPrimary: onPrimary,
  //       secondary: secondary,
  //       onSecondary: onSecondary,
  //       error: error,
  //       onError: onError,
  //       background: background,
  //       onBackground: onBackground,
  //       surface: surface, onSurface:
  //       onSurface
  //     )
  //   ));
  // }

  // ThemeData _temaOscuro(){
  //   return (ThemeData.light().copyWith(
  //     colorScheme: ColorScheme(
  //       primary: Colors.green, // Define el color primario (usado por defecto en botones)
  //       // primaryVariant: Colors.green.shade700, // Define la variante del color primario
  //       secondary: Colors.green, // Define el color secundario
  //       // secondaryVariant: Colors.green.shade700, // Define la variante del color secundario
  //       surface: Color(0xFF1E1E1E), // Define el color de la superficie
  //       background: Colors.white, // Define el color de fondo
  //       error: Colors.red, // Define el color de error
  //       onPrimary: Colors.white, // Define el color del texto en el color primario
  //       onSecondary: Colors.white, // Define el color del texto en el color secundario
  //       onSurface: Colors.black, // Define el color del texto en la superficie
  //       onBackground: Colors.black, // Define el color del texto en el fondo
  //       onError: Colors.white, // Define el color del texto en el error
  //       brightness: Brightness.light, // Define el brillo del tema
  //     )
  //   ));
  // }
}