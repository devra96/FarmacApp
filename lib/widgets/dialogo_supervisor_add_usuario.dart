// import 'package:farmacapp/modelos/usuario.dart';
// import 'package:farmacapp/widgets/dialogo.dart';
// import 'package:farmacapp/widgets/dialogo_supervisor_confirmar_usuario.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../provider/modo_trabajo.dart';

// class DialogoSupervisorAddUsuario extends StatelessWidget {
//   // const DialogoSupervisorAddUsuario({super.key});

//   String correo = "", password = "";

//   @override
//   Widget build(BuildContext context) {

//     final modoTrabajo = Provider.of<ModoTrabajo>(context);

//     return AlertDialog(
//       title: Text('Añadir usuario'),
//       content: Container(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('Ingrese el correo y la contraseña de la persona que quiere supervisar.'),
//             SizedBox(
//               height: 10
//             ),
//             Center(
//               child: SizedBox(
//                 width: 350,
//                 child: TextField(
//                   decoration: InputDecoration(
//                     fillColor: Colors.red,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)
//                     ),
//                     labelText: "Correo"
//                   ),
//                   onChanged: (value) => correo = value,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10
//             ),
//             Center(
//               child: SizedBox(
//                 width: 350,
//                 child: TextField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     fillColor: Colors.red,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)
//                     ),
//                     labelText: "Contraseña"
//                   ),
//                   onChanged: (value) => password = value,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           child: Text('Cancelar'),
//           onPressed: (){
//             // modoEdicion.confirmacion = false;
//             Navigator.of(context).pop();
//           },
//         ),
//         TextButton(
//           child: Text('Aceptar'),
//           onPressed: () async{
//             // SI EL USUARIO NO HA INTRODUCIDO AMBOS CAMPOS
//             if(correo == "" || password == ""){
//               showDialog<void>(
//                 context: context,
//                 builder: (BuildContext context) => Dialogo(texto: 'Por favor, rellene todos los campos.')
//               );
//             }
//             else{
//               // MODO REMOTO
//               if(modoTrabajo.modoLocal){
//                 Usuario u = new Usuario();
//                 // SI EL USUARIO Y/O CONTRASEÑA SON INCORRECTOS
//                 if(await u.checkUsuario(correo, password) == "no"){
//                   showDialog<void>(
//                     context: context,
//                     builder: (BuildContext context) => Dialogo(texto: 'Usuario y/o contraseña incorrect@(s).')
//                   );
//                 }
//                 // INICIO DE SESION CORRECTO
//                 else{
//                   u = await u.getUsuario(correo, password);

//                   if(u.id_supervisor == 0){
//                     // CERRAMOS ESTE DIALOGO
//                     Navigator.pop(context);

//                     // MOSTRAR DIALOGO RECOGIENDO ID, NOMBRE Y CORREO DEL USUARIO A SUPERVISAR
//                     showDialog<void>(
//                       context: context,
//                       builder: (BuildContext context) => DialogoSupervisorConfirmarUsuario(id: u.id, nombre: u.nombre)
//                     );
//                   }
//                   // SI EL USUARIO ESTA SIENDO SUPERVISADO POR OTRO SUPERVISOR
//                   else{
//                     showDialog<void>(
//                       context: context,
//                       builder: (BuildContext context) => Dialogo(texto: 'Ese usuario ya esta siendo supervisado por otra persona.')
//                     );
//                   }
//                 }
//               }
//               // MODO LOCAL
//               else{

//               }
//             }
//           },
//         ),
//       ],
//     );
//   }
// }