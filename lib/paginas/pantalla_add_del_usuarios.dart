import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/provider/modo_trabajo.dart';
import 'package:farmacapp/provider/usuario_supervisor.dart';
import 'package:farmacapp/widgets/boton_usuario.dart';
import 'package:farmacapp/widgets/dialogo.dart';
import 'package:farmacapp/widgets/dialogo_supervisor_add_usuario.dart';
import 'package:farmacapp/widgets/dialogo_supervisor_confirmar_usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PantallaAddDelUsuarios extends StatefulWidget {
  const PantallaAddDelUsuarios({super.key});

  @override
  State<PantallaAddDelUsuarios> createState() => _PantallaAddDelUsuariosState();
}

class _PantallaAddDelUsuariosState extends State<PantallaAddDelUsuarios> {

  // INSTANCIA BASE DE DATOS LOCAL
  BDHelper bdHelper = BDHelper();

  // INSTANCIA MODELO USUARIO
  Usuario u = new Usuario();

  @override
  Widget build(BuildContext context) {

    // VARIABLE QUE GUARDARA EL ID QUE USAREMOS PARA RECUPERAR LOS USUARIOS
    // - SI VAMOS A AÑADIR UN USUARIO, EL ID SERA 0
    // - SI VAMOS A ELIMINAR UN USUARIO, EL ID SERA EL DEL USUARIO SUPERVISOR INICIADO
    // late int idAddDel;

    late String textoAppBar;

    late String correo = "", password = "";

    var modoTrabajo = Provider.of<ModoTrabajo>(context);
    var modoEdicion = Provider.of<ModoEdicion>(context);
    var usuarioSupervisor = Provider.of<UsuarioSupervisor>(context);

    Future<List<Usuario>> recuperarUsuarios() async{
      // MODO REMOTO
      if(modoTrabajo.modoLocal){
        return u.getUsuariosSupervisor(usuarioSupervisor.id);
      }
      // MODO LOCAL
      else{
        return await bdHelper.getUsuariosSupervisor(usuarioSupervisor.id);
      }
    }

    // COMPROBACION DE SI VAMOS A AÑADIR O BORRAR UN USUARIO
    // SI AÑADIMOS USUARIO
    if(modoEdicion.addusuario){
      // idAddDel = 0;
      textoAppBar = "AÑADIR UN USUARIO";

      print("VUELTA A EMPEZAR! CORREO VALE $correo");

      return Scaffold(
        appBar: AppBar(
          title: Text(textoAppBar),
        ),
        body: Container(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Ingrese el correo y la contraseña de la persona que quiere supervisar.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              // ESPACIO
              SizedBox(
                height: 20
              ),
              Center(
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: "Correo"
                    ),
                    onChanged: (value) => correo = value,
                  ),
                ),
              ),
              SizedBox(
                height: 10
              ),
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
                height: 20
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Color(0xFF009638),
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: TextButton(
                    child: Text(
                      "AÑADIR USUARIO",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: () async{
                      // SI EL USUARIO NO HA INTRODUCIDO AMBOS CAMPOS
                      if(correo == "" || password == ""){
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => Dialogo(texto: 'Por favor, rellene todos los campos.')
                        );
                      }
                      else{
                        // MODO REMOTO
                        if(modoTrabajo.modoLocal){
                          // SI EL USUARIO Y/O CONTRASEÑA SON INCORRECTOS
                          if(await u.checkUsuario(correo, password) == "no"){
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) => Dialogo(texto: 'Usuario y/o contraseña incorrect@(s).')
                            );
                          }
                          // INICIO DE SESION CORRECTO
                          else{
                            // RECUPERAMOS AL USUARIO INTRODUCIDO
                            u = await u.getUsuario(correo, password);
                            // SI EL USUARIO NO TIENE SUPERVISOR
                            if(u.id_supervisor == 0){
                              // MOSTRAR DIALOGO RECOGIENDO ID, NOMBRE Y CORREO DEL USUARIO A SUPERVISAR
                              await showDialog<void>(
                                context: context,
                                builder: (BuildContext context) => DialogoSupervisorConfirmarUsuario(id: u.id, nombre: u.nombre, texto: '¿Quiere supervisar a este usuario?')
                              );

                              // SI EL USUARIO AFIRMA SUPERVISAR AL USUARIO
                              if(modoEdicion.confirmacion){
                                // MODIFICAR ID_SUPERVISOR USUARIO Y DIALOGO SE HA AÑADIDO SETSTATE

                                // MODIFICAMOS EL id_supervisor DEL USUARIO A SUPERVISAR
                                await u.updateUsuario_idSupervisor(u.id, usuarioSupervisor.id);

                                Navigator.pop(context);

                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) => Dialogo(texto: 'Usuario añadido correctamente.')
                                );
                              }
                              // SI PULSAMOS EN CANCELAR, VUELVE AL MENU DE USUARIOS
                              // SE HA IMPLEMENTADO ASI DEBIDO A QUE, SI DOY AL BOTON DE CANCELAR SIN IMPLEMENTAR NADA,
                              // VUELVE A CARGAR EL SCAFFOLD Y SE BORRAN LOS VALORES INTRODUCIDOS EN LOS CAMPOS
                              //
                              // SOLO PASA CUANDO LLAMO AL SHOWDIALOG QUE LLAMA A DialogoSupervisorConfirmarUsuario,
                              // EN LAS DEMAS SITUACIONES NO PASA, NO SE POR QUE
                              else{
                                Navigator.pop(context);
                              }
                            }
                            // SI EL USUARIO ESTA SIENDO SUPERVISADO POR OTRO SUPERVISOR
                            else{
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) => Dialogo(texto: 'Ese usuario ya esta siendo supervisado por otra persona.')
                              );
                            }
                          }
                        }
                        // MODO LOCAL
                        else{
                          // SI EL USUARIO Y/O CONTRASEÑA SON INCORRECTOS
                          if(await bdHelper.comprobarLogin("usuarios", correo, password) == ""){
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) => Dialogo(texto: 'Usuario y/o contraseña incorrect@(s).')
                            );
                          }
                          // INICIO DE SESION CORRECTO
                          else{
                            // RECUPERAMOS AL USUARIO INTRODUCIDO
                            u = await bdHelper.getUsuario("usuarios", correo, password);

                            // SI EL USUARIO NO TIENE SUPERVISOR
                            if(u.id_supervisor == 0){
                              // MOSTRAR DIALOGO RECOGIENDO ID, NOMBRE Y CORREO DEL USUARIO A SUPERVISAR
                              await showDialog<void>(
                                context: context,
                                builder: (BuildContext context) => DialogoSupervisorConfirmarUsuario(id: u.id, nombre: u.nombre, texto: '¿Quiere supervisar a este usuario?')
                              );

                              // SI EL USUARIO AFIRMA SUPERVISAR AL USUARIO
                              if(modoEdicion.confirmacion){
                                // MODIFICAR ID_SUPERVISOR USUARIO Y DIALOGO SE HA AÑADIDO SETSTATE

                                await bdHelper.actualizarBD("usuarios", {
                                  "id": u.id,
                                  "id_supervisor": usuarioSupervisor.id
                                });

                                Navigator.pop(context);

                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) => Dialogo(texto: 'Usuario añadido correctamente.')
                                );
                              }
                            }
                            // SI EL USUARIO ESTA SIENDO SUPERVISADO POR OTRO SUPERVISOR
                            else{
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) => Dialogo(texto: 'Ese usuario ya esta siendo supervisado por otra persona.')
                              );
                            }
                          }
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    // SI BORRAMOS USUARIO
    else{
      // idAddDel = usuarioSupervisor.id;
      textoAppBar = "BORRAR UN USUARIO";
      
      return Scaffold(
        appBar: AppBar(
          title: Text(textoAppBar),
        ),
        body: Container(
          child: FutureBuilder(
            future: recuperarUsuarios(),
            builder: (context, AsyncSnapshot<List<Usuario>> snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    return Container(
                      height: 100,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white
                      ),
                      child: InkWell(
                        onTap: () async{
                          // MOSTRAR DIALOGO DE CONFIRMACION PARA AÑADIR/BORRAR
                          await showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => DialogoSupervisorConfirmarUsuario(id: snapshot.data![index].id, nombre: snapshot.data![index].nombre, texto: '¿Dejar de supervisar a este usuario?')
                          );

                          // SI EL USUARIO CONFIRMA, ESTABLECEMOS EL id_supervisor DEL USUARIO SELECCIONADO A "0"
                          if(modoEdicion.confirmacion){
                            // MODO REMOTO
                            if(modoTrabajo.modoLocal){
                              await u.updateUsuario_idSupervisor(snapshot.data![index].id, 0);
                            }
                            // MODO LOCAL
                            else{
                              await bdHelper.actualizarBD("usuarios", {
                                "id": snapshot.data![index].id,
                                "id_supervisor": 0
                              });
                            }

                            Navigator.pop(context);

                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) => Dialogo(texto: 'Usuario eliminado correctamente.')
                            );
                          }
                        },
                        child: BotonUsuario(
                          nombre: snapshot.data![index].nombre,
                          correo: snapshot.data![index].correo
                        )
                      ),
                    );
                  }
                );
              }
              else{
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'NO HAY USUARIOS.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      );
    }
  }
}