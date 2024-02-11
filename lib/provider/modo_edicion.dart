import 'package:flutter/material.dart';

class ModoEdicion with ChangeNotifier{
  late bool _modoedicion = false;

  ModoEdicion(){}

  // GETTER
  bool get modoedicion => _modoedicion;

  // SETTER
  set modoedicion(bool value) {
    _modoedicion = value;
    notifyListeners();
  }
}