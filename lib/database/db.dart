import 'package:farmacapp/database/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{
  
  static Future<Database> _openDB() async{
    return openDatabase(
      join(await getDatabasesPath(),"usuarios.db"),
      onCreate: (db,version){
        return db.execute("CREATE TABLE usuarios(id INT PRIMARY KEY AUTO_INCREMENT,nombre VARCHAR(30),correo VARCHAR(30),password VARCHAR(30))");
        // return db.execute("CREATE TABLE usuarios(id INT PRIMARY KEY,nombre VARCHAR(30),correo VARCHAR(30),password VARCHAR(30))");
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