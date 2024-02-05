// // PANTALLA INICIO SESION OLD

// late String user = "";
// late String pass = "";
// BDHelper bdHelper = BDHelper();

// // ####################  BODY  ####################
//       body: ListView(
//         children: [
//           // LOGO
//           Image.asset("assets/images/logo.png"),
//           // USUARIO
//           Center(
//             child: Container(
//               padding: EdgeInsets.only(top: 20),
//               child: const Text(
//                 "Introduzca su nombre de usuario",
//                 style: TextStyle(
//                   fontSize: 20
//                 ),
//               ),
//             ),
//           ),
//           // TEXTFIELD USUARIO
//           Center(
//             child: Container(
//               width: 300,
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: "Nombre de usuario",
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value){
//                   user = value;
//                 },
//               ),
//             ),
//           ),
//           // CONTRASEÑA
//           Center(
//             child: Container(
//               padding: EdgeInsets.only(top: 20),
//               child: const Text(
//                 "Introduzca su contraseña",
//                 style: TextStyle(
//                   fontSize: 20
//                 ),
//               ),
//             ),
//           ),
//           // TEXTFIELD CONTRASEÑA
//           Center(
//             child: Container(
//               width: 300,
//               child: TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: "Contraseña"
//                 ),
//                 onChanged: (value){
//                   pass = value;
//                 },
//               ),
//             ),
//           ),
//           // TEXTO SI HA OLVIDADO LA CONTRASEÑA
//           Center(
//             child: InkWell(
//               child: Container(
//                 padding: EdgeInsets.only(top: 10, bottom: 20),
//                 child: Text(
//                   "Si ha olvidado la contraseña, haga click aqui",
//                   style: TextStyle(
//                     color: Colors.red
//                   ),
//                 ),
//               ),
//               onTap: (){
//                 print("IR A PANTALLA CONTRASEÑA OLVIDADA");
//                 _loadPantallaPassOlvidada();
//               },
//             ),
//           ),
//           // BOTON INICIAR SESION
//           Center(
//             child: Container(
//               width: 300,
//               decoration: const BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.all(Radius.circular(8))
//               ),
//               child: TextButton(
//                 child: const Text(
//                   "INICIAR SESION",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 22
//                   ),
//                 ),
//                 onPressed: () async{
//                   // SI EL USUARIO NO HA RELLENADO AMBOS CAMPOS
//                   if(user == "" || pass == ""){
//                     showDialog<void>(
//                       context: context,
//                       builder: (BuildContext context) => AlertDialog(
//                         content: const Text(
//                           'Por favor, rellena ambos campos.',
//                           style: TextStyle(
//                             fontSize: 16
//                           )
//                         ),
//                         actions: <TextButton>[
//                           TextButton(
//                             onPressed: (){
//                               Navigator.pop(context);
//                             },
//                             child: const Center(
//                               child: Text('Aceptar')
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   }
//                   else{
//                     // SI EL USUARIO Y CONTRASEÑA COINDICEN
//                     if(await bdHelper.comprobarLogin("usuarios", user, pass) != ""){
//                       // print("ID DEL USUARIO INICIADO: ${await bdHelper.comprobarLogin("usuarios", user, pass)}");
//                       _loadPantallaAgenda();
//                     }
//                     // SI EL USUARIO Y/O CONTRASEÑA SON INCORRECTOS
//                     else{
//                       showDialog<void>(
//                       context: context,
//                       builder: (BuildContext context) => AlertDialog(
//                         content: const Text(
//                           'Usuario y/o contraseña incorrectos.',
//                           style: TextStyle(
//                             fontSize: 16
//                           )
//                         ),
//                         actions: <TextButton>[
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Center(
//                               child: Text('Aceptar')
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                     }
//                   }
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//       // BOTON FLOTANTE
//       floatingActionButton: Container(
//         width: 90,
//         height: 70,
//         child: FloatingActionButton(
//           onPressed: (){
//             // IR A PANTALLA NUEVO USUARIO
//             _loadPantallaNuevoUsuario();
//           },
//           child: Text(
//             "¿Nuevo usuario? Haz click aqui.",
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),

// SNACKBAR
// ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: Text("Respuesta: $response")
//   )
// );

// PANTALLA AGENDA
// DEBAJO DE InkWell > onTap

// child: ListView(
//   padding: EdgeInsets.all(2),
//   children: [
//     Text(
//       "DIAZEPAM",
//       style: TextStyle(fontSize: 25),
//     ),
//     Text(
//       "Ultima dosis: 17/08/2023 - 09:00",
//       style: TextStyle(fontSize: 16),
//     ),
//     Text(
//       "Ultima dosis: 17/08/2023 - 09:00",
//       style: TextStyle(fontSize: 16),
//     ),
//   ],
// ),
// child: Container(
//   padding: EdgeInsets.all(4),
//   child: const Text(
//     "DIAZEPAM\nUltima dosis: 17/08/2023 - 09:00\nProxima dosis: 18/08/2023 - 09:00",
//     style: TextStyle(
//       fontSize: 16
//     ),
//   ),
// ),