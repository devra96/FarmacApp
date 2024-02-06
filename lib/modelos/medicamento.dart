import 'dart:convert';

import 'package:http/http.dart' as http;

class Medicamento{
  int? _id;
  late int _id_usuario;
  late String _nombre;
  late int _diasconsumo;
  late int _dosisincluidas;
  late int _tiempoconsumo;
  late DateTime _fechahoraultimadosis;
  late DateTime _fechahoraproximadosis;
  // late Blob _imagen;
  late String _gestionadopor;
  late String _normasconsumo;
  late String _caracteristicas;

  Medicamento();

  Medicamento.fromMap(dynamic obj){
    this._id = obj["id"];
    this._id_usuario = obj["id_usuario"];
    this._nombre = obj["nombre"];
    this._diasconsumo = obj["diasconsumo"];
    this._dosisincluidas = obj["dosisincluidas"];
    this._tiempoconsumo = obj["tiempoconsumo"];
    this._fechahoraultimadosis = DateTime.parse(obj["fechahoraultimadosis"]);
    this._fechahoraproximadosis = DateTime.parse(obj["fechahoraproximadosis"]);
    // this._imagen = obj["imagen"];
    this._gestionadopor = obj["gestionadopor"];
    this._normasconsumo = obj["normasconsumo"];
    this._caracteristicas = obj["caracteristicas"];
  }

  // GETTERS
  int? get id => _id;
  int get id_usuario => _id_usuario;
  String get caracteristicas => _caracteristicas;
  String get normasconsumo => _normasconsumo;
  String get gestionadopor => _gestionadopor;
  // Blob get imagen => _imagen;
  DateTime get fechahoraultimadosis => _fechahoraultimadosis;
  DateTime get fechahoraproximadosis => _fechahoraproximadosis;
  int get tiempoconsumo => _tiempoconsumo;
  int get dosisincluidas => _dosisincluidas;
  int get diasconsumo => _diasconsumo;
  String get nombre => _nombre;

  // SETTERS
  set caracteristicas(String value) {
    _caracteristicas = value;
  }

  set normasconsumo(String value) {
    _normasconsumo = value;
  }

  set gestionadopor(String value) {
    _gestionadopor = value;
  }

  // set imagen(Blob value) {
  //   _imagen = value;
  // }

  set fechahoraultimadosis(DateTime value) {
    _fechahoraultimadosis = value;
  }

  set fechahoraproximadosis(DateTime value) {
    _fechahoraproximadosis = value;
  }

  set tiempoconsumo(int value) {
    _tiempoconsumo = value;
  }

  set dosisincluidas(int value) {
    _dosisincluidas = value;
  }

  set diasconsumo(int value) {
    _diasconsumo = value;
  }

  set nombre(String value) {
    _nombre = value;
  }

  set id_usuario(int value) {
    _id_usuario = value;
  }

  // Lectura de datos de la API
  Future<List<Medicamento>> getMedicamentosUsuario(int id_usuario) async{
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/medicamentos/get_medicamentos/$id_usuario'));
    if(response.statusCode == 200){
      List<Medicamento> medicamentos = [];
      Medicamento u = new Medicamento();
      // var json = jsonDecode(response.body);
      var data = json.decode(response.body);
      // print("JSON: ${data.length}");
      for(int i=0;i<data.length;i++){
        // print("HDUSIHISUDHUISDHUILSDHUILSDHUISDHUIDSHUILSD" + data[i]);
        u = Medicamento.fromMap(data[i]);
        // print(u);
        medicamentos.add(u);
        // print(data[i]);
      }
      // print("LISTA MEDICAMENTOS: $medicamentos");
      return medicamentos;
    }
    else{
      throw Exception('Error al leer datos de la API');
    }
  }
}