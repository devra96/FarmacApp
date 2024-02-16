import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BotonVisitaMedica extends StatelessWidget {
  final String especialidad;
  final String doctor;
  final String lugar;
  final String fechayhora;
  // final MaterialColor colorFondo;
  
  const BotonVisitaMedica({
    super.key,
    required this.especialidad,
    required this.doctor,
    required this.lugar,
    required this.fechayhora,
    // required this.colorFondo
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
    // return Container(
    //   padding: EdgeInsets.all(4),
    //   child: Row(
    //     children: [
    //       Container(
    //         width: 100,
    //         height: 100,
    //         decoration: BoxDecoration(
    //           color: Colors.blue, // Color de fondo del icono
    //           borderRadius: BorderRadius.circular(8),
    //         ),
    //         child: Icon(
    //           Icons.medical_services_outlined,
    //           size: 60,
    //           color: Colors.white, // Color del icono
    //         ),
    //       ),
    //       SizedBox(width: 8), // Espacio entre el icono y la columna de texto
    //       Expanded(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               "ESPECIALIDAD: $especialidad",
    //               style: TextStyle(
    //                 fontSize: 12,
    //               ),
    //             ),
    //             Text(
    //               "DOCTOR: $doctor",
    //               style: TextStyle(
    //                 fontSize: 12,
    //               ),
    //             ),
    //             Text(
    //               "LUGAR: $lugar",
    //               style: TextStyle(
    //                 fontSize: 12,
    //               ),
    //             ),
    //             Text(
    //               "FECHA Y HORA: $fechayhora",
    //               style: TextStyle(
    //                 fontSize: 12,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    // return Container(
    //   height: 130,
    //   padding: EdgeInsets.all(8),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     border: Border.all(color: Colors.grey),
    //     borderRadius: BorderRadius.circular(8),
    //   ),
    //   child: Row(
    //     children: [
    //       // Container(
    //       //   width: 120,
    //       //   height: double.infinity, // Altura máxima
    //       //   decoration: BoxDecoration(
    //       //     color: Colors.white,
    //       //     border: Border.all(color: Colors.black),
    //       //   ),
    //       //   // child: Image.asset('assets/images/medicamento-generico.jpg'),
    //       // ),
    //       // ESPACIO HORIZONTAL
    //       // SizedBox(
    //       //   width: 8
    //       // ),
    //       Expanded(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Container(
    //               height: 30,
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(8),
    //                 border: Border.all(color: Colors.black),
    //               ),
    //               child: Center(
    //                 child: Text(
    //                   "Especialidad: $especialidad",
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               height: 30,
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(8),
    //                 border: Border.all(color: Colors.black),
    //               ),
    //               child: Center(
    //                 child: Text(
    //                   "Doctor: $doctor",
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               height: 30,
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(8),
    //                 border: Border.all(color: Colors.black),
    //               ),
    //               child: Center(
    //                 child: Text(
    //                   "Lugar: $lugar",
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             Container(
    //               height: 30,
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(8),
    //                 border: Border.all(color: Colors.black),
    //               ),
    //               child: Center(
    //                 child: Text(
    //                   "Fecha y hora: $fechayhora",
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );

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
              crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda
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