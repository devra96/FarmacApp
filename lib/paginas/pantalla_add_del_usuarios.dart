import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/provider/modo_trabajo.dart';
import 'package:farmacapp/provider/usuario_supervisor.dart';
import 'package:farmacapp/widgets/boton_usuario.dart';
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
    late int idAddDel;

    late String textoAppBar;

    var modoTrabajo = Provider.of<ModoTrabajo>(context);
    var modoEdicion = Provider.of<ModoEdicion>(context);
    var usuarioSupervisor = Provider.of<UsuarioSupervisor>(context);

    // COMPROBACION DE SI VAMOS A AÑADIR O BORRAR UN USUARIO
    // SI AÑADIMOS USUARIO
    if(modoEdicion.addusuario){
      idAddDel = 0;
      textoAppBar = "AÑADIR UN USUARIO";
    }
    // SI BORRAMOS USUARIO
    else{
      idAddDel = usuarioSupervisor.id;
      textoAppBar = "BORRAR UN USUARIO";
    }

    Future<List<Usuario>> recuperarUsuarios() async{
      // MODO REMOTO
      if(modoTrabajo.modoLocal){
        return u.getUsuariosSupervisor(idAddDel);
      }
      // MODO LOCAL
      else{
        return await bdHelper.getUsuariosSupervisor(idAddDel);
      }
    }

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
                      onTap: (){
                        // MOSTRAR DIALOGO DE CONFIRMACION PARA AÑADIR/BORRAR
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