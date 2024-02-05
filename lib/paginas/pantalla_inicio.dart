import 'package:farmacapp/paginas/pantalla_inicio_sesion.dart';
import 'package:farmacapp/paginas/pantalla_nuevo_usuario.dart';
import 'package:flutter/material.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {

  _loadPantallaInicioSesion() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaInicioSesion());
    final datoDevuelto = await Navigator.push(context, destino);
  }

  _loadPantallaNuevoUsuario () async{
    final destino = MaterialPageRoute(builder:(_)=>PantallaNuevoUsuario());
    final datoDevuelto = await Navigator.push(context, destino);
    
    setState((){

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // FONDO DE LA PANTALLA
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/images/fondo_pantalla_inicio.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // IMAGEN DEL CENTRO
                Container(
                  padding: EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/logo_farmacapp_sinfondo.png',
                    height: 400,
                    width: 400,
                  ),
                ),
                // ESPACIO
                SizedBox(height: 20),
                // BOTON "INICIAR SESION"
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el botón "Iniciar sesión"
                    _loadPantallaInicioSesion();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF009638), // Letra de color blanco
                  ),
                  child: Text(
                    'INICIAR SESIÓN',
                    style: TextStyle(
                      fontSize: 30, // Tamaño de texto 30
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                // ESPACIO
                SizedBox(
                  height: 20,
                ),
                // BOTON "CREAR CUENTA"
                ElevatedButton(
                  onPressed: () {
                    // Acción al presionar el botón "Crear cuenta"
                    _loadPantallaNuevoUsuario();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF009638),
                  ),
                  child: Text(
                    'CREAR CUENTA',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
