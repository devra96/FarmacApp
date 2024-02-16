import 'package:farmacapp/modelos/medicamento.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/modelos/visitamedica.dart';
import 'package:farmacapp/paginas/pantalla_inicio.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/provider/modo_trabajo.dart';
import 'package:farmacapp/provider/usuario_supervisor.dart';
import 'package:farmacapp/tema/tema.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModoTrabajo()
        ),
        ChangeNotifierProvider(
          create: (_) => Usuario()
        ),
        ChangeNotifierProvider(
          create: (_) => Medicamento()
        ),
        ChangeNotifierProvider(
          create: (_) => VisitaMedica()
        ),
        ChangeNotifierProvider(
          create: (_) => ModoEdicion()
        ),
        ChangeNotifierProvider(
          create: (_) => UsuarioSupervisor()
        ),
        ChangeNotifierProvider(
          create: (_) => Tema()..loadTheme(prefs)
        ),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // ELIMINAR LABEL "DEBUG" DE ARRIBA A LA DERECHA
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      //   useMaterial3: true,
      // ),
      theme: Provider.of<Tema>(context).getTheme(),
      // ARRANCAMOS LA PANTALLA DE INICIO DE SESION, PERO EN UN FUTURO HABRIA QUE CONTROLAR
      // QUE NOS ARRANQUE ESTA O LA PANTALLA DE LA AGENDA, EN BASE A SI SE HA INICIADO O NO
      // UNA SESION ANTERIORMENTE
      home: const PantallaInicio(),
    );
  }
}