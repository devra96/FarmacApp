import 'package:flutter/material.dart';

class PantallaMasOpcionesMedicamento extends StatefulWidget {
  const PantallaMasOpcionesMedicamento({super.key});

  @override
  State<PantallaMasOpcionesMedicamento> createState() => _PantallaMasOpcionesMedicamentoState();
}

class _PantallaMasOpcionesMedicamentoState extends State<PantallaMasOpcionesMedicamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #################### APPBAR ####################
      appBar: AppBar(
        // automaticallyImplyLeading: false, // HACE QUE NO SALGA EL BOTON DE VOLVER
        title: Text("MAS OPCIONES"),
      ),
      // ####################  BODY  ####################
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          // CUADRO AÑADIR UNA FOTO
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
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Icon(Icons.photo_camera, size: 60, color: Colors.white,),
                  Text("Añadir una foto", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold))
                ]
              ),
            ),
          ),
          // TEXTO "Gestionado por"
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: const Text(
                "Gestionado por",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
          ),
          // SE PONE UN TEXTFIELD PERO EN UN FUTURO SE SUSTITUIRA
          // POR UN ELEMENTO PARA SELECCIONAR A UN "ADMINISTRADOR"
          Center(
            child: Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){},
              ),
            ),
          ),
          // TEXTO "Normas de consumo"
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: const Text(
                "Normas de consumo",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
          ),
          // CARD NORMAS
          Center(
            child: Container(
              width: 300,
              child: Card(
                shape: Border.all(color: Colors.grey),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Escriba aqui para añadir texto..."
                    ),
                  ),
                ),
              ),
            ),
          ),
          // TEXTO "Caracteristicas minimas del medicamento"
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: const Text(
                "Caracteristicas del medicamento",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
            ),
          ),
          // CARD CARACTERISTICAS
          Center(
            child: Container(
              width: 300,
              child: Card(
                shape: Border.all(color: Colors.grey),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Escriba aqui para añadir texto..."
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // #############  BOTTOMNAVIGATIONBAR  ############
      bottomNavigationBar: Container(
        height: 80,
        color: const Color.fromARGB(255, 5, 133, 9),
        child: InkWell(
          onTap: (){
            // GUARDAR OPCIONES DEL MEDICAMENTO
          },
          child: Container(
            padding: EdgeInsets.only(top: 8.0),
            child: const Column(
              children: [
                Icon(
                  Icons.check,
                  size: 35,
                  color: Colors.white
                ),
                Text(
                  "GUARDAR OPCIONES",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}