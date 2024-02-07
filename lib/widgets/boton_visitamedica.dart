import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.all(4),
  //     child: Text(
  //       "ESPECIALIDAD: $especialidad\nDOCTOR: $doctor\nLUGAR: $lugar\nFECHA Y HORA: $fechayhora",
  //       style: TextStyle(
  //         fontSize: 12
  //       ),
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     padding: EdgeInsets.all(12),
  //     // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //     decoration: BoxDecoration(
  //       color: Colors.blue[100],
  //       borderRadius: BorderRadius.circular(8),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.5),
  //           spreadRadius: 2,
  //           blurRadius: 4,
  //           offset: Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "ESPECIALIDAD: $especialidad",
  //           style: TextStyle(
  //             fontSize: 16,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         SizedBox(height: 4),
  //         Text(
  //           "DOCTOR: $doctor",
  //           style: TextStyle(
  //             fontSize: 14,
  //           ),
  //         ),
  //         SizedBox(height: 4),
  //         Text(
  //           "LUGAR: $lugar",
  //           style: TextStyle(
  //             fontSize: 14,
  //           ),
  //         ),
  //         SizedBox(height: 4),
  //         Text(
  //           "FECHA Y HORA: $fechayhora",
  //           style: TextStyle(
  //             fontSize: 14,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blue, // Color de fondo del icono
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.medical_services_outlined,
              size: 60,
              color: Colors.white, // Color del icono
            ),
          ),
          SizedBox(width: 8), // Espacio entre el icono y la columna de texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ESPECIALIDAD: $especialidad",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  "DOCTOR: $doctor",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  "LUGAR: $lugar",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  "FECHA Y HORA: $fechayhora",
                  style: TextStyle(
                    fontSize: 12,
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