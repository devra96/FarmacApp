// import 'package:farmacapp/database/db.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class PantallaAddVisitaMedica extends StatefulWidget {
//   const PantallaAddVisitaMedica({super.key});

//   @override
//   State<PantallaAddVisitaMedica> createState() => _PantallaAddVisitaMedicaState();
// }

// class _PantallaAddVisitaMedicaState extends State<PantallaAddVisitaMedica> {
  
//   final _formKey = GlobalKey<FormState>();
//   BDHelper bdHelper = BDHelper();
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // #################### APPBAR ####################
//       appBar: AppBar(
//         // automaticallyImplyLeading: false, // HACE QUE NO SALGA EL BOTON DE VOLVER
//         title: Text("AÑADIR UNA VISITA"),
//       ),
//       // ####################  BODY  ####################
//       body: SafeArea(
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             padding: EdgeInsets.all(15),
//             physics: BouncingScrollPhysics(),
//             children: [
//               // CAMPO ESPECIALIDAD
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                   label: Text('Especialidad'),
//                 ),
//                 validator: (valor){
//                   if(valor == null || valor.isEmpty){
//                     return "El campo no puede estar vacio.";
//                   }
//                   else{
//                     return null;
//                   }
//                 },
//                 onSaved: (valor){
//                   if(valor != null){
//                     // GUARDAR VALOR ESPECIALIDAD
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               // CAMPO NOMBRE DEL DOCTOR
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                   label: Text('Nombre del doctor'),
//                 ),
//                 validator: (valor){
//                   if(valor == null || valor.isEmpty){
//                     return "El campo no puede estar vacio.";
//                   }
//                   else{
//                     return null;
//                   }
//                 },
//                 onSaved: (valor){
//                   if(valor != null){
//                     // GUARDAR VALOR NOMBRE DEL DOCTOR
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               // CAMPO LUGAR DE LA VISITA
//               TextFormField(
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                   label: Text('Lugar de la visita'),
//                 ),
//                 validator: (valor){
//                   if(valor == null || valor.isEmpty){
//                     return "El campo no puede estar vacio.";
//                   }
//                   else{
//                     return null;
//                   }
//                 },
//                 onSaved: (valor){
//                   if(valor != null){
//                     // GUARDAR VALOR LUGAR DE LA VISITA
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               // CAMPO FECHA DE LA VISITA
//               TextFormField(
//                 keyboardType: TextInputType.datetime,
//                 decoration: const InputDecoration(
//                   label: Text("Fecha de la visita (formato 'DD/MM/YYYY')"),
//                 ),
//                 validator: (valor){
//                   if(valor == null || valor.isEmpty){
//                     return 'El campo no puede estar vacio';
//                   }

//                   if(RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').hasMatch(valor) == false){
//                     return 'El formato de la fecha no es correcto';
//                   }

//                   List<String> partes = valor.split("/");
//                   int dia = int.tryParse(partes[0])!;
//                   int mes = int.tryParse(partes[1])!;
//                   int anio = int.tryParse(partes[2])!;

//                   try{
//                     DateTime fecha = new DateTime(anio, mes, dia);
//                   }
//                   catch(e){
//                     return 'La fecha no es correcta';
//                   };
                  
//                   return null;
//                 },
//                 onSaved: (valor){
//                   if(valor!=null){
//                     // GUARDAR CAMPO FECHA VISITA
//                   }
//                 },
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               // CAMPO HORA DE LA VISITA
//               TextFormField(
//                 keyboardType: TextInputType.datetime,
//                 decoration: const InputDecoration(
//                   label: Text('Hora de la visita (formato HH:MM)'),
//                 ),
//                 validator: (valor){
//                   if(valor==null || valor.isEmpty){
//                     return 'El campo no puede estar vacio';
//                   }

//                   if(RegExp(r'^[0-2][0-9]:[0-5][0-9]$').hasMatch(valor)==false){
//                     return 'El formato de la fecha no es correcto';
//                   }
//                   else{
//                     return null;
//                   }
//                 },
//                 onSaved: (valor) {
//                   if(valor!=null){
//                     // GUARDAR CAMPO HORA DE LA VISITA
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               // BOTON GUARDAR
//               ElevatedButton(
//                 child: Text('Guardar'),
//                 onPressed: (){
//                   if(_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();

//                     // bdHelper.insertarBD('VisitaMedica', visitaMedica.toMap());
                    
//                     Navigator.pop(context);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }