import 'package:farmacapp/modelos/medicamento.dart';
import 'package:farmacapp/paginas/pantalla_add_medicamento.dart';
import 'package:farmacapp/paginas/pantalla_detalle_medicamento.dart';
import 'package:farmacapp/paginas/pantalla_farmacias_cercanas.dart';
import 'package:farmacapp/paginas/pantalla_inicio_sesion.dart';
import 'package:farmacapp/paginas/pantalla_reponer_medicamento.dart';
import 'package:farmacapp/paginas/pantalla_visitas_medicas.dart';
import 'package:farmacapp/widgets/boton_medicamento.dart';
import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;

class PantallaAgenda extends StatefulWidget {
  const PantallaAgenda({super.key});

  @override
  State<PantallaAgenda> createState() => _PantallaAgendaState();
}

class _PantallaAgendaState extends State<PantallaAgenda> {
  final Medicamento m = new Medicamento();

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
      body: Container(
        child: FutureBuilder(
          future: m.getMedicamentosUsuario(1),
          builder: (context, AsyncSnapshot<List<Medicamento>> snapshot){
            // print("SNAPSHOT DATA: ${snapshot.data}");
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  
                  // PRUEBA PARA SUMAR HORAS A UNA FECHA
                  DateTime prueba = snapshot.data![index].fechahoraultimadosis.add(Duration(hours: 1));

                  return Container(
                    height: 80,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.white
                    ),
                    child: InkWell(
                      onTap: () {
                        _loadPantallaDetalleMedicamento();
                      },
                      child: BotonMedicamento(
                        nombre: snapshot.data![index].nombre,
                        ultimaDosis: "${snapshot.data![index].fechahoraultimadosis.day}/${snapshot.data![index].fechahoraultimadosis.month}/${snapshot.data![index].fechahoraultimadosis.year} - ${snapshot.data![index].fechahoraultimadosis.hour}:${snapshot.data![index].fechahoraultimadosis.minute}",
                        // ultimaDosis: "${prueba.day}/${prueba.month}/${prueba.year} - ${prueba.hour}:${prueba.minute}",
                        proximaDosis: "${snapshot.data![index].fechahoraproximadosis.day}/${snapshot.data![index].fechahoraproximadosis.month}/${snapshot.data![index].fechahoraproximadosis.year} - ${snapshot.data![index].fechahoraproximadosis.hour}:${snapshot.data![index].fechahoraproximadosis.minute}"
                      ),
                    ),
                  );
                }
              );
            }
            else{
              // TEXTO NO HAY MEDICAMENTOS Y AÑADIR UNO
              return Text("a");
            }
          },
        ),
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