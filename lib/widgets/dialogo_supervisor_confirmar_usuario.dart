import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/provider/usuario_supervisor.dart';
import 'package:farmacapp/widgets/boton_usuario.dart';
import 'package:farmacapp/widgets/dialogo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/modo_trabajo.dart';

class DialogoSupervisorConfirmarUsuario extends StatelessWidget {
  final int id;
  final String nombre;
  final String texto;
  
  const DialogoSupervisorConfirmarUsuario({
    super.key,
    required this.id,
    required this.nombre,
    required this.texto
  });

  @override
  Widget build(BuildContext context) {

    // final modoTrabajo = Provider.of<ModoTrabajo>(context);
    var modoEdicion = Provider.of<ModoEdicion>(context);
    // var usuarioSupervisor = Provider.of<UsuarioSupervisor>(context);

    return AlertDialog(
      title: Center(child: Text('Confirmacion')),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(texto),
            SizedBox(
              height: 10
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Image.asset('assets/images/abuelo.jpg', fit: BoxFit.fill),
                ),
                SizedBox(
                  height: 10
                ),
                Text(
                  nombre,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Cancelar'),
          onPressed: (){
            modoEdicion.confirmacion = false;
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Aceptar'),
          onPressed: (){
            modoEdicion.confirmacion = true;
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

// // MODIFICAR ID_SUPERVISOR USUARIO Y DIALOGO SE HA AÑADIDO SETSTATE

// // MODO REMOTO
// if(modoTrabajo.modoLocal){
//   // MODIFICAMOS EL id_supervisor DEL USUARIO A SUPERVISAR
//   Usuario u = new Usuario();
//   await u.updateUsuario_idSupervisor(id, usuarioSupervisor.id);
// }
// // MODO LOCAL
// else{
//   BDHelper bdHelper = BDHelper();
//   await bdHelper.actualizarBD("usuarios", {
//     "id": id,
//     "id_supervisor": usuarioSupervisor.id
//   });
// }
// print("SUPERVISANDO A $nombre");
// Navigator.of(context).pop();
// Navigator.of(context).pop();

// showDialog<void>(
//   context: context,
//   builder: (BuildContext context) => Dialogo(texto: 'Usuario añadido correctamente.')
// );