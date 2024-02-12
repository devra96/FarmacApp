import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/widgets/dialogo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogoConfirmacion extends StatelessWidget {

  final String texto;

  const DialogoConfirmacion({
    super.key,
    required this.texto
  });

  @override
  Widget build(BuildContext context) {

    var modoEdicion = Provider.of<ModoEdicion>(context);

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        title: Text('ATENCIÓN'),
        content: Container(
          child: Text(
            texto
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancelar'),
            onPressed: (){
              modoEdicion.eliminar = false;
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Aceptar'),
            onPressed: (){
              modoEdicion.eliminar = true;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}