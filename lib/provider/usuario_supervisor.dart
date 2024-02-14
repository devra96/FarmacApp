import 'package:flutter/material.dart';

class UsuarioSupervisor with ChangeNotifier{
  late bool _supervisoriniciado = false;
  late bool _modosupervisor = false;
  late int _id;
  late int _id_supervisor;
  late String _nombre;
  late String _correo;
  late String _password;

  UsuarioSupervisor();

  bool get supervisoriniciado => _supervisoriniciado;
  bool get modosupervisor => _modosupervisor;
  int get id => _id;
  int get id_supervisor => _id_supervisor;
  String get nombre => _nombre;
  String get correo => _correo;
  String get password => _password;

  set supervisoriniciado(bool value){
    _supervisoriniciado = value;
    notifyListeners();
  }

  set modosupervisor(bool value) {
    _modosupervisor = value;
    notifyListeners();
  }

  set id(int value) {
    _id = value;
    notifyListeners();
  }

  set id_supervisor(int value) {
    _id_supervisor = value;
    notifyListeners();
  }

  set nombre(String value) {
    _nombre = value;
    notifyListeners();
  }

  set correo(String value) {
    _correo = value;
    notifyListeners();
  }

  set password(String value) {
    _password = value;
    notifyListeners();
  }
}