import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// WIDGET QUE SIMULA UN BOTON PARA CADA UNA DE LAS
/// VISITAS MEDICAS DE UN USUARIO.
/// 
class BotonVisitaMedica extends StatelessWidget {
  final String especialidad;
  final String doctor;
  final String lugar;
  final String fechayhora;
  
  const BotonVisitaMedica({
    super.key,
    required this.especialidad,
    required this.doctor,
    required this.lugar,
    required this.fechayhora,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      "VISITA MEDICA",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "ESPECIALIDAD: $especialidad",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
                Text(
                  "DOCTOR: $doctor",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
                Text(
                  "LUGAR: $lugar",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
                Text(
                  "FECHA Y HORA: $fechayhora",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
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