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

// DETALLES MEDICAMENTO

// ####################  BODY  ####################
// body: ListView(
//   padding: EdgeInsets.all(10),
//   children: [
//     // CUADRO FOTO
//     Center(
//       child: Container(
//         width: 300,
//         height: 200,
//         decoration: BoxDecoration(
//           // color: Colors.grey,
//           border: Border.all()
//         ),
//         // child: const Column(
//         //   children: [
//         //     Padding(padding: EdgeInsets.only(top: 65)),
//         //     Icon(Icons.photo_camera, size: 60, color: Colors.white,),
//         //   ]
//         // ),
//         child: Image.asset('assets/images/medicamento-generico.jpg'),
//       ),
//     ),
//     // TEXTO "Ultima dosis"
//     Center(
//       child: Container(
//         margin: EdgeInsets.only(top: 20),
//         child: Text(
//           "Ultima dosis: 12/12/2023 00:54",
//           style: TextStyle(
//             fontSize: 20
//           ),
//         )
//       ),
//     ),
//     // TEXTO "Proxima dosis"
//     Center(
//       child: Container(
//         margin: EdgeInsets.only(top: 20),
//         child: Text(
//           "Proxima dosis: 12/12/2023 00:54",
//           style: TextStyle(
//             fontSize: 20
//           ),
//         )
//       ),
//     ),
//     // BOTON RENOVAR
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
//             "REGISTRAR DOSIS",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 22
//             ),
//           ),
//           onPressed: (){},
//         ),
//       ),
//     ),
//     // TEXTO "Dosis restantes"
//     Center(
//       child: Container(
//         margin: EdgeInsets.only(top: 20),
//         child: Text(
//           "Dosis restantes: 73",
//           style: TextStyle(
//             fontSize: 20
//           ),
//         )
//       ),
//     ),
//     // TEXTO "Gestionado por"
//     Center(
//       child: Container(
//         margin: EdgeInsets.only(top: 20),
//         child: Text(
//           "Gestionado por: Administrador",
//           style: TextStyle(
//             fontSize: 20
//           ),
//         )
//       ),
//     ),
//     // TEXTO "Normas de consumo"
//     Center(
//       child: Container(
//         margin: EdgeInsets.only(top: 20),
//         child: Text(
//           "Normas de consumo",
          
//           style: TextStyle(
//             fontSize: 20,
//             decoration: TextDecoration.underline
//           ),
//         )
//       ),
//     ),
//     // NORMAS DE CONSUMO
//     Center(
//       child: Container(
//         child: Text(
//           "Algunas normas de consumo de dicho medicamento",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 20
//           ),
//         )
//       ),
//     ),
//     // TEXTO "Caracteristicas generales"
//     Center(
//       child: Container(
//         margin: EdgeInsets.only(top: 20),
//         child: Text(
//           "Caracteristicas generales",
          
//           style: TextStyle(
//             fontSize: 20,
//             decoration: TextDecoration.underline
//           ),
//         )
//       ),
//     ),
//     // CARACTERISTICAS GENERALES
//     Center(
//       child: Container(
//         child: Text(
//           "Algunas caracteristicas generales de dicho medicamento",
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 20
//           ),
//         )
//       ),
//     ),
//   ],
// ),
// // #############  BOTTOMNAVIGATIONBAR  ############
// bottomNavigationBar: BottomNavigationBar(
//   items: const [
//     BottomNavigationBarItem(
//       icon: Icon(Icons.mode_edit),
//       label: "Modificar\nmedicamento"
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.delete_forever),
//       label: "Eliminar\nmedicamento"
//     ),
//   ],
//   onTap: (value){
//     switch (value){
//       case 0:
//         // IR A PANTALLA MAS OPCIONES MEDICAMENTO
//         // CARGANDO LOS DATOS DEL MEDICAMENTO ?????
//         setState(() {});
//       break;
//       case 1:
//         showDialog<String>(
//           context: context,
//           builder: (BuildContext context) => AlertDialog(
//             title: Center(child: const Text('¡ATENCION!')),
//             content: const Text('¿Estas seguro de que deseas eliminar este medicamento?'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () => Navigator.pop(context, 'Cancel'),
//                 child: const Text('CANCELAR'),
//               ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, 'OK'),
//                 child: const Text('CONFIRMAR'),
//               ),
//             ],
//           ),
//         );
//         setState(() {});
//       break;
//     }
//   },
// ),

// PANTALLA ADD MEDICAMENTO, ANTIGUO TEXTFIELD HORA&FECHA
// Container(
//   width: 120,
//   margin: EdgeInsets.only(top: 10),
//   decoration: BoxDecoration(
//     // color: Colors.grey,
//     border: Border.all(),
//     borderRadius: BorderRadius.all(Radius.circular(8)),
//   ),
//   child: TextField(
//     // controller: txt,
//     textAlign: TextAlign.center,
//     decoration: InputDecoration(
//       hintText: "$selectedHourString",
//       border: OutlineInputBorder()
//     ),
//     onTap: (){
//       // IMPEDIMOS QUE ABRA EL TECLADO AL PULSAR EL EDITTEXT
//       FocusScope.of(context).requestFocus(FocusNode());
//       // ABRIMOS EL SELECTOR DE FECHA
//       _selectHour(context);
//     },
//   )
// )

// PANTALLA MEDICAMENTO, LINEA 391
// // TEXTO "INDIQUE LA FECHA DE LA PRIMERA DOSIS"
// Text(
//   "Indique la fecha de la primera dosis",
//   style: TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//   ),
// ),
// // BOTON FECHA
// Container(
//   width: 350,
//   height: 55,
//   decoration: const BoxDecoration(
//     color: Color(0xFF009638),
//     borderRadius: BorderRadius.all(Radius.circular(8))
//   ),
//   child: TextButton(
//     child: const Text(
//       "SELECCIONE LA FECHA",
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 22,
//         fontWeight: FontWeight.bold
//       ),
//     ),
//     onPressed: ()async{
      
//     },
//   ),
// ),
// // ESPACIO
// SizedBox(
//   height: 20,
// ),
// // TEXTO "INDIQUE LA HORA DE LA PRIMERA DOSIS"
// Text(
//   "Indique la hora de la primera dosis",
//   style: TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//   ),
// ),
// // BOTON HORA
// Container(
//   width: 350,
//   height: 55,
//   decoration: const BoxDecoration(
//     color: Color(0xFF009638),
//     borderRadius: BorderRadius.all(Radius.circular(8))
//   ),
//   child: TextButton(
//     child: const Text(
//       "SELECCIONE LA HORA",
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 22,
//         fontWeight: FontWeight.bold
//       ),
//     ),
//     onPressed: ()async{
      
//     },
//   ),
// ),
// // ESPACIO
// SizedBox(
//   height: 50,
// ),
// // BOTON HORA
// Container(
//   width: 350,
//   height: 55,
//   decoration: const BoxDecoration(
//     color: Color(0xFF009638),
//     borderRadius: BorderRadius.all(Radius.circular(8))
//   ),
//   child: TextButton(
//     child: const Text(
//       "SELECCIONE LA HORA",
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 22,
//         fontWeight: FontWeight.bold
//       ),
//     ),
//     onPressed: ()async{
      
//     },
//   ),
// ),

// POST MEDICAMENTO
// String stringFecha = "${fechahoraproximadosis.year}${fechahoraproximadosis.month}${fechahoraproximadosis.day}${fechahoraproximadosis.hour}${fechahoraproximadosis.minute}00";