import 'dart:io';

import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/paginas/pantalla_inicio.dart';
import 'package:farmacapp/paginas/pantalla_mod_usuario.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/provider/modo_trabajo.dart';
import 'package:farmacapp/provider/usuario_supervisor.dart';
import 'package:farmacapp/widgets/dialogo_confirmacion.dart';
import 'package:farmacapp/widgets/menu_click_add_imagen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

/// Pantalla donde visualizaremos nuestros datos y nuestra foto,
/// junto con las opciones de modificar el perfil o contraseña
/// y la opcion de eliminar la cuenta.
/// 
class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});

  @override
  State<PantallaPerfil> createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {

  // INSTACIA CLASE USUARIO PARA UTILIZAR SUS METODOS HTTP
  Usuario u = Usuario();

  // INSTANCIA A BASE DE DATOS LOCAL
  BDHelper bdHelper = BDHelper();

  // VARIABLES PARA SI MODIFICAMOS LA FOTO DEL MEDICAMENTO
  // Y CARGAMOS UNA DE LA CAMARA O GALERIA
  bool fotoModificada = false;
  File ? _selectedImage;

  // METODOS
  _loadPantallaModUsuario() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaModUsuario());
    final datoDevuelto = await Navigator.push(context, destino);
  }

  _loadPantallaInicio() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaInicio());
    final datoDevuelto = await Navigator.push(context, destino);
  }

  // METODO QUE ABRE LA CAMARA O LA GALERIA SEGUN LA OPCION QUE HAYAMOS
  // ESCOGIDO EN EL MENU TRAS PULSAR EN LA IMAGEN DEL MEDICAMENTO
  Future _pickImage(int fromCamera) async{
    final returnedImage;
    
    if(fromCamera == 1){
      returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    }
    else{
      returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    if(returnedImage == null) return;

    setState(() {
      fotoModificada = true;
      _selectedImage = File(returnedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {

    // PROVIDERS
    var usuarioIniciado = Provider.of<Usuario>(context);
    var usuarioSupervisor = Provider.of<UsuarioSupervisor>(context);
    var modoEdicion = Provider.of<ModoEdicion>(context);
    var modoTrabajo = Provider.of<ModoTrabajo>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("PERFIL"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ESPACIO
          SizedBox(
            height: 20,
          ),
          // CUADRO FOTO
          InkWell(
            child: Center(
              child: Container(
                width: 300,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all()
                ),
                child: fotoModificada ? Image.file(_selectedImage!,fit: BoxFit.fill) : Image.asset('assets/images/abuelo.jpg', fit: BoxFit.fill)
              ),
            ),
            onTap: () async{
              modoEdicion.fotocamara = 0;
                      
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) => BotonAddImagen()
              );
              
              if(modoEdicion.fotocamara != 0){
                _pickImage(modoEdicion.fotocamara);
              }
            },
          ),
          // ESPACIO
          SizedBox(
            height: 20,
          ),
          // TEXTO "NOMBRE COMPLETO"
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              "Nombre completo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline
              ),
            ),
          ),
          // NOMBRE COMPLETO
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              (!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)) ? usuarioIniciado.nombre : usuarioSupervisor.nombre,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // ESPACIO
          SizedBox(
            height: 10,
          ),
          // TEXTO "CORREO ELECTRONICO"
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              "Correo electronico",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline
              ),
            ),
          ),
          // CORREO ELECTRONICO
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              (!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)) ? usuarioIniciado.correo : usuarioSupervisor.correo,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // BOTON MODIFICAR PERFIL
          Center(
            child: Container(
              width: 300,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF009638),
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: TextButton(
                child: Text(
                  "MODIFICAR PERFIL",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: () async{
                  modoEdicion.cambiarpass = false;
                  _loadPantallaModUsuario();
                },
              ),
            ),
          ),
          // ESPACIO
          SizedBox(
            height: 20,
          ),
          // BOTON CAMBIAR CONTRASEÑA
          Center(
            child: Container(
              width: 300,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFF009638),
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: TextButton(
                child: Text(
                  "CAMBIAR CONTRASEÑA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: () async{
                  modoEdicion.cambiarpass = true;
                  _loadPantallaModUsuario();
                },
              ),
            ),
          ),
          // ESPACIO
          SizedBox(
            height: 20,
          ),
          // BOTON BORRAR CUENTA
          Center(
            child: Container(
              width: 300,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: TextButton(
                child: Text(
                  "BORRAR CUENTA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: () async{
                  // ALERTDIALOG CONFIRMACION
                  await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) => DialogoConfirmacion(title: "¡ATENCION!", texto: "¿Esta seguro de querer borrar la cuenta? Una vez borrada, no se podrá recuperar.")
                  );

                  // SI EL USUARIO CONFIRMA BORRAR AL USUARIO
                  if(modoEdicion.confirmacion){
                    // MODO REMOTO
                    if(modoTrabajo.modoLocal){
                      // SI EL USUARIO ES ESTANDAR (NO ES SUPERVISOR, O ESTA SIENDO SUPERVISADO)
                      if(!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)){
                        u.deleteUsuario(usuarioIniciado.id);
                      }
                      // SI ES SUPERVISOR
                      else{
                        // BORRAMOS EL USUARIO
                        await u.deleteUsuario(usuarioSupervisor.id);

                        // SE ESTABLECE A 0 EL id_supervisor DE TODOS LOS USUARIOS A LOS QUE SUPERVISARA EL USUARIO BORRADO
                        for(Usuario usuario in await u.getUsuariosSupervisor(usuarioSupervisor.id)){
                          usuario.updateUsuario_idSupervisor(usuario.id, 0);
                        }
                      }
                    }
                    // MODO LOCAL
                    else{
                      // SI EL USUARIO ES ESTANDAR (NO ES SUPERVISOR, O ESTA SIENDO SUPERVISADO)
                      if(!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)){
                        bdHelper.eliminarBD("usuarios", usuarioIniciado.id);
                      }
                      // SI ES SUPERVISOR
                      else{
                        // BORRAMOS EL USUARIO
                        bdHelper.eliminarBD("usuarios", usuarioSupervisor.id);

                        // SE ESTABLECE A 0 EL id_supervisor DE TODOS LOS USUARIOS A LOS QUE SUPERVISARA EL USUARIO BORRADO
                        for(Usuario usuario in await bdHelper.getUsuariosSupervisor(usuarioSupervisor.id)){
                          bdHelper.actualizarBD("usuarios", {
                            "id": usuario.id,
                            "id_supervisor": 0
                          });
                        }
                      }
                    }

                    // SI ESTAMOS EN MODO SUPERVISOR, VOLVEMOS A LA PANTALLA DE USUARIOS
                    if(usuarioSupervisor.modosupervisor){
                      for(int i=0;i<3;i++){
                        Navigator.pop(context);
                      }
                    }
                    // EN CASO CONTRARIO, VOLVEMOS A LA PANTALLA DE INICIO
                    else{
                      _loadPantallaInicio();
                    }

                    // SNACKBAR
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("USUARIO ELIMINADO CORRECTAMENTE.")
                      )
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