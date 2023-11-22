import 'dart:io';

import 'package:farmacapp/paginas/pantalla_agenda.dart';
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
    
    //si el valor devuelto por await es nulo dejamos el valor que tenia configuracion
    setState((){
      // widget.configuracion = datoDevuelto ?? widget.configuracion;
    });
  }

  @override
  Widget build(BuildContext context) {
    late String user = "";
    late String pass = "";

    return Scaffold(
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
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    "Si ha olvidado la contraseña, haga click aqui",
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
                ),
                onTap: (){
                  print("IR A PANTALLA CONTRASEÑA OLVIDADA");
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
                  onPressed: (){
                    // DE MOMENTO SE HACE UNA PRUEBA DE INICIO DE SESION CON "admin/admin"
                    // SE AÑADIRA EN UN FUTURO UNA LISTA DE MAPAS QUE GUARDE USUARIOS CON SUS DATOS??
                    if(user == "admin" && pass == "admin"){
                      print("Correcto");
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
                  },
                ),
              ),
            ),
            // TEXTO SI NO TIENE USUARIO
            Container(
              padding: EdgeInsets.only(
                left: 25,
                top: 50
              ),
              child: Text(
                "¿USUARIO NUEVO? HAZ CLICK AQUI =>",
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            )
          ],
        ),
        // BOTON FLOTANTE
        floatingActionButton: FloatingActionButton(
          onPressed:(){
            // IR PANTALLA NUEVO USUARIO
            // final destino = MaterialPageRoute(builder: (_) => PaginaJuego(configuracion: widget.configuracion,));
            // Navigator.push(context, destino);
          },
        child: Icon(Icons.add),
      ),
    );
  }
}