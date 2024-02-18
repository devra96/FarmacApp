import 'package:farmacapp/paginas/pantalla_inicio_sesion.dart';
import 'package:farmacapp/paginas/pantalla_add_usuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Primera pantalla que se muestra en la aplicacion, donde
/// podremos iniciar sesion o crear una cuenta.
/// 
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
    // CUANDO PULSEMOS EL BOTON DE ATRAS DEL DISPOSITIVO, SE NOS MOSTRARA
    // UN DIALOGO PIDIENDO CONFIRMACION PARA SALIR O NO DE LA APLICACION.
    return WillPopScope(
      onWillPop: () async{
        return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('¿Quieres salir de la aplicación?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Salir'),
              ),
            ],
          ),
        ) ?? false;
      },
      child: Scaffold(
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
                  // IMAGEN DEL CENTRO (LOGO FARMACAPP)
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
                      _loadPantallaInicioSesion();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF009638),
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
      ),
    );
  }
}