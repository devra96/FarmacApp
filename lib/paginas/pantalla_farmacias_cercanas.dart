import 'package:flutter/material.dart';

/// Pantalla donde se ha intentado implementar un mapa
/// que nos muestre las farmacias cercanas en base a la
/// direccion que hemos introducido, pero no ha sido posible.
/// 
/// Se ha intentado usar una libreria de mapas de Google,
/// pero es de pago.
///
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
                        fontSize: 20,
                        color: Colors.white
                      ),
                    ),
                    onPressed: (){
                      
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}