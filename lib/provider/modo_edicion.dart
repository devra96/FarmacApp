import 'package:flutter/material.dart';

class ModoEdicion with ChangeNotifier{
  late bool _modoedicion = false;
  late int _dosisconsumidas = 0;
  late bool _confirmacion = false;
  // late String _rutaimagen;
  late int _fotocamara = 0;
  late bool _addusuario; // PANTALLA_USUARIO
  late bool _cambiarpass;

  ModoEdicion();

  // GETTER
  bool get modoedicion => _modoedicion;
  int get dosisconsumidas => _dosisconsumidas;
  bool get confirmacion => _confirmacion;
  // String get rutaimagen => _rutaimagen;
  int get fotocamara => _fotocamara;
  bool get addusuario => _addusuario;
  bool get cambiarpass => _cambiarpass;

  // SETTER
  set modoedicion(bool value) {
    _modoedicion = value;
    notifyListeners();
  }

  set dosisconsumidas(int value) {
    _dosisconsumidas = value;
    notifyListeners();
  }

  set confirmacion(bool value) {
    _confirmacion = value;
    notifyListeners();
  }

  // set rutaimagen(String value){
  //   _rutaimagen = value;
  //   notifyListeners();
  // }

  set fotocamara(int value){
    _fotocamara = value;
    notifyListeners();
  }

  set addusuario(bool value){
    _addusuario = value;
    notifyListeners();
  }
  
  set cambiarpass(bool value){
    _cambiarpass = value;
    notifyListeners();
  }
}