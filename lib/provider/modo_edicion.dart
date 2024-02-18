import 'package:flutter/material.dart';

/// PROVIDER QUE CONTIENE DIFERENTES VARIABLES QUE SE
/// USARAN PARA MODIFICAR DATOS.
class ModoEdicion with ChangeNotifier{
  late bool _modoedicion = false;   // PARA ENTRAR EN MODO AÑADIR O MODIFICAR
  late int _dosisconsumidas = 0;    // SI MODIFICAMOS LAS DOSIS INCLUIDAS DE UN MEDICAMENTO, GUARDA LAS RESTANTES
  late bool _confirmacion = false;  // PARA CONFIRMAR O NO UNA ACCION
  late int _fotocamara = 0;         // PARA SI ACTIVAMOS LA CAMARA O LA GALERIA AL MODIFICAR LA IMAGEN DE UN MEDICAMENTO
  late bool _addusuario;            // SE USA EN PANTALLA_USUARIO
  late bool _cambiarpass;           // PARA SI CAMBIAMOS O NO LA CONTRASEÑA DEL USUARIO

  ModoEdicion();

  // GETTER
  bool get modoedicion => _modoedicion;
  int get dosisconsumidas => _dosisconsumidas;
  bool get confirmacion => _confirmacion;
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