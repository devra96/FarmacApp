class Usuario{
  int id;
  String nombre;
  String correo;
  String password;

  Usuario({required this.id, required this.nombre, required this.correo, required this.password});

  // Usuario(String nombre, String correo, String password){
  //   this.nombre = nombre;
  //   this.correo = correo;
  //   this.password = password;
  // }

  // NO PUEDO CREAR UN CONSTRUCTOR QUE NO TENGA TODOS LOS ATRIBUTOS??
  // Usuario.sinId(this.nombre, this.correo, this.password): this.id = 1;

  Map<String, dynamic> toMap(){
    return {"id":id, "nombre":nombre, "correo":correo, "password":password};
  }
}