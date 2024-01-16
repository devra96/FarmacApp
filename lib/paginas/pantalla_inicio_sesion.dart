 import 'dart:io';

import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/paginas/pantalla_agenda.dart';
import 'package:farmacapp/paginas/pantalla_nuevo_usuario.dart';
import 'package:farmacapp/paginas/pantalla_pass_olvidada.dart';
import 'package:flutter/material.dart';

class PantallaInicioSesion extends StatefulWidget {
  const PantallaInicioSesion({super.key});

  @override
  State<PantallaInicioSesion> createState() => _PantallaInicioSesionState();
}

class _PantallaInicioSesionState extends State<PantallaInicioSesion> {
  
  _loadPantallaAgenda () async{
    final destino = MaterialPageRoute(builder:(_)=>PantallaAgenda());
    final datoDevuelto = await Navigator.push(context, destino);
    
    setState((){
      
    });
  }

  _loadPantallaPassOlvidada () async{
    final destino = MaterialPageRoute(builder:(_)=>PantallaPassOlvidada());
    final datoDevuelto = await Navigator.push(context, destino);
    
    setState((){

    });
  }

  _loadPantallaNuevoUsuario () async{
    final destino = MaterialPageRoute(builder:(_)=>PantallaNuevoUsuario());
    final datoDevuelto = await Navigator.push(context, destino);
    
    // setState((){

    // });
  }

  @override
  Widget build(BuildContext context) {
    late String user = "";
    late String pass = "";
    BDHelper bdHelper = BDHelper();

    return Scaffold(
      // ####################  BODY  ####################
      body: ListView(
        children: [
          // LOGO
          Image.asset("assets/images/logo.png"),
          // USUARIO
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: const Text(
                "Introduzca su nombre de usuario",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
          ),
          // TEXTFIELD USUARIO
          Center(
            child: Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Nombre de usuario",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                  user = value;
                },
              ),
            ),
          ),
          // CONTRASEÑA
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: const Text(
                "Introduzca su contraseña",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
          ),
          // TEXTFIELD CONTRASEÑA
          Center(
            child: Container(
              width: 300,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Contraseña"
                ),
                onChanged: (value){
                  pass = value;
                },
              ),
            ),
          ),
          // TEXTO SI HA OLVIDADO LA CONTRASEÑA
          Center(
            child: InkWell(
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  "Si ha olvidado la contraseña, haga click aqui",
                  style: TextStyle(
                    color: Colors.red
                  ),
                ),
              ),
              onTap: (){
                print("IR A PANTALLA CONTRASEÑA OLVIDADA");
                _loadPantallaPassOlvidada();
              },
            ),
          ),
          // BOTON INICIAR SESION
          Center(
            child: Container(
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: TextButton(
                child: const Text(
                  "INICIAR SESION",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22
                  ),
                ),
                onPressed: () async{
                  // SI EL USUARIO NO HA RELLENADO AMBOS CAMPOS
                  if(user == "" || pass == ""){
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: const Text(
                          'Por favor, rellena ambos campos.',
                          style: TextStyle(
                            fontSize: 16
                          )
                        ),
                        actions: <TextButton>[
                          TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            child: const Center(
                              child: Text('Aceptar')
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  else{
                    // SI EL USUARIO Y CONTRASEÑA COINDICEN, DEVOLVERA 1
                    if(await bdHelper.comprobarLogin("usuarios", user, pass) == 1){
                      _loadPantallaAgenda();
                    }
                    // SI EL USUARIO Y/O CONTRASEÑA SON INCORRECTOS
                    else{
                      showDialog<void>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: const Text(
                          'Usuario y/o contraseña incorrectos.',
                          style: TextStyle(
                            fontSize: 16
                          )
                        ),
                        actions: <TextButton>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Center(
                              child: Text('Aceptar')
                            ),
                          )
                        ],
                      ),
                    );
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
      // BOTON FLOTANTE
      floatingActionButton: Container(
        width: 90,
        height: 70,
        child: FloatingActionButton(
          onPressed: (){
            // IR A PANTALLA NUEVO USUARIO
            _loadPantallaNuevoUsuario();
          },
          child: Text(
            "¿Nuevo usuario? Haz click aqui.",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}