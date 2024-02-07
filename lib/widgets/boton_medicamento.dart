import 'package:flutter/material.dart';

class BotonMedicamento extends StatelessWidget {
  final String nombre;
  final String ultimaDosis;
  final String proximaDosis;
  final int dosisRestantes;
  final MaterialColor colorFondo;
  
  const BotonMedicamento({
    super.key,
    required this.nombre,
    required this.ultimaDosis,
    required this.proximaDosis,
    required this.dosisRestantes,
    required this.colorFondo
  });

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.all(4),
  //     child: Text(
  //       "$nombre\nULTIMA DOSIS: $ultimaDosis\nPROXIMA DOSIS: $proximaDosis",
  //       style: TextStyle(
  //         fontSize: 16
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colorFondo.withOpacity(0.5),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            height: double.infinity, // Altura máxima
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
            ),
            child: Image.asset('assets/images/medicamento-generico.jpg'),
          ),
          // ESPACIO HORIZONTAL
          SizedBox(
            width: 8
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      nombre,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      "Ultima dosis: $ultimaDosis",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      "Proxima dosis: $proximaDosis",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      "Dosis restantes: $dosisRestantes",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}