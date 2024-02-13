// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:farmacapp/provider/modo_edicion.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class TakePictureScreen extends StatefulWidget {
//   final CameraDescription camera;
  
//   const TakePictureScreen({
//     super.key,
//     required this.camera,
//   });

//   @override
//   TakePictureScreenState createState() => TakePictureScreenState();
// }

// class TakePictureScreenState extends State<TakePictureScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();

//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.medium,
//     );

//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(title: const Text('FOTO DEL MEDICAMENTO')),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot){
//           if(snapshot.connectionState == ConnectionState.done){
//             return CameraPreview(_controller);
//           }
//           else{
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(bottom: 35),
//         child: FloatingActionButton(
//           onPressed: () async{
//             try{
//               await _initializeControllerFuture;
        
//               final image = await _controller.takePicture();
        
//               if(!mounted) return;
        
//               // // If the picture was taken, display it on a new screen.
//               // await Navigator.of(context).push(
//               //   MaterialPageRoute(
//               //     builder: (context) => DisplayPictureScreen(
//               //       // Pass the automatically generated path to
//               //       // the DisplayPictureScreen widget.
//               //       imagePath: image.path,
//               //     ),
//               //   ),
//               // );
        
//               Navigator.pop(context);
//             }
//             catch(e){
//               print(e);
//             }
//           },
//           child: const Icon(Icons.camera_alt),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
//     );

//     // return Scaffold(
//     //   appBar: AppBar(title: const Text('FOTO DEL MEDICAMENTO')),
//     //   body: Container(
//     //     color: Colors.black,
//     //     child: Column(
//     //       mainAxisAlignment: MainAxisAlignment.center,
//     //       children: [
//     //         Expanded(
//     //           child: FutureBuilder<void>(
//     //             future: _initializeControllerFuture,
//     //             builder: (context, snapshot) {
//     //               if (snapshot.connectionState == ConnectionState.done) {
//     //                 return CameraPreview(_controller);
//     //               } else {
//     //                 return Center(child: CircularProgressIndicator());
//     //               }
//     //             },
//     //           ),
//     //         ),
//     //         // Coloca aquí el FloatingActionButtom
//     //         FloatingActionButton(
//     //           onPressed: () async {
//     //             try {
//     //               await _initializeControllerFuture;
//     //               final image = await _controller.takePicture();
//     //               if (!mounted) return;
//     //               Navigator.pop(context);
//     //             } catch (e) {
//     //               print(e);
//     //             }
//     //           },
//     //           child: const Icon(Icons.camera_alt),
//     //         ),
//     //         SizedBox(height: 20), // Espacio entre el FAB y el final de la pantalla
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
// }

// class DisplayPictureScreen extends StatelessWidget {
//   final String imagePath;

//   const DisplayPictureScreen({
//     super.key,
//     required this.imagePath
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('FOTO REALIZADA')),
//       body: Image.file(File(imagePath)),
//     );
//   }
// }