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

// ANTIGUA BOTTOMNAVIGATIONBAR
// bottomNavigationBar: Container(
//   height: 80,
//   color: const Color.fromARGB(255, 5, 133, 9),
//   child: InkWell(
//     onTap: () {
//       _loadPantallaAddMedicamento();
//     },
//     child: Container(
//       padding: EdgeInsets.only(top: 8.0),
//       child: const Column(
//         children: [
//           Icon(Icons.add, size: 35, color: Colors.white),
//           Text(
//             "AÑADIR MEDICAMENTO",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 20
//             )
//           ),
//         ],
//       ),
//     ),
//   ),
// ),

// PANTALLA CREAR USUARIO, ANTERIOR BODY

// ListView(
//   padding: EdgeInsets.all(16),
//   children: [
//     // TEXTO: "Introduzca su nombre y apellidos"
//     Center(
//       child: Container(
//         margin: EdgeInsets.only(bottom: 10),
//         child: Text(
//           "Introduzca su nombre y apellidos",
//           style: TextStyle(
//             fontSize: 19
//           ),
//         ),
//       ),
//     ),
//     // TEXFIELD NOMBRE COMPLETO USUARIO
//     Center(
//       child: Container(
//         width: 350,
//         margin: EdgeInsets.only(bottom: 20),
//         child: TextField(
//           decoration: InputDecoration(
//             hintText: "Nombre Apellido1 Apellido2",
//             border: OutlineInputBorder(),
//           ),
//           onChanged: (value){
//             nombre = value;
//           },
//         ),
//       ),
//     ),
//     // TEXTO: "Introduzca su correo electronico"
//     Center(
//       child: Container(
//         margin: EdgeInsets.only(bottom: 10),
//         child: Text(
//           "Introduzca su correo electronico",
//           style: TextStyle(
//             fontSize: 19
//           ),
//         ),
//       ),
//     ),
//     // TEXFIELD CORREO ELECTRONICO USUARIO
//     Center(
//       child: Container(
//         width: 350,
//         margin: EdgeInsets.only(bottom: 20),
//         child: TextField(
//           decoration: InputDecoration(
//             hintText: "Correo electronico",
//             border: OutlineInputBorder(),
//           ),
//           onChanged: (value){
//             correo = value;
//           },
//         ),
//       ),
//     ),
//     // TEXTO: "Introduzca una contraseña"
//     Center(
//       child: Container(
//         margin: EdgeInsets.only(bottom: 10),
//         child: Text(
//           "Introduzca una contraseña",
//           style: TextStyle(
//             fontSize: 19
//           ),
//         ),
//       ),
//     ),
//     // TEXFIELD CONTRASEÑA USUARIO
//     Center(
//       child: Container(
//         width: 350,
//         margin: EdgeInsets.only(bottom: 20),
//         child: TextField(
//           obscureText: true,
//           decoration: InputDecoration(
//             hintText: "Contraseña",
//             border: OutlineInputBorder(),
//           ),
//           onChanged: (value){
//             pass = value;
//           },
//         ),
//       ),
//     ),
//     // TEXTO: "Confirme la contraseña"
//     Center(
//       child: Container(
//         margin: EdgeInsets.only(bottom: 10),
//         child: Text(
//           "Confirme la contraseña",
//           style: TextStyle(
//             fontSize: 19
//           ),
//         ),
//       ),
//     ),
//     // TEXFIELD CONFIRMAR CONTRASEÑA USUARIO
//     Center(
//       child: Container(
//         width: 350,
//         margin: EdgeInsets.only(bottom: 20),
//         child: TextField(
//           obscureText: true,
//           decoration: InputDecoration(
//             hintText: "Contraseña",
//             border: OutlineInputBorder(),
//           ),
//           onChanged: (value){
//             confirmarpass = value;
//           },
//         ),
//       ),
//     ),
//     // BOTON INICIAR SESION
//     Center(
//       child: Container(
//         width: 300,
//         margin: EdgeInsets.only(top: 20),
//         decoration: const BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.all(Radius.circular(8))
//         ),
//         child: TextButton(
//           child: const Text(
//             "CREAR USUARIO",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 22
//             ),
//           ),
//           onPressed: () async{
//             // CONSULTAMOS A LA BASE DE DATOS SI EXISTE ALGUN USUARIO CON EL CORREO INTRODUCIDO
//             // SI EXISTE, GUARDARA 1
//             // SI NO, GUARDARA 0
//             int c = await bdHelper.comprobarCorreo("usuarios", correo);

//             // SI EL USUARIO NO HA RELLENADO TODOS LOS CAMPOS
//             if(nombre == "" || correo == "" || pass == "" || confirmarpass == ""){
//               showDialog<void>(
//                 context: context,
//                 builder: (BuildContext context) => Dialogo(texto: 'Por favor, rellena todos los campos.')
//               );
//             }
//             // SI LAS CONTRASEÑAS NO COINCIDEN
//             else if(pass != confirmarpass){
//               showDialog<void>(
//                 context: context,
//                 builder: (BuildContext context) => Dialogo(texto: '¡Las contraseñas no coinciden!')
//               );
//             }
//             // COMPROBACION DE SI EL CORREO INTRODUCIDO YA EXISTE EN LA BASE DE DATOS
//             else if(c != 0){
//               showDialog<void>(
//                 context: context,
//                 builder: (BuildContext context) => Dialogo(texto: 'Ya existe un usuario registrado con la cuenta de correo proporcionada.')
//               );
//             }
//             // INSERCION DEL USUARIO EN LA BASE DE DATOS Y VOLVEMOS ATRAS
//             else{
//               bdHelper.insertarBD("usuarios",{'nombre':nombre, 'correo':correo, 'password':pass});
//               print("USUARIO CREADO.");
//               Navigator.pop(context);
//             }
//           },
//         ),
//       ),
//     ),
//   ],
// ),