import 'package:flutter/material.dart';

class PantallaFarmaciasCercanas extends StatefulWidget {
  const PantallaFarmaciasCercanas({super.key});

  @override
  State<PantallaFarmaciasCercanas> createState() => _PantallaFarmaciasCercanasState();
}

class _PantallaFarmaciasCercanasState extends State<PantallaFarmaciasCercanas> {
  late String direccion;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #################### APPBAR ####################
      appBar: AppBar(
        title: Text("FARMACIAS CERCANAS"),
      ),
      // ####################  BODY  ####################
      body: Container(
        // color: Colors.black,
        child: ListView(
          children: [
            // ROW: BARRA BUSQUEDA Y BOTON BUSCAR
            Row(
              children: [
                Container(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Introduce tu direccion",
                      // border: OutlineInputBorder(),
                    ),
                    onChanged: (value){
                      direccion = value;
                    },
                  ),
                ),
                Container(
                  width: 92.7,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.grey)
                  ),
                  child: TextButton(
                    child: Text(
                      "Buscar",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white
                      ),
                    ),
                    onPressed: (){
                      
                    },
                  ),
                ),
              ],
            ),
            // LISTVIEWBUILDER QUE GENERARIA AL BUSCAR, PERO DA ERROR
            // ListView.builder(
            //   itemBuilder: (context, index){
            //     return Container(
            //       height: 80,
            //       margin: EdgeInsets.all(5),
            //       child: ListView(
            //         children: [
            //           Text("Farmacia tal y cual"),
            //           Text("Calle TalyCual, nº17, 47001, Valladolid"),
            //           Text("A 500 metros de ti")
            //         ],
            //       ),
            //     );
            //   },
            //   itemCount: 3,
            // )
          ],
        ),
      ),
    );
  }
}