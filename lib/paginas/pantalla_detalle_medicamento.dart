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
        automaticallyImplyLeading: false, // HACE QUE NO SALGA EL BOTON DE VOLVER
        title: Center(
          child: Text("NOMBRE DEL MEDICAMENTO"),
        ),
      ),
      // ####################  BODY  ####################
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          // CUADRO FOTO
          Center(
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all()
              ),
              child: const Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 65)),
                  Icon(Icons.photo_camera, size: 60, color: Colors.white,),
                ]
              ),
            ),
          ),
          // TEXTO "Ultima dosis"
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "Ultima dosis: 12/12/2023 00:54",
                style: TextStyle(
                  fontSize: 24
                ),
              )
            ),
          ),
          // TEXTO "Proxima dosis"
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "Proxima dosis: 12/12/2023 00:54",
                style: TextStyle(
                  fontSize: 24
                ),
              )
            ),
          ),
          // BOTON RENOVAR
          Center(
            child: Container(
              width: 300,
              margin: EdgeInsets.only(top: 30),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: TextButton(
                child: const Text(
                  "YA ME LA HE TOMADO",
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
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "Dosis restantes: 73",
                style: TextStyle(
                  fontSize: 24
                ),
              )
            ),
          ),
          // TEXTO "Gestionado por"
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                "Gestionado por: El pepe",
                style: TextStyle(
                  fontSize: 24
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
            icon: Icon(Icons.star),
            label: "Informacion\nprincipal",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Informacion\nadicional"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_forever),
            label: "Eliminar\nmedicamento"
          ),
        ],
        onTap: (value){
          switch (value){
            case 0:
              // CARGAR INFORMACION PRINCIPAL
              setState(() {});
            break;
            case 1:
              // CARGAR INFORMACION ADICIONAL
              setState(() {});
            break;
            case 2:
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