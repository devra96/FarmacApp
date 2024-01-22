import 'package:farmacapp/paginas/pantalla_add_visita_medica.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PantallaVisitasMedicas extends StatefulWidget {
  const PantallaVisitasMedicas({super.key});

  @override
  State<PantallaVisitasMedicas> createState() => _PantallaVisitasMedicasState();
}

class _PantallaVisitasMedicasState extends State<PantallaVisitasMedicas> {
  
  _loadPantallaAddVisitaMedica() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaAddVisitaMedica());
    final datoDevuelto = await Navigator.push(context, destino);

    setState((){});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #################### APPBAR ####################
      appBar: AppBar(
        title: Text("VISITAS MEDICAS"),
      ),
      // ####################  BODY  ####################
      body: Container(
        child: FloatingActionButton(
          onPressed: (){
            _loadPantallaAddVisitaMedica();
          }
        )
      ),
    );
  }
}