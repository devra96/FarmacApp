 import 'dart:io';

import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/paginas/pantalla_agenda.dart';
import 'package:farmacapp/paginas/pantalla_nuevo_usuario.dart';
import 'package:farmacapp/paginas/pantalla_pass_olvidada.dart';
import 'package:farmacapp/widgets/dialogo.dart';
import 'package:flutter/material.dart';

class PantallaInicioSesion extends StatefulWidget {
  const PantallaInicioSesion({super.key});

  @override
  State<PantallaInicioSesion> createState() => _PantallaInicioSesionState();
}

class _PantallaInicioSesionState extends State<PantallaInicioSesion> {
  
  String correo = "";
  String password = "";

  BDHelper bdHelper = BDHelper();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TEXTO "INICIAR SESION"
          Text(
            "INICIAR SESION",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
          // ESPACIO
          SizedBox(
            height: 50,
          ),
          // COLUMNA TEXTFIELD´S Y BOTON
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TEXTFIELD CORREO ELECTRONICO
              Center(
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: "Correo electronico"
                    ),
                    onChanged: (value) => correo = value,
                  ),
                ),
              ),
              // ESPACIO
              SizedBox(
                height: 20,
              ),
              // TEXTFIELD CONTRASEÑA
              Center(
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: "Contraseña"
                    ),
                    onChanged: (value) => password = value,
                  ),
                ),
              ),
              // ESPACIO
              SizedBox(
                height: 40,
              ),
              // BOTON INICIAR SESION
              Container(
                width: 350,
                height: 55,
                decoration: const BoxDecoration(
                  color: Color(0xFF009638),
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: TextButton(
                  child: const Text(
                    "INICIAR SESION",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: ()async{
                    if(correo == "" || password == ""){
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) => Dialogo(texto: "Por favor, rellena ambos campos.")
                      );
                    }
                    else{
                      Usuario u = new Usuario();
                      String response = await u.checkUsuario(correo,password);
                      if(response == "no"){
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => Dialogo(texto: "Usuario y/o contraseña incorrecto(s).")
                        );
                      }
                      else{
                        // PASAR A LA PANTALLA DE LA AGENDA EL ID DEL USUARIO???
                        _loadPantallaAgenda();
                      }
                    }
                  },
                ),
              ),
              // ESPACIO
              SizedBox(
                height: 30,
              ),
              // TEXT "OLVIDASTE LA CONTRASEÑA"
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    "¿Olvidaste la contraseña? Haz click aqui",
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.underline
                    ),
                  ),
                ),
                onTap: () {
                  print("IR A PANTALLA CONTRASEÑA OLVIDADA");
                  _loadPantallaPassOlvidada();
                },
              ),
            ],
          )
        ],
      )
    );
  }
}