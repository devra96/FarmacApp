import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/provider/usuario_supervisor.dart';
import 'package:farmacapp/widgets/boton_usuario.dart';
import 'package:farmacapp/widgets/dialogo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/modo_trabajo.dart';

/// WIDGET DE DIALOGO QUE NOS PEDIRA CONFIRMAR SI AÑADIMOS O
/// DEJAMOS DE SUPERVISAR A UN USUARIO.
/// 
class DialogoSupervisorConfirmarUsuario extends StatelessWidget {
  final String nombre;
  final String texto;
  
  const DialogoSupervisorConfirmarUsuario({
    super.key,
    required this.nombre,
    required this.texto
  });

  @override
  Widget build(BuildContext context) {

    var modoEdicion = Provider.of<ModoEdicion>(context);

    return AlertDialog(
      title: Center(child: Text('Confirmación')),
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