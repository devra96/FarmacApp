 import 'dart:io';

import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/paginas/pantalla_agenda.dart';
import 'package:farmacapp/paginas/pantalla_pass_olvidada.dart';
import 'package:farmacapp/provider/modo_trabajo.dart';
import 'package:farmacapp/provider/usuario_supervisor.dart';
import 'package:farmacapp/widgets/dialogo.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Pantalla donde podremos introducir nuestro correo y contraseña
/// para iniciar sesion, e indicar si funcionaremos en el modo
/// remoto o en local.
/// 
/// Tambien tiene un boton de contraseña olvidada, pero no esta
/// implementado.
///
class PantallaInicioSesion extends StatefulWidget {
  const PantallaInicioSesion({super.key});

  @override
  State<PantallaInicioSesion> createState() => _PantallaInicioSesionState();
}

class _PantallaInicioSesionState extends State<PantallaInicioSesion> {
  
  String correo = "";
  String password = "";
  bool valorSwitch = true;

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

    final modoTrabajo = Provider.of<ModoTrabajo>(context);
    var usuarioIniciado = Provider.of<Usuario>(context);
    var usuarioSupervisor = Provider.of<UsuarioSupervisor>(context);

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
          // COLUMNA TEXTFIELDS, SWITCHES Y BOTON CREAR CUENTA
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
                height: 10,
              ),
              // ROW TEXTO "MODO REMOTO" Y SWITCH
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Modo remoto',
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                    SizedBox(
                      width: 10
                    ),
                    Switch(
                      value: modoTrabajo.modoLocal,
                      onChanged: (bool value) {
                        setState(() {
                          modoTrabajo.modoLocal = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              // ESPACIO
              SizedBox(
                height: 20,
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
                    // SI EL CAMPO DEL CORREO Y/O CONTRASEÑA ESTA(N) VACIO(S)
                    if(correo == "" || password == ""){
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) => Dialogo(texto: "Por favor, rellena ambos campos.")
                      );
                    }
                    // IDENTIFICACION DE USUARIO Y CONTRASEÑA
                    else{
                      Usuario u = new Usuario();

                      // SI EL MODO REMOTO ESTA ACTIVADO (IDENTIFICACION MEDIANTE API)
                      if(modoTrabajo.modoLocal){
                        String response = await u.checkUsuario(correo,password);
                        // SI EL USUARIO Y/O CONTRASEÑA SON INCORRECTOS
                        if(response == "no"){
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => Dialogo(texto: "Usuario y/o contraseña incorrecto(s).")
                          );
                        }
                        // SI LA AUTENTICACION ES CORRECTA
                        else{
                          // RECOGEMOS AL USUARIO QUE HA INICIADO SESION
                          u = await u.getUsuario(correo,password);
                          
                          // SI EL USUARIO INICIADO ES SUPERVISOR
                          if(u.id == u.id_supervisor){
                            usuarioSupervisor.supervisoriniciado = true;
                            usuarioSupervisor.modosupervisor = false; // Por si acaso

                            usuarioSupervisor.id = u.id;
                            usuarioSupervisor.id_supervisor = u.id_supervisor;
                            usuarioSupervisor.nombre = u.nombre;
                            usuarioSupervisor.correo = u.correo;
                            usuarioSupervisor.password = u.password;
                          }
                          else{
                            usuarioSupervisor.supervisoriniciado = false;
                            usuarioSupervisor.modosupervisor = false; // Por si acaso

                            // GUARDAMOS LOS ATRIBUTOS DE USUARIO EN EL PROVIDER "usuarioIniciado" PARA TRANSPASARLOS ENTRE PANTALLAS
                            usuarioIniciado.id = u.id;
                            usuarioIniciado.id_supervisor = u.id_supervisor;
                            usuarioIniciado.nombre = u.nombre;
                            usuarioIniciado.correo = u.correo;
                            usuarioIniciado.password = u.password;
                          }

                          // CARGAMOS LA AGENDA
                          _loadPantallaAgenda();
                        }
                      }
                      // SI EL MODO REMOTO ESTA DESACTIVADO (IDENTIFICACION MEDIANTE BD LOCAL)
                      else{
                        // SI LA AUTENTICACION ES CORRECTA
                        if(await bdHelper.comprobarLogin("usuarios", correo, password) != ""){
                          // RECOGEMOS AL USUARIO QUE HA INICIADO SESION
                          u = await bdHelper.getUsuario("usuarios",correo,password);

                          // SI EL USUARIO INICIADO ES SUPERVISOR
                          if(u.id == u.id_supervisor){
                            usuarioSupervisor.supervisoriniciado = true;
                            usuarioSupervisor.modosupervisor = false; // Por si acaso
                            usuarioSupervisor.id = u.id;
                            usuarioSupervisor.id_supervisor = u.id_supervisor;
                            usuarioSupervisor.nombre = u.nombre;
                            usuarioSupervisor.correo = u.correo;
                            usuarioSupervisor.password = u.password;
                          }
                          else{
                            usuarioSupervisor.supervisoriniciado = false;
                            usuarioSupervisor.modosupervisor = false; // Por si acaso

                            // GUARDAMOS LOS ATRIBUTOS DE USUARIO EN EL PROVIDER "usuarioIniciado" PARA TRANSPASARLOS ENTRE PANTALLAS
                            usuarioIniciado.id = u.id;
                            usuarioIniciado.id_supervisor = u.id_supervisor;
                            usuarioIniciado.nombre = u.nombre;
                            usuarioIniciado.correo = u.correo;
                            usuarioIniciado.password = u.password;
                          }

                          // CARGAMOS LA AGENDA
                          _loadPantallaAgenda();
                        }
                        // SI EL USUARIO Y/O CONTRASEÑA ES INCORRECTA
                        else{
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => Dialogo(texto: "Usuario y/o contraseña incorrecto(s).")
                          );
                        }
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