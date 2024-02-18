import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// WIDGET DEL MENU QUE SE MUESTRA AL PULSAR EN LA IMAGEN
/// DE UN MEDICAMENTO PARA CAMBIARLA POR UNA FOTOGRAFIA O
/// UNA IMAGEN DE LA GALERIA.
/// 
class BotonAddImagen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var modoEdicion = Provider.of<ModoEdicion>(context);

    return AlertDialog(
      title: Center(child: Text('Escoge una opción')),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton.icon(
            icon: Icon(Icons.camera_alt),
            label: Text('Hacer una fotografia'),
            onPressed: (){
              modoEdicion.fotocamara = 1;
              Navigator.pop(context);
            },
          ),
          ElevatedButton.icon(
            onPressed: (){
              modoEdicion.fotocamara = 2;
              Navigator.pop(context);
            },
            icon: Icon(Icons.image),
            label: Text('Seleccionar imagen'),
          ),
        ],
      ),
    );
  }
}
