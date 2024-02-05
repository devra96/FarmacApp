import 'dart:convert';

import 'package:http/http.dart' as http;

class Usuario{
  int? _id;
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
    this._id = 0;
    this._nombre = "";
    this._correo = "";
    this._password = "";
  }

  // CONSTRUCTOR SIN ID
  Usuario.sinId(String nombre, String correo, String password){
    this._nombre = nombre;
    this._correo = correo;
    this._password = password;
  }

  // CONSTRUCTOR A PARTIR DE MAP
  Usuario.fromMap(dynamic obj){
    this._id = obj['id'];
    this._nombre = obj['nombre'];
    this._correo = obj['correo'];
    this._password = obj['password'];
  }

  // Usuario.sinId({required this.nombre, required this.correo, required this.password});

  // NO PUEDO CREAR UN CONSTRUCTOR QUE NO TENGA TODOS LOS ATRIBUTOS??
  // Usuario.sinId(this.nombre, this.correo, this.password): this.id = 1;

  // GETTERS
  int? get id => _id;
  String get nombre => _nombre;
  String get correo => _correo;
  String get password => _password;

  // SETTERS
  set nombre(String value) {
    _nombre = value;
  }

  set correo(String value) {
    _correo = value;
  }

  set password(String value) {
    _password = value;
  }

  Map<String, dynamic> toMap(){
    return {"id":_id, "nombre":_nombre, "correo":_correo, "password":_password};
  }

  // Lectura de datos de la API
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
}