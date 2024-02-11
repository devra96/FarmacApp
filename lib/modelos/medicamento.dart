import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Medicamento with ChangeNotifier{
  int? _id;
  late int _id_usuario;
  late String _nombre;
  // late int _diasconsumo;
  late int _dosisincluidas;
  late int _dosisrestantes;
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
    // this._diasconsumo = obj["diasconsumo"];
    this._dosisincluidas = obj["dosisincluidas"];
    this._dosisrestantes = obj["dosisrestantes"];
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
  String get nombre => _nombre;
  // int get diasconsumo => _diasconsumo;
  int get dosisincluidas => _dosisincluidas;
  int get dosisrestantes => _dosisrestantes;
  int get tiempoconsumo => _tiempoconsumo;
  DateTime get fechahoraultimadosis => _fechahoraultimadosis;
  DateTime get fechahoraproximadosis => _fechahoraproximadosis;
  // Blob get imagen => _imagen;
  String get gestionadopor => _gestionadopor;
  String get normasconsumo => _normasconsumo;
  String get caracteristicas => _caracteristicas;
  

  // SETTERS
  set caracteristicas(String value) {
    _caracteristicas = value;
    notifyListeners();
  }

  set normasconsumo(String value) {
    _normasconsumo = value;
    notifyListeners();
  }

  set gestionadopor(String value) {
    _gestionadopor = value;
    notifyListeners();
  }

  // set imagen(Blob value) {
  //   _imagen = value;
  // }

  set fechahoraultimadosis(DateTime value) {
    _fechahoraultimadosis = value;
    notifyListeners();
  }

  set fechahoraproximadosis(DateTime value) {
    _fechahoraproximadosis = value;
    notifyListeners();
  }

  set tiempoconsumo(int value) {
    _tiempoconsumo = value;
    notifyListeners();
  }

  set dosisrestantes(int value) {
    _dosisrestantes = value;
    notifyListeners();
  }

  set dosisincluidas(int value) {
    _dosisincluidas = value;
    notifyListeners();
  }

  // set diasconsumo(int value) {
  //   _diasconsumo = value;
  //   notifyListeners();
  // }

  set nombre(String value) {
    _nombre = value;
    notifyListeners();
  }

  set id_usuario(int value) {
    _id_usuario = value;
    notifyListeners();
  }

  set id(int? value) {
    _id = value;
    notifyListeners();
  }

  // [GET] RECUPERACION DE LOS MEDICAMENTOS DE UN USUARIO SEGUN SU ID
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

  // [POST] AÑADIR UN MEDICAMENTO
  Future<Medicamento> createMedicamento(int id_usuario, String nombre, int dosis, int horas, DateTime fechahoraultimadosis, DateTime fechahoraproximadosis, String gestionadopor, String normasconsumo, String caracteristicas) async {
    // CONVERSION FECHAHORA ULTIMA DOSIS A INT (PARA QUE LO RECONOZCA LA API)
    String sfud = "${fechahoraultimadosis.year}";
    if(fechahoraultimadosis.month < 10){
      sfud += "0${fechahoraultimadosis.month}";
    }
    else{
      sfud += "${fechahoraultimadosis.month}";
    }

    if(fechahoraultimadosis.day < 10){
      sfud += "0${fechahoraultimadosis.day}";
    }
    else{
      sfud += "${fechahoraultimadosis.day}";
    }

    if(fechahoraultimadosis.hour < 10){
      sfud += "0${fechahoraultimadosis.hour}";
    }
    else{
      sfud += "${fechahoraultimadosis.hour}";
    }

    if(fechahoraultimadosis.minute < 10){
      sfud += "0${fechahoraultimadosis.minute}00";
    }
    else{
      sfud += "${fechahoraultimadosis.minute}00";
    }
    int fud = int.parse(sfud);

    // CONVERSION FECHAHORA PROXIMA DOSIS A INT (PARA QUE LO RECONOZCA LA API)
    String sfpd = "${fechahoraproximadosis.year}";
    if(fechahoraproximadosis.month < 10){
      sfpd += "0${fechahoraproximadosis.month}";
    }
    else{
      sfpd += "${fechahoraproximadosis.month}";
    }

    if(fechahoraproximadosis.day < 10){
      sfpd += "0${fechahoraproximadosis.day}";
    }
    else{
      sfpd += "${fechahoraproximadosis.day}";
    }

    if(fechahoraproximadosis.hour < 10){
      sfpd += "0${fechahoraproximadosis.hour}";
    }
    else{
      sfpd += "${fechahoraproximadosis.hour}";
    }

    if(fechahoraproximadosis.minute < 10){
      sfpd += "0${fechahoraproximadosis.minute}00";
    }
    else{
      sfpd += "${fechahoraproximadosis.minute}00";
    }
    int fpd = int.parse(sfpd);
    
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/medicamentos/add_medicamento'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "id_usuario": id_usuario,
        "nombre": nombre,
        "dosisincluidas": dosis,
        "dosisrestantes": dosis,
        "tiempoconsumo": horas,
        "fechahoraultimadosis": fud,
        "fechahoraproximadosis": fpd,
        "gestionadopor": gestionadopor,
        "normasconsumo": normasconsumo,
        "caracteristicas": caracteristicas
      }),
    );

    if(response.statusCode == 200){
      Medicamento m = new Medicamento.fromMap(jsonDecode(response.body));
      return m;
    }
    else{
      throw Exception('Fallo al crear el medicamento.');
    }
  }

}