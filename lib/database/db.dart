// import 'package:farmacapp/database/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BDHelper{
  static Database? _baseDatos;
  static const String nombreBD = "misusuarios.db";

  //iniciar la base de datos
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
        await db.execute(
          "CREATE TABLE usuarios(id INT PRIMARY KEY,nombre VARCHAR(30),correo VARCHAR(30),password VARCHAR(30))"
        );
        //para añadir una segunda tabla
        // await db.execute(
        //   "CREATE TABLE Resultados(id INTEGER PRIMARY KEY, jugador1 TEXT, j1set1 TEXT, j1set1 TEXT)"
        // );
      }
    );
    return baseDatos;
  }

  //consultar la tabla entera en la base de datos
  Future<List<Map<String, dynamic>>> consultarBD(String tabla) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.query(tabla);
    return resultado;
  }

  //consulta con sql
  Future<List<Map<String, dynamic>>> consultarSQL(String sql) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.rawQuery(sql);
    return resultado;
  }

  //insertar datos en la base de datos
  Future<int> insertarBD(String tabla, Map<String, dynamic> fila) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.insert(tabla, fila);
    print(resultado);
    return resultado;
  }

  //eliminar datos de la base de datos
  Future<int> eliminarBD(String tabla, int id) async{
    Database? bd = await baseDatos;
    var resultado = await bd!.delete(tabla, where: 'id = ?', whereArgs: [id]);
    return resultado;
  }

  //actualizar datos de la base de datos
  Future<int> actualizarBD(String tabla, Map<String, dynamic> fila) async{
    Database? bd = await baseDatos;
    var resultado=0;
    if(bd!=null){
      resultado = await bd.update(tabla, fila, where: 'id = ?', whereArgs: [fila['id']]);
    }
    
    return resultado;
  }
}

// class DB{
  
//   static Future<Database> _openDB() async{
//     return openDatabase(
//       join(await getDatabasesPath(),"usuarios.db"),
//       onCreate: (db,version){
//         return db.execute("CREATE TABLE usuarios(id INT PRIMARY KEY AUTO_INCREMENT,nombre VARCHAR(30),correo VARCHAR(30),password VARCHAR(30))");
//         // return db.execute("CREATE TABLE usuarios(id INT PRIMARY KEY,nombre VARCHAR(30),correo VARCHAR(30),password VARCHAR(30))");
//       },
//       version: 1
//     );
//   }

//   static Future<int> insert(Usuario usuario) async{
//     Database db = await _openDB();
    
//     return db.insert("usuarios", usuario.toMap());
//   }

//   static Future<int> delete(Usuario usuario) async{
//     Database db = await _openDB();

//     return db.delete("usuarios", where: "id = ?", whereArgs: [usuario.id]);
//   }

//   static Future<int> update(Usuario usuario) async{
//     Database db = await _openDB();

//     return db.update("usuarios", usuario.toMap(), where: "id = ?", whereArgs: [usuario.id]);
//   }

//   static Future<List<Usuario>> usuarios() async{
//     Database db = await _openDB();

//     final List<Map<String, dynamic>> usuariosMap = await db.query("usuarios");

//     return List.generate(usuariosMap.length,(i) => Usuario(
//       id: usuariosMap[i]["id"],
//       nombre: usuariosMap[i]["nombre"],
//       correo: usuariosMap[i]["correo"],
//       password: usuariosMap[i]["password"]
//       )
//     );
//   }
// }