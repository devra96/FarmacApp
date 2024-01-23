import 'package:farmacapp/paginas/pantalla_add_medicamento.dart';
import 'package:farmacapp/paginas/pantalla_detalle_medicamento.dart';
import 'package:farmacapp/paginas/pantalla_farmacias_cercanas.dart';
import 'package:farmacapp/paginas/pantalla_inicio_sesion.dart';
import 'package:farmacapp/paginas/pantalla_reponer_medicamento.dart';
import 'package:farmacapp/paginas/pantalla_visitas_medicas.dart';
import 'package:farmacapp/widgets/boton_medicamento.dart';
import 'package:flutter/material.dart';

class PantallaAgenda extends StatefulWidget {
  const PantallaAgenda({super.key});

  @override
  State<PantallaAgenda> createState() => _PantallaAgendaState();
}

class _PantallaAgendaState extends State<PantallaAgenda> {
  _loadPantallaAddMedicamento() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaAddMedicamento());
    final datoDevuelto = await Navigator.push(context, destino);

    setState(() {});
  }

  _loadPantallaDetalleMedicamento() async {
    final destino =
        MaterialPageRoute(builder: (_) => PantallaDetalleMedicamento());
    final datoDevuelto = await Navigator.push(context, destino);

    setState(() {});
  }

  _loadPantallaFarmaciasCercanas() async {
    final destino =
        MaterialPageRoute(builder: (_) => PantallaFarmaciasCercanas());
    final datoDevuelto = await Navigator.push(context, destino);

    setState(() {});
  }

  _loadPantallaReponerMedicamento() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaReponerMedicamento());
    final datoDevuelto = await Navigator.push(context, destino);

    setState(() {});
  }

  _loadPantallaInicioSesion() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaInicioSesion());
    final datoDevuelto = await Navigator.push(context, destino);

    setState(() {});
  }

  _loadPantallaVisitasMedicas() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaVisitasMedicas());
    final datoDevuelto = await Navigator.push(context, destino);

    setState(() {});
  }

  // HABRIA QUE PROGRAMAR QUE LA FUNCION DEVUELVA UN VALOR U OTRO
  // EN BASE AL BOTON QUE SE HAYA PULSADO
  _cerrarSesion() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Center(child: const Text('CERRAR SESION')),
        content: const Text(
          '¿Estas seguro de que deseas cerrar sesion?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('CANCELAR'),
          ),
          TextButton(
            onPressed: (){
              Navigator.pop(context, 'OK');
              _loadPantallaInicioSesion();
            },
            child: const Text('CONFIRMAR'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #################### APPBAR ####################
      appBar: AppBar(
        title: Center(
          child: Text("Agenda de Pepe")
        ),
        actions: [
          IconButton(
            onPressed: (){
              _cerrarSesion();
              // HABRIA QUE CONTROLAR QUE EN BASE AL VALOR DEVUELTO
              // POR LA FUNCION, VUELVA O NO A LA PANTALLA DE LOGIN
            },
            icon: Icon(Icons.logout)
          )
        ],
      ),
      // #################### DRAWER ####################
      drawer: Container(
        width: 260,
        child: Drawer(
          child: ListView(
            // IMPORTANTE ELIMINAR CUALQUIER PADDING DE LA LISTVIEW
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12),
                child: const Text(
                  "Nombre Apellido1 Apellido2", // AQUI IRIAN EL NOMBRE Y APELLIDOS SACADOS DEL USUARIO
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.supervised_user_circle),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text('Mi perfil'))
                  ],
                ),
                onTap: (){
                  // IR A PANTALLA DE DATOS DEL USUARIO (AUN POR CREAR)
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.add_box),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('Farmacias cercanas')
                    ),
                  ],
                ),
                onTap: () {
                  // NOS LLEVA A LA PANTALLA DE FARMACIAS CERCANAS
                  _loadPantallaFarmaciasCercanas();
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.list),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('Reponer medicamentos')
                    )
                  ],
                ),
                onTap: () {
                  _loadPantallaReponerMedicamento();
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.list),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('Visitas medicas'))
                  ],
                ),
                onTap: () {
                  // IR A PANTALLA VISITAS MEDICAS
                  _loadPantallaVisitasMedicas();
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.settings),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('Configuracion'))
                  ],
                ),
                onTap: () {
                  // IR A CONFIGURACION
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.logout),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('Cerrar sesion'))
                  ],
                ),
                onTap: (){
                  _cerrarSesion();
                  // HABRIA QUE CONTROLAR QUE EN BASE AL VALOR DEVUELTO
                  // POR LA FUNCION, VUELVA O NO A LA PANTALLA DE LOGIN
                },
              ),
            ],
          ),
        ),
      ),
      // ####################  BODY  ####################
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
              height: 80,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white),
              child: InkWell(
                onTap: () {
                  // AQUI SE EXPORTARIAN LAS PROPIEDADES DEL MEDICAMENTO
                  // SELECCIONADO A LA PANTALLA QUE LLAMAMOS EN EL METODO
                  _loadPantallaDetalleMedicamento();
                },
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
                child: BotonMedicamento(nombre: "NOMBRE MEDICAMENTO", ultimaDosis: "23/01/2024 - 12:13", proximaDosis: "24/01/2024 - 12:13"),
              ));
        },
        itemCount: 10,
      ),
      // #############  BOTTOMNAVIGATIONBAR  ############
      bottomNavigationBar: Container(
        height: 80,
        color: const Color.fromARGB(255, 5, 133, 9),
        child: InkWell(
          onTap: () {
            _loadPantallaAddMedicamento();
          },
          child: Container(
            padding: EdgeInsets.only(top: 8.0),
            child: const Column(
              children: [
                Icon(Icons.add, size: 35, color: Colors.white),
                Text(
                  "AÑADIR MEDICAMENTO",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}