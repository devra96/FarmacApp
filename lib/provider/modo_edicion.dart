import 'package:flutter/material.dart';

class ModoEdicion with ChangeNotifier{
  late bool _modoedicion = false;
  late int _dosisconsumidas = 0;
  late bool _eliminar = false;
  // late String _rutaimagen;
  late int _fotocamara = 0;

  ModoEdicion(){}

  // GETTER
  bool get modoedicion => _modoedicion;
  int get dosisconsumidas => _dosisconsumidas;
  bool get eliminar => _eliminar;
  // String get rutaimagen => _rutaimagen;
  int get fotocamara => _fotocamara;

  // SETTER
  set modoedicion(bool value) {
    _modoedicion = value;
    notifyListeners();
  }

  set dosisconsumidas(int value) {
    _dosisconsumidas = value;
    notifyListeners();
  }

  set eliminar(bool value) {
    _eliminar = value;
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
}