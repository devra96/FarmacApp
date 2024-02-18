import 'package:farmacapp/modelos/medicamento.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/modelos/visitamedica.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BDHelper{
  static Database? _baseDatos;
  static const String nombreBD = "farmacapp.db";

  // INICIAMOS LA BASE DE DATOS
  Future<Database?> get baseDatos async{
    if(_baseDatos != null){
      return _baseDatos;
    }
    _baseDatos = await _inicializarBD();
    return _baseDatos;
  }

  _inicializarBD() async{
    var directorio = await getDatabasesPath();
    String path = directorio + nombreBD;
    var baseDatos = await openDatabase(
      path, 
      version: 1, 
      onCreate: (Database db, int version) async{
        // AÑADIMOS UN await db.execute() POR CADA TABLA QUE QUERAMOS AÑADIR
        await db.execute(
          "CREATE TABLE usuarios(id INTEGER PRIMARY KEY, id_supervisor INTEGER, nombre VARCHAR(30),correo VARCHAR(30),password VARCHAR(30))",
        );
        await db.execute(
          "CREATE TABLE medicamentos(id INTEGER PRIMARY KEY, id_usuario INTEGER, nombre VARCHAR(30), dosisincluidas INTEGER, dosisrestantes INTEGER, tiempoconsumo INTEGER, fechahoraultimadosis VARCHAR(30), fechahoraproximadosis VARCHAR(30), gestionadopor VARCHAR(20), normasconsumo VARCHAR(200), caracteristicas VARCHAR(200))",
        );
        await db.execute(
          "CREATE TABLE visitasmedicas(id INTEGER PRIMARY KEY, id_usuario INTEGER, gestionadopor VARCHAR(30), especialidad VARCHAR(30), doctor VARCHAR(30), lugar VARCHAR(30), fechayhora VARCHAR(30))",
        );
      }
    );
    return baseDatos;
  }

  // -------------------------------------------------- METODOS USUARIOS --------------------------------------------------

  // SELECT count(*) FROM tabla WHERE correo = ?
  Future<int> comprobarCorreo(String tabla, String correo) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.query(tabla, where: "correo = ?", whereArgs: [correo]);
    var res = resultado.length;
    return res;
  }

  // SELECT id FROM tabla WHERE correo = ? AND password = ?
  Future<String> comprobarLogin(String tabla, String correo, String password) async{
    String id = "";
    Database? bd = await baseDatos;
    var resultado = await bd!.query(tabla, where: "correo = ? AND password = ?", whereArgs: [correo,password]);
    // var res = resultado.length;
    for(int i=0;i<resultado.length;i++){
      id = resultado[i]["id"].toString();
    }
    return id;
  }

  // SELECT Usuario FROM tabla where correo = ? AND password = ?
  Future<Usuario> getUsuario(String tabla, String correo, String password) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.query(tabla, where: "correo = ? AND password = ?", whereArgs: [correo,password]);
    Usuario u = new Usuario();
    for(int i=0;i<resultado.length;i++){
      u = Usuario.fromMap(resultado[i]);
    }
    return u;
  }

  // SELECT * FROM usuarios WHERE id_supervisor = ?
  Future<List<Usuario>> getUsuariosSupervisor(int id_supervisor) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.query("usuarios", where: "id_supervisor = ?", whereArgs: [id_supervisor]);
    Usuario u = new Usuario();
    List<Usuario> usuarios = [];
    for(int i=0;i<resultado.length;i++){
      u = Usuario.fromMap(resultado[i]);
      // APLICAMOS UN "FILTRO" PARA QUE SE MUESTREN TODOS LOS USUARIOS MENOS EL NUESTRO PROPIO
      if(u.id != id_supervisor){
        usuarios.add(u);
      }
    }
    return usuarios;
  }

  // -------------------------------------------------- METODOS MEDICAMENTOS --------------------------------------------------

  Future<List<Medicamento>> getMedicamentosUsuario(int id_usuario) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.query("medicamentos", where: "id_usuario = ?", whereArgs: [id_usuario]);
    return List.generate(resultado.length, (index) => Medicamento.fromMap(resultado[index]));
  }

  // -------------------------------------------------- METODOS VISITAS MEDICAS --------------------------------------------------

  Future<List<VisitaMedica>> getVisitasMedicasUsuario(int id_usuario) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.query("visitasmedicas", where: "id_usuario = ?", whereArgs: [id_usuario]);
    return List.generate(resultado.length, (index) => VisitaMedica.fromMap(resultado[index]));
  }


  // -------------------------------------------------- METODOS GENERALES --------------------------------------------------

  // SELECT * FROM tabla
  Future<List<Map<String, dynamic>>> consultarBD(String tabla) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.query(tabla);
    return resultado;
  }

  // CONSULTA CON SENTENCIA SQL
  Future<List<Map<String, dynamic>>> consultarSQL(String sql) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.rawQuery(sql);
    return resultado;
  }

  // INSERT INTO tabla
  Future<int> insertarBD(String tabla, Map<String, dynamic> fila) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.insert(tabla, fila);
    print("ID DEL OBJETO CREADO: ${resultado}");
    return resultado;
  }

  // DELETE FROM tabla WHERE "id" = id
  Future<int> eliminarBD(String tabla, int id) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.delete(tabla, where: 'id = ?', whereArgs: [id]);
    return resultado;
  }

  // UPDATE FROM tabla
  Future<int> actualizarBD(String tabla, Map<String, dynamic> fila) async{
    Database? bd = await baseDatos;
    var resultado=0;
    if(bd!=null){
      resultado = await bd.update(tabla, fila, where: 'id = ?', whereArgs: [fila['id']]);
    }
    
    return resultado;
  }
}

/**
// OTRO MODELO DE BASE DE DATOS TRATANDO CON OBJETOS Usuario, NO PODEMOS USARLO PORQUE TENDRIAMOS QUE INTRODUCIR UN id MANUAL AL USUARIO
class DB{
  static Future<Database> _openDB() async{
    return openDatabase(
      join(await getDatabasesPath(),"usuarios.db"),
      onCreate: (db,version){
        // return db.execute("CREATE TABLE usuarios(id INTEGER PRIMARY KEY AUTO_INCREMENT,nombre VARCHAR(30),correo VARCHAR(30),password VARCHAR(30))");
        return db.execute("CREATE TABLE usuarios(id INTEGER PRIMARY KEY,nombre VARCHAR(30),correo VARCHAR(30),password VARCHAR(30))");
      },
      version: 1
    );
  }

  static Future<int> insert(Usuario usuario) async{
    Database db = await _openDB();
    
    return db.insert("usuarios", usuario.toMap());
  }

  static Future<int> delete(Usuario usuario) async{
    Database db = await _openDB();

    return db.delete("usuarios", where: "id = ?", whereArgs: [usuario.id]);
  }

  static Future<int> update(Usuario usuario) async{
    Database db = await _openDB();

    return db.update("usuarios", usuario.toMap(), where: "id = ?", whereArgs: [usuario.id]);
  }

  static Future<List<Usuario>> usuarios() async{
    Database db = await _openDB();

    final List<Map<String, dynamic>> usuariosMap = await db.query("usuarios");

    return List.generate(usuariosMap.length,(i) => Usuario(
      id: usuariosMap[i]["id"],
      nombre: usuariosMap[i]["nombre"],
      correo: usuariosMap[i]["correo"],
      password: usuariosMap[i]["password"]
      )
    );
  }
}
*/