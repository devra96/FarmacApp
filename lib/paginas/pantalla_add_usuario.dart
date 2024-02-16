import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/provider/modo_trabajo.dart';
import 'package:farmacapp/widgets/dialogo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sqflite/sqflite.dart';
import 'package:farmacapp/database/db.dart';

class PantallaNuevoUsuario extends StatefulWidget {
  const PantallaNuevoUsuario({super.key});

  @override
  State<PantallaNuevoUsuario> createState() => _PantallaNuevoUsuarioState();
}

class _PantallaNuevoUsuarioState extends State<PantallaNuevoUsuario> {
  
  late String nombre = "";
  late String correo = "";
  late String pass = "";
  late String confirmarpass = "";

  // bool valorSwitchModoRemoto = true;
  bool valorSwitchModoSupervisor = false;

  BDHelper bdHelper = BDHelper();
  
  @override
  Widget build(BuildContext context) {

    final modoTrabajo = Provider.of<ModoTrabajo>(context);

    return Scaffold(
      // #################### APPBAR ####################
      // appBar: AppBar(
      //   automaticallyImplyLeading: false, // HACE QUE NO SALGA EL BOTON DE VOLVER
      //   title: Center(
      //     child: Text("CREAR USUARIO"),
      //   ),
      // ),
      // ####################  BODY  ####################
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TEXTO "CREAR CUENTA"
              Text(
                "CREAR CUENTA",
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
                  // TEXTFIELD NOMBRE Y APELLIDOS
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: "Nombre y apellidos"
                        ),
                        onChanged: (value) => nombre = value,
                      ),
                    ),
                  ),
                  // ESPACIO
                  SizedBox(
                    height: 20,
                  ),
                  // TEXTFIELD CORREO
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.red,
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: "Contraseña"
                        ),
                        onChanged: (value) => pass = value,
                      ),
                    ),
                  ),
                  // ESPACIO
                  SizedBox(
                    height: 20,
                  ),
                  // TEXTFIELD CONFIRMAR CONTRASEÑA
                  Center(
                    child: SizedBox(
                      width: 350,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          labelText: "Confirmar contraseña"
                        ),
                        onChanged: (value) => confirmarpass = value,
                      ),
                    ),
                  ),
                  // ESPACIO
                  SizedBox(
                    height: 20,
                  ),
                  // ROW TEXTO "MODO REMOTO" Y SWITCH
                  Padding(
                    padding: const EdgeInsets.only(left: 22, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Crear en modo remoto',
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
                  // ROW TEXTO "¿CUENTA DE SUPERVISOR?" Y SWITCH
                  Padding(
                    padding: const EdgeInsets.only(left: 22, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '¿Cuenta de supervisor?',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        SizedBox(
                          width: 10
                        ),
                        Switch(
                          value: valorSwitchModoSupervisor,
                          onChanged: (bool value) {
                            setState(() {
                              valorSwitchModoSupervisor = value;
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
                  // BOTON CREAR CUENTA
                  Container(
                    width: 350,
                    height: 55,
                    decoration: const BoxDecoration(
                      color: Color(0xFF009638),
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: TextButton(
                      child: const Text(
                        "CREAR CUENTA",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      onPressed: ()async{
                        // SI EL USUARIO NO HA RELLENADO TODOS LOS CAMPOS
                        if(nombre == "" || correo == "" || pass == "" || confirmarpass == ""){
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => Dialogo(texto: 'Por favor, rellena todos los campos.')
                          );
                        }
                        // SI LAS CONTRASEÑAS NO COINCIDEN
                        else if(pass != confirmarpass){
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => Dialogo(texto: '¡Las contraseñas no coinciden!')
                          );
                        }
                        // TODOS LOS CAMPOS INTRODUCIDOS CORRECTAMENTE
                        else{
                          // SI SE CREA CUENTA EN MODO REMOTO (API)
                          if(modoTrabajo.modoLocal){
                            // COMPROBACION DE CUENTA EXISTENTE EN LA API
                            Usuario u = new Usuario();
                            int idUsuario = await u.checkUsuarioExistente(correo);
                            // SI NO EXISTE
                            if(idUsuario == 0){
                              // SI CREAMOS CUENTA DE SUPERVISOR
                              if(valorSwitchModoSupervisor){
                                // PRIMERO INSERTAMOS CUENTA SIN id_supervisor
                                u = await u.createUsuario(0, nombre, correo, pass);
                                // PATCH AL USUARIO CREADO CON id_supervisor = idUsuario
                                idUsuario = await u.checkUsuarioExistente(correo); // Volvemos a llamar al metodo para recoger el ID del usuario creado
                                u.updateUsuario_idSupervisor(idUsuario, idUsuario);
                              }
                              // SI CREAMOS CUENTA ESTANDAR (SIN id_supervisor)
                              else{
                                u = await u.createUsuario(0, nombre, correo, pass);
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("CUENTA CREADA CON EXITO.")
                                )
                              );

                              Navigator.pop(context);
                            }
                            // SI EXISTE
                            else{
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) => Dialogo(texto: 'Ya existe un usuario registrado con la cuenta de correo proporcionada.')
                              );
                            }
                          }
                          // SI SE CREA CUENTA EN MODO LOCAL
                          else{
                            // CONSULTAMOS A LA BASE DE DATOS LOCAL SI EXISTE ALGUN USUARIO CON EL CORREO INTRODUCIDO
                            // SI EXISTE, GUARDARA 1, SI NO, GUARDARA 0
                            int c = await bdHelper.comprobarCorreo("usuarios", correo);
                            
                            // SI EXISTE
                            if(c != 0){
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) => Dialogo(texto: 'Ya existe un usuario registrado con la cuenta de correo proporcionada.')
                              );
                            }
                            // SI NO EXISTE
                            else{
                              // SI CREAMOS CUENTA DE SUPERVISOR
                              if(valorSwitchModoSupervisor){
                                // PRIMERO INSERTAMOS USUARIO SIN id_supervisor
                                bdHelper.insertarBD("usuarios",{'nombre':nombre, 'correo':correo, 'password':pass});
                                // RECOGEMOS ID DEL ULTIMO USUARIO CREADO
                                String strIdUsuario = await bdHelper.comprobarLogin("usuarios", correo, pass);
                                int idUsuario = int.parse(strIdUsuario);
                                // HACEMOS UN UPDATE DEL USUARIO ESTABLECIENDO id_supervisor = idUsuario
                                bdHelper.actualizarBD("usuarios", {'id':idUsuario, 'id_supervisor':idUsuario, 'nombre':nombre, 'correo':correo, 'password':pass});
                              }
                              // SI CREAMOS CUENTA ESTANDAR (NO INSERTAMOS id_supervisor)
                              else{
                                bdHelper.insertarBD("usuarios",{'id_supervisor':0, 'nombre':nombre, 'correo':correo, 'password':pass});
                              }

                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("CUENTA CREADA CON EXITO.")
                                )
                              );
                            }
                          }
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}