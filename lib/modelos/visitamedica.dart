import 'dart:convert';
import 'package:http/http.dart' as http;

class VisitaMedica{
  int? _id;
  late int _id_usuario;
  late String _especialidad;
  late String _doctor;
  late String _lugar;
  late String _fechayhora;

  VisitaMedica();

  VisitaMedica.fromMap(dynamic obj){
    this._id = obj["id"];
    this._id_usuario = obj["id_usuario"];
    this._especialidad = obj["especialidad"];
    this._doctor = obj["doctor"];
    this._lugar = obj["lugar"];
    this._fechayhora = obj["fechayhora"];
  }

  // GETTERS
  int? get id => _id;
  int get id_usuario => _id_usuario;
  String get especialidad => _especialidad;
  String get doctor => _doctor;
  String get lugar => _lugar;
  String get fechayhora => _fechayhora;

  // SETTERS
  set id_usuario(int value) {
    _id_usuario = value;
  }
  set especialidad(String value) {
    _especialidad = value;
  }
  set doctor(String value) {
    _doctor = value;
  }
  set lugar(String value) {
    _lugar = value;
  }
  set fechayhora(String value) {
    _fechayhora = value;
  }

  // GET Visitas medicas
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
      throw Exception('Error al leer datos de la API');
    }
  }
}