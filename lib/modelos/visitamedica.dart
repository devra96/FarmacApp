import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VisitaMedica with ChangeNotifier{
  late int _id;
  late int _id_usuario;
  late String _gestionadopor;
  late String _especialidad;
  late String _doctor;
  late String _lugar;
  late String _fechayhora;

  VisitaMedica();

  VisitaMedica.fromMap(dynamic obj){
    this._id = obj["id"];
    this._id_usuario = obj["id_usuario"];
    this._gestionadopor = obj["gestionadopor"];
    this._especialidad = obj["especialidad"];
    this._doctor = obj["doctor"];
    this._lugar = obj["lugar"];
    this._fechayhora = obj["fechayhora"];
  }

  // GETTERS
  int get id => _id;
  int get id_usuario => _id_usuario;
  String get gestionadopor => _gestionadopor;
  String get especialidad => _especialidad;
  String get doctor => _doctor;
  String get lugar => _lugar;
  String get fechayhora => _fechayhora;

  // SETTERS
  set id(int value) {
    _id = value;
    notifyListeners();
  }
  set id_usuario(int value) {
    _id_usuario = value;
    notifyListeners();
  }
  set gestionadopor(String value){
    _gestionadopor = value;
    notifyListeners();
  }
  set especialidad(String value) {
    _especialidad = value;
    notifyListeners();
  }
  set doctor(String value) {
    _doctor = value;
    notifyListeners();
  }
  set lugar(String value) {
    _lugar = value;
    notifyListeners();
  }
  set fechayhora(String value) {
    _fechayhora = value;
    notifyListeners();
  }

  // [GET] RECUPERACION DE LAS VISITAS MEDICAS DE UN USUARIO SEGUN SU ID
  Future<List<VisitaMedica>> getVisitasMedicasUsuario(int id_usuario) async{
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/visitasmedicas/get_visitasmedicas/$id_usuario'));
    if(response.statusCode == 200){
      List<VisitaMedica> visitasmedicas = [];
      VisitaMedica u = new VisitaMedica();
      var data = json.decode(response.body);
      for(int i=0;i<data.length;i++){
        u = VisitaMedica.fromMap(data[i]);
        visitasmedicas.add(u);
      }
      return visitasmedicas;
    }
    else{
      throw Exception('Error al leer las visitas medicas');
    }
  }

  // [POST] AÑADIR UNA VISITA MEDICA
  Future<VisitaMedica> createVisitaMedica(int id_usuario, String gestionadopor, String especialidad, String doctor, String lugar, String fechayhora) async{
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/visitasmedicas/add_visitamedica'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "id_usuario": id_usuario,
        "gestionadopor": gestionadopor,
        "especialidad": especialidad,
        "doctor": doctor,
        "lugar": lugar,
        "fechayhora": fechayhora
      }),
    );

    if(response.statusCode == 200){
      VisitaMedica v = new VisitaMedica.fromMap(jsonDecode(response.body));
      return v;
    }
    else{
      throw Exception('Fallo al crear la visita medica.');
    }
  }

  // [PATCH] MODIFICAR UNA VISITA MEDICA
  Future<void> updateVisitaMedica(int id_visitamedica, String gestionadopor, String especialidad, String doctor, String lugar, String fechayhora) async{
      final response = await http.patch(
      Uri.parse('http://10.0.2.2:8000/visitasmedicas/mod_visitamedica/$id_visitamedica'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "id": id_visitamedica,
        // "id_usuario": id_usuario,
        "gestionadopor": gestionadopor,
        "especialidad": especialidad,
        "doctor": doctor,
        "lugar": lugar,
        "fechayhora": fechayhora
      }),
    );

    if(response.statusCode == 200){
      // VisitaMedica v = new VisitaMedica.fromMap(jsonDecode(response.body));
      // return v;

      print("VISITA MEDICA MODIFICADA CORRECTAMENTE.");
    }
    else{
      throw Exception('Fallo al modificar la visita medica.');
    }
  }

  // [DELETE] BORRAR UNA VISITA MEDICA
  Future<void> deleteVisitaMedica(int id_visitamedica) async{
    final response = await http.delete(
      Uri.parse('http://10.0.2.2:8000/visitasmedicas/del_visitamedica/$id_visitamedica'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if(response.statusCode == 200){
      print("VISITA MEDICA ELIMINADA CORRECTAMENTE.");
    }
    else {
      throw Exception('Fallo al intentar eliminar la visita medica.');
    }
  }
}