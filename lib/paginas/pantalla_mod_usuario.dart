import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/provider/modo_trabajo.dart';
import 'package:farmacapp/provider/usuario_supervisor.dart';
import 'package:farmacapp/widgets/dialogo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PantallaModUsuario extends StatefulWidget {
  const PantallaModUsuario({super.key});

  @override
  State<PantallaModUsuario> createState() => _PantallaModUsuarioState();
}

class _PantallaModUsuarioState extends State<PantallaModUsuario> {

  String pass = "", nuevapass = "", confirmarpass = "";
  late int id;
  late String nombre, correo, correoactual;

  Usuario u = new Usuario();
  BDHelper bdHelper = BDHelper();

  TextEditingController _textFieldNombre = TextEditingController();
  TextEditingController _textFieldCorreo = TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    var modoTrabajo = Provider.of<ModoTrabajo>(context);
    var modoEdicion = Provider.of<ModoEdicion>(context);
    var usuarioIniciado = Provider.of<Usuario>(context);
    var usuarioSupervisor = Provider.of<UsuarioSupervisor>(context);

    // GUARDAMOS EN LA VARIABLES "id", "nombre" Y "correo" LOS DATOS DEL USUARIO
    (!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)) ? id = usuarioIniciado.id : id = usuarioSupervisor.id;
    (!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)) ? nombre = usuarioIniciado.nombre : nombre = usuarioSupervisor.nombre;
    (!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)) ? correo = usuarioIniciado.correo : correo = usuarioSupervisor.correo;
    
    // ESTABLECEMOS EN "correoactual" EL CORREO DEL USUARIO
    // PARA LA COMPROBACION DE SI SE HA ESCRITO OTRO CORREO DIFERENTE
    correoactual = correo;

    // SI EL USUARIO VA A CAMBIAR LA CONTRASEÑA
    if(modoEdicion.cambiarpass){
        return Scaffold(
          appBar: AppBar(
            title: Text("CAMBIAR CONTRASEÑA"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TEXTFIELD ANTIGUA CONTRASEÑA
              Center(
                child: SizedBox(
                  width: 350,
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      labelText: "Contraseña actual"
                    ),
                    onChanged: (value) => pass = value,
                  ),
                ),
              ),
              // ESPACIO
              SizedBox(
                height: 20,
              ),
              // TEXTFIELD NUEVA CONTRASEÑA
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
                      labelText: "Nueva contraseña"
                    ),
                    onChanged: (value) => nuevapass = value,
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
                      labelText: "Confirmar la nueva contraseña"
                    ),
                    onChanged: (value) => confirmarpass = value,
                  ),
                ),
              ),
              // ESPACIO
              SizedBox(
                height: 60,
              ),
              Container(
                width: 350,
                height: 55,
                decoration: const BoxDecoration(
                  color: Color(0xFF009638),
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: TextButton(
                  child: const Text(
                    "CAMBIAR CONTRASEÑA",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: ()async{
                    // SI EL USUARIO NO HA ESCRITO NADA
                    if(pass == "" || nuevapass == "" || confirmarpass == ""){
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) => Dialogo(texto: 'Por favor, rellena todos los campos')
                      );
                    }
                    // SI LAS CONTRASEÑAS NO COINCIDEN
                    else if(nuevapass != confirmarpass){
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) => Dialogo(texto: '¡Las contraseñas no coinciden!')
                      );
                    }
                    // REQUISITOS CONTRASEÑA???

                    // ACTUALIZACION CONTRASEÑA 
                    else{
                      // MODO REMOTO
                      if(modoTrabajo.modoLocal){
                        if(await u.checkUsuario(correo, pass) == "no"){
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => Dialogo(texto: "La contraseña actual introducida es incorrecta.")
                          );
                        }
                        else{
                          // MODIFICAR PASS
                          await u.updateUsuario_pass(id, nuevapass);

                          Navigator.pop(context);

                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => Dialogo(texto: "Contraseña modificada correctamente.")
                          );
                        }
                      }
                      // MODO LOCAL
                      else{
                        if(await bdHelper.comprobarLogin("usuarios", correo, pass) != ""){
                          await bdHelper.actualizarBD("usuarios", {
                            "id": id,
                            "password": nuevapass
                          });

                          Navigator.pop(context);

                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) => Dialogo(texto: "Contraseña modificada correctamente.")
                          );
                        }
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
            ],
          ),
        );
    }
    // SI EL USUARIO VA A MODIFICAR SU PERFIL
    else{

      _textFieldNombre.text = nombre;
      _textFieldCorreo.text = correo;

      return Scaffold(
        appBar: AppBar(
          title: Text("MODIFICAR PERFIL"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TEXTFIELD NOMBRE COMPLETO
            Center(
              child: SizedBox(
                width: 350,
                child: TextField(
                  controller: _textFieldNombre,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: "Nombre completo"
                  ),
                  onChanged: (value) => nombre = value,
                ),
              ),
            ),
            // ESPACIO
            SizedBox(
              height: 20,
            ),
            // TEXTFIELD CORREO ELECTRONICO
            Center(
              child: SizedBox(
                width: 350,
                child: TextField(
                  controller: _textFieldCorreo,
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
              height: 60,
            ),
            Container(
              width: 350,
              height: 55,
              decoration: const BoxDecoration(
                color: Color(0xFF009638),
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: TextButton(
                child: const Text(
                  "MODIFICAR PERFIL",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: ()async{
                  // SI EL USUARIO NO HA ESCRITO NADA
                  if(nombre == "" || correo == ""){
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext context) => Dialogo(texto: 'Por favor, rellena todos los campos')
                    );
                  }
                  // MODIFICACION
                  else{
                    // MODO REMOTO
                    if(modoTrabajo.modoLocal){

                      // COMPROBACION DE SI EXISTE EL CORREO INTRODUCIDO
                      //
                      // TAMBIEN COMPRUEBA SI HEMOS ESCRITO EL MISMO CORREO, DE SER ASI,
                      // NOS DEJA CONTINUAR PARA PODER CAMBIAR SOLAMENTE EL NOMBRE
                      if(await u.checkUsuarioExistente(correo) != 0 && correoactual != correo){
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => Dialogo(texto: 'Ya existe un usuario registrado con la cuenta de correo proporcionada.')
                        );
                      }
                      else{
                        u.updateUsuario_nombreycorreo(id, nombre, correo);
                        
                        (!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)) ? usuarioIniciado.nombre = nombre : usuarioSupervisor.nombre = nombre;
                        (!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)) ? usuarioIniciado.correo = correo : usuarioSupervisor.correo = correo;
                        
                        Navigator.pop(context);

                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => Dialogo(texto: "Usuario modificado correctamente.")
                        );
                      }
                    }
                    // MODO LOCAL
                    else{
                      // COMPROBACION CORREO
                      if(await bdHelper.comprobarCorreo("usuarios", correo) != 0){
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => Dialogo(texto: 'Ya existe un usuario registrado con la cuenta de correo proporcionada.')
                        );
                      }
                      else{
                        await bdHelper.actualizarBD("usuarios", {
                          "id": id,
                          "nombre": nombre,
                          "correo": correo
                        });

                        (!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)) ? usuarioIniciado.nombre = nombre : usuarioSupervisor.nombre = nombre;
                        (!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)) ? usuarioIniciado.correo = correo : usuarioSupervisor.correo = correo;

                        Navigator.pop(context);

                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => Dialogo(texto: "Usuario modificado correctamente.")
                        );
                      }
                    }
                  }
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}