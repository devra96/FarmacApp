import 'package:flutter/material.dart';

/// PROVIDER QUE CONTIENE LAS VARIABLES RELACIONADAS
/// CON EL MODO SUPERVISOR
/// 
class UsuarioSupervisor with ChangeNotifier{
  late bool _supervisoriniciado = false;  // PARA INDICAR SI HA INICIADO SESION O NO UN SUPERVISOR
  late bool _modosupervisor = false;      // PARA INDICAR SI UN SUPERVISOR VA A REALIZAR MODIFICACIONES EN LA AGENDA DE UN USUARIO
  // DATOS DE UN USUARIO SUPERVISOR
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