import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/paginas/pantalla_mod_usuario.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/provider/usuario_supervisor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PantallaPerfil extends StatefulWidget {
  const PantallaPerfil({super.key});

  @override
  State<PantallaPerfil> createState() => _PantallaPerfilState();
}

class _PantallaPerfilState extends State<PantallaPerfil> {



  _loadPantallaModUsuario() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaModUsuario());
    final datoDevuelto = await Navigator.push(context, destino);
  }

  @override
  Widget build(BuildContext context) {

    var usuarioIniciado = Provider.of<Usuario>(context);
    var usuarioSupervisor = Provider.of<UsuarioSupervisor>(context);
    var modoEdicion = Provider.of<ModoEdicion>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("PERFIL"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CUADRO FOTO
          Center(
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: Image.asset('assets/images/abuelo.jpg', fit: BoxFit.fill),
            ),
          ),
          // ESPACIO
          SizedBox(
            height: 40,
          ),
          // TEXTO "NOMBRE COMPLETO"
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              "Nombre completo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline
              ),
            ),
          ),
          // NOMBRE COMPLETO
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              (!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)) ? usuarioIniciado.nombre : usuarioSupervisor.nombre,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // ESPACIO
          SizedBox(
            height: 20,
          ),
          // TEXTO "CORREO ELECTRONICO"
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              "Correo electronico",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline
              ),
            ),
          ),
          // CORREO ELECTRONICO
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Text(
              (!usuarioSupervisor.supervisoriniciado || (usuarioSupervisor.supervisoriniciado && usuarioSupervisor.modosupervisor)) ? usuarioIniciado.correo : usuarioSupervisor.correo,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // BOTON MODIFICAR PERFIL
          Center(
            child: Container(
              width: 300,
              height: 55,
              decoration: const BoxDecoration(
                color: Color(0xFF009638),
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: TextButton(
                child: Text(
                  "MODIFICAR PERFIL",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: () async{
                  modoEdicion.cambiarpass = false;
                  _loadPantallaModUsuario();
                },
              ),
            ),
          ),
          // ESPACIO
          SizedBox(
            height: 20,
          ),
          // BOTON CAMBIAR CONTRASEÑA
          Center(
            child: Container(
              width: 300,
              height: 55,
              decoration: const BoxDecoration(
                color: Color(0xFF009638),
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: TextButton(
                child: Text(
                  "CAMBIAR CONTRASEÑA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
                onPressed: () async{
                  modoEdicion.cambiarpass = true;
                  _loadPantallaModUsuario();
                },
              ),
            ),
          ),
          // ESPACIO
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}