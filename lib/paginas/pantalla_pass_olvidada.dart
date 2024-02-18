import 'package:flutter/material.dart';

/// Pantalla donde podriamos restablecer la contraseña de nuestra cuenta.
/// No esta implementado por falta de un servidor de correo.
///
class PantallaPassOlvidada extends StatefulWidget {
  const PantallaPassOlvidada({super.key});

  @override
  State<PantallaPassOlvidada> createState() => _PantallaPassOlvidadaState();
}

class _PantallaPassOlvidadaState extends State<PantallaPassOlvidada> {
  String nombreusuario = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #################### APPBAR ####################
      appBar: AppBar(
        title: Text("RESTABLECER CONTRASEÑA"),
      ),
      // ####################  BODY  ####################
      body: ListView(
        children: [
          // TEXTO: "Introduzca su nombre de usuario/correo electronico"
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Introduzca su nombre de usuario",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
          ),
          // TEXFIELD NOMBRE USUARIO
          Center(
            child: Container(
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Nombre de usuario",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                  nombreusuario = value;
                },
              ),
            ),
          ),
          Center(
            child: Container(
              width: 350,
              margin: EdgeInsets.only(top: 30),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: TextButton(
                child: const Text(
                  "RESTABLECER CONTRASEÑA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
                onPressed: (){
                  // SI NO SE HA ESCRITO NADA
                  if(nombreusuario == ""){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Center(child: const Text('ERROR')),
                        content: const Text(
                          'Por favor, introduzca su nombre de usuario.'),
                        actions: <Widget>[
                          Center(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('ACEPTAR'),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  else if(nombreusuario != "admin"){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Center(child: const Text('ERROR')),
                        content: const Text(
                          'No se ha encontrado ningun usuario con ese nombre.'),
                        actions: <Widget>[
                          Center(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('ACEPTAR'),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  else{
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('CONTRASEÑA RESTABLECIDA'),
                        content: const Text(
                          'Se han enviado a su correo electronico las instrucciones para restablecer la contraseña.'),
                        actions: <Widget>[
                          Center(
                            child: TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('ACEPTAR'),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}