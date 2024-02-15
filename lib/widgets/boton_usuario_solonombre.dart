// // import 'package:flutter/material.dart';

// // class BotonUsuarioSoloNombre extends StatelessWidget {
  
  

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 130,
// //       padding: EdgeInsets.all(8),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         border: Border.all(color: Colors.grey),
// //         borderRadius: BorderRadius.circular(8),
// //       ),
// //       child: Column(
// //         children: [
// //           Container(
// //             width: 120,
// //             height: double.infinity, // Altura máxima
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               border: Border.all(color: Colors.black),
// //             ),
// //             child: Image.asset('assets/images/abuelo.jpg'),
// //           ),
// //           // ESPACIO HORIZONTAL
// //           SizedBox(
// //             height: 8
// //           ),
// //           Expanded(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Container(
// //                   height: 30,
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(8),
// //                     border: Border.all(color: Colors.black),
// //                   ),
// //                   child: Center(
// //                     child: Text(
// //                       nombre,
// //                       style: TextStyle(
// //                         fontSize: 20,
// //                         fontWeight: FontWeight.bold,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// class BotonUsuarioSoloNombre extends StatelessWidget {

//   final String nombre;

//   const BotonUsuarioSoloNombre({
//     super.key,
//     required this.nombre
//   });
  
//   @override
//   Widget build(BuildContext context) {
//     // return Container(
//     //   padding: EdgeInsets.all(10), // Añade un padding de 10 en todos los lados
//     //   decoration: BoxDecoration(
//     //     border: Border.all(color: Colors.black), // Borde negro
//     //   ),
//     //   child: Column(
//     //     crossAxisAlignment: CrossAxisAlignment.center,
//     //     children: [
//     //       Image.asset(
//     //         'assets/images/abuelo.jpg', // Ruta de tu imagen desde los assets
//     //         width: 200, // Ancho deseado de la imagen
//     //         height: 200, // Altura deseada de la imagen
//     //       ),
//     //       SizedBox(height: 10), // Espacio de 10 píxeles entre la imagen y el texto
//     //       Text(
//     //         nombre,
//     //         style: TextStyle(
//     //           fontSize: 16, // Tamaño de la fuente del texto
//     //           fontWeight: FontWeight.bold, // Negrita
//     //         ),
//     //       ),
//     //     ],
//     //   ),
//     // );

//     return
//     Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black), // Borde negro alrededor de la imagen
//           ),
//           child: Image.asset('assets/images/abuelo.jpg', fit: BoxFit.fill,),
//         ),
//         SizedBox(
//           height: 10
//         ),
//         Text(
//           nombre,
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }