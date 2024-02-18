import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/widgets/dialogo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// WIDGET DE UN DIALOGO QUE SE MOSTRARA SI HEMOS MODIFICADO
/// LAS DOSIS INCLUIDAS DE UN MEDICAMENTO.
/// NOS PREGUNTARA LAS DOSIS QUE NOS HEMOS TOMADO, PARA QUE
/// EL SISTEMA HAGA EL CALCULO DE LAS DOSIS RESTANTES.
///
class DialogoDosisConsumidas extends StatelessWidget {

  final int dosisincluidas;

  const DialogoDosisConsumidas({
    super.key,
    required this.dosisincluidas
  });

  @override
  Widget build(BuildContext context) {

    var modoEdicion = Provider.of<ModoEdicion>(context);

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        title: Text('¿Ya ha tomado alguna dosis?'),
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Ingrese el numero de dosis que ya ha tomado. Si NO ha tomado aun ninguna dosis, no introduzca ningun numero u pulse en "Aceptar".'),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  // hintText: 'Dosis consumidas',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                  if(value == ""){
                    modoEdicion.dosisconsumidas = 0;
                  }
                  else{
                    modoEdicion.dosisconsumidas = int.parse(value);
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: (){
              modoEdicion.confirmacion = false;
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: (){
              if(dosisincluidas < modoEdicion.dosisconsumidas){
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => Dialogo(texto: "Introduce una cantidad inferior (No puedes haber consumido ${modoEdicion.dosisconsumidas} dosis si la caja incluye ${dosisincluidas} dosis.)")
                );
              }
              else{
                modoEdicion.confirmacion = true;
                Navigator.of(context).pop();
              }
            },
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}