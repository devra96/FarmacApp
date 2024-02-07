import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Usuario with ChangeNotifier{
  late int _id;
  int? _id_supervisor;
  late String _nombre;
  late String _correo;
  late String _password;

  // CONSTRUCTOR VACIO?
  // Usuario(
  //     this._id,
  //     this._nombre,
  //     this._correo,
  //     this._password
  // );

  Usuario(){
    // this._id = 0;
    // this._id_supervisor = 0;
    // this._nombre = "";
    // this._correo = "";
    // this._password = "";
  }

  // CONSTRUCTOR SIN ID
  // Usuario.sinId(int id_supervisor, String nombre, String correo, String password){
  //   this._id_supervisor = id_supervisor;
  //   this._nombre = nombre;
  //   this._correo = correo;
  //   this._password = password;
  // }

  // CONSTRUCTOR A PARTIR DE MAP
  Usuario.fromMap(dynamic obj){
    this._id = obj['id'];
    this._id_supervisor = obj['id_supervisor'];
    this._nombre = obj['nombre'];
    this._correo = obj['correo'];
    this._password = obj['password'];
  }

  // Usuario.sinId({required this.nombre, required this.correo, required this.password});

  // NO PUEDO CREAR UN CONSTRUCTOR QUE NO TENGA TODOS LOS ATRIBUTOS??
  // Usuario.sinId(this.nombre, this.correo, this.password): this.id = 1;

  // GETTERS
  // int? get id => _id;
  // int? get id_supervisor => _id_supervisor;
  int get id => _id;
  int? get id_supervisor => _id_supervisor;
  String get nombre => _nombre;
  String get correo => _correo;
  String get password => _password;

  // SETTERS

  set id(int value) {
    _id = value;
    notifyListeners();
  }

  set id_supervisor(int? value) {
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

  Map<String, dynamic> toMap(){
    return {"id":_id, "id_supervisor":_id_supervisor, "nombre":_nombre, "correo":_correo, "password":_password};
  }

  // [GET] COMPROBACION DE LOGIN 
  Future<String> checkUsuario(String correo, String password) async{
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/usuario/check_usuario?correo=$correo&password=$password'));
    if(response.statusCode == 200){
      String data = response.body;
      if(data != "null"){
        var json = jsonDecode(data);
        // Usuario u = new Usuario();
        // u = Usuario.fromMap(json[0]);
        // int? id = u.id;
        // print(id);
        print(json["id"]);
        return json["id"].toString();
      }
      return "no";
    }
    else{
      throw Exception('Error al leer datos de la API');
    }
  }

  // [GET] COMPROBACION DE USUARIO EXISTENTE
  Future<int> checkUsuarioExistente(String correo) async{
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/usuario/check_usuario_existente?correo=$correo'));
    if(response.statusCode == 200){
      String data = response.body;
      if(data != "null"){
        var json = jsonDecode(data);
        return json["id"];
      }
      return 0;
    }
    else{
      throw Exception('Error al leer datos de la API');
    }
  }

  // [GET] RECUPERACION DE USUARIO 
  Future<Usuario> getUsuario(String correo, String password) async{
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/usuario/check_usuario?correo=$correo&password=$password'));
    if(response.statusCode == 200){
      String data = response.body;
      Usuario u = new Usuario();
      if(data != "null"){
        var json = jsonDecode(data);
        u = Usuario.fromMap(json);
        // int? id = u.id;
        // print(id);
        // print(json["id"]);
        // return json["id"].toString();
        // return u;
      }
      return u;
    }
    else{
      throw Exception('Error al leer datos de la API');
    }
  }

  // [POST] CREAR UN USUARIO
  Future<Usuario> createUsuario(String nombre, String correo, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/usuario/add_usuario'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre': nombre,
        'correo': correo,
        'password': password
      }),
    );

    if(response.statusCode == 200){
      Usuario u = new Usuario.fromMap(jsonDecode(response.body));
      return u;
    }
    else{
      throw Exception('Fallo al crear el usuario.');
    }
  }

  // [PATCH] AÑADIR EL id_supervisor AL USUARIO INDICADO
  Future<void> updateUsuario_idSupervisor(int id_supervisor) async {
    final response = await http.patch(
      Uri.parse('http://10.0.2.2:8000/usuario/mod_usuario/$id_supervisor'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_supervisor': id_supervisor,
      }),
    );

    if (response.statusCode == 200) {
      // Usuario u = new Usuario.fromMap(jsonDecode(response.body));
      // return u;

      print("AÑADIDO id_supervisor CORRECTAMENTE");
    }
    else{
      throw Exception('Fallo al añadir el id_supervidor al usuario.');
    }
  }
}