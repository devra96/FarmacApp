import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// WIDGET DE MENU QUE SE MUESTRA CUANDO PULSAMOS EN UNA
/// VISITA MEDICA PARA MODIFICARLA O BORRARLA.
/// 
class BotonClickVisitaMedica extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var modoEdicion = Provider.of<ModoEdicion>(context);
    
    return AlertDialog(
      title: Center(child: Text("¿Qué quieres hacer?")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "EDITAR LA VISITA",
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () {
              modoEdicion.modoedicion = true;
              modoEdicion.confirmacion = false;
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: 8),
          ElevatedButton(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "BORRAR LA VISITA",
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () {
              modoEdicion.modoedicion = false;
              modoEdicion.confirmacion = true;
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: 8),
          ElevatedButton(
            child: SizedBox(
              width: double.infinity,
              child: Text(
                "Cancelar",
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
