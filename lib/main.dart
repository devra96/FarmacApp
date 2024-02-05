import 'package:farmacapp/paginas/pantalla_inicio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ELIMINAR LABEL "DEBUG" DE ARRIBA A LA DERECHA
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        // useMaterial3: true,
      ),
      // ARRANCAMOS LA PANTALLA DE INICIO DE SESION, PERO EN UN FUTURO HABRIA QUE CONTROLAR
      // QUE NOS ARRANQUE ESTA O LA PANTALLA DE LA AGENDA, EN BASE A SI SE HA INICIADO O NO
      // UNA SESION ANTERIORMENTE
      home: const PantallaInicio(),
    );
  }
}