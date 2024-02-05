import 'package:flutter/material.dart';

class PantallaDetalleMedicamento extends StatefulWidget {
  const PantallaDetalleMedicamento({super.key});

  @override
  State<PantallaDetalleMedicamento> createState() => _PantallaDetalleMedicamentoState();
}

class _PantallaDetalleMedicamentoState extends State<PantallaDetalleMedicamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #################### APPBAR ####################
      appBar: AppBar(
        title: Text("NOMBRE DEL MEDICAMENTO"),
      ),
      // ####################  BODY  ####################
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          // CUADRO FOTO
          // Center(
          //   child: Container(
          //     width: 300,
          //     height: 200,
          //     decoration: BoxDecoration(
          //       color: Colors.grey,
          //       border: Border.all()
          //     ),
          //     child: const Column(
          //       children: [
          //         Padding(padding: EdgeInsets.only(top: 65)),
          //         Icon(Icons.photo_camera, size: 60, color: Colors.white,),
          //       ]
          //     ),
          //   ),
          // ),
          // TEXTO "Ultima dosis"
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Ultima dosis: 12/12/2023 00:54",
                style: TextStyle(
                  fontSize: 20
                ),
              )
            ),
          ),
          // TEXTO "Proxima dosis"
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Proxima dosis: 12/12/2023 00:54",
                style: TextStyle(
                  fontSize: 20
                ),
              )
            ),
          ),
          // BOTON RENOVAR
          Center(
            child: Container(
              width: 300,
              margin: EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: TextButton(
                child: const Text(
                  "REGISTRAR DOSIS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22
                  ),
                ),
                onPressed: (){},
              ),
            ),
          ),
          // TEXTO "Dosis restantes"
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Dosis restantes: 73",
                style: TextStyle(
                  fontSize: 20
                ),
              )
            ),
          ),
          // TEXTO "Gestionado por"
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Gestionado por: Administrador",
                style: TextStyle(
                  fontSize: 20
                ),
              )
            ),
          ),
          // TEXTO "Normas de consumo"
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Normas de consumo",
                
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.underline
                ),
              )
            ),
          ),
          // NORMAS DE CONSUMO
          Center(
            child: Container(
              child: Text(
                "Algunas normas de consumo de dicho medicamento",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20
                ),
              )
            ),
          ),
          // TEXTO "Caracteristicas generales"
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Caracteristicas generales",
                
                style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.underline
                ),
              )
            ),
          ),
          // CARACTERISTICAS GENERALES
          Center(
            child: Container(
              child: Text(
                "Algunas caracteristicas generales de dicho medicamento",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20
                ),
              )
            ),
          ),
        ],
      ),
      // #############  BOTTOMNAVIGATIONBAR  ############
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.mode_edit),
            label: "Modificar\nmedicamento"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_forever),
            label: "Eliminar\nmedicamento"
          ),
        ],
        onTap: (value){
          switch (value){
            case 0:
              // IR A PANTALLA MAS OPCIONES MEDICAMENTO
              // CARGANDO LOS DATOS DEL MEDICAMENTO ?????
              setState(() {});
            break;
            case 1:
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Center(child: const Text('¡ATENCION!')),
                  content: const Text('¿Estas seguro de que deseas eliminar este medicamento?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('CANCELAR'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('CONFIRMAR'),
                    ),
                  ],
                ),
              );
              setState(() {});
            break;
          }
        },
      ),
    );
  }
}