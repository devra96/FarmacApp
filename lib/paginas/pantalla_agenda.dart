import 'package:farmacapp/paginas/pantalla_add_medicamento.dart';
import 'package:flutter/material.dart';

class PantallaAgenda extends StatefulWidget {
  const PantallaAgenda({super.key});

  @override
  State<PantallaAgenda> createState() => _PantallaAgendaState();
}

class _PantallaAgendaState extends State<PantallaAgenda> {
  
  _loadPantallaAddMedicamento () async{
    final destino = MaterialPageRoute(builder:(_)=>PantallaAddMedicamento());
    final datoDevuelto = await Navigator.push(context, destino);
    
    setState((){
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #################### APPBAR ####################
      appBar: AppBar(
        // DEJAR ESTE BOTON O EL DRAWER??
        // leading: Builder(
        //   builder: (BuildContext context){
        //     return IconButton(
        //       icon: const Icon(Icons.supervised_user_circle),
        //       onPressed: (){
        //         // DRAWER
        //       },
        //       // tooltip: AL MANTENER PULSADO EL BOTON, HACE ALGO
        //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        //     );
        //   },
        // ),
        title: Center(
          child: Text("Agenda de Pepe")
        ),
        // automaticallyImplyLeading: false, // HACE QUE NO SALGA EL BOTON DE VOLVER
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.logout))
        ],
      ),
      // #################### DRAWER ####################
      drawer: Container(
        width: 200,
        child: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
                child: Icon(Icons.photo_camera, color: Colors.white,),
              ),
              const Text(
                "Nombre Apellido1 Apellido2",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              ListTile(
                title: Row(children: [Icon(Icons.supervised_user_circle), Container(margin: EdgeInsets.only(left: 10), child: Text('Mi perfil'))],),
                onTap: () {},
              ),
              ListTile(
                title: Row(children: [Icon(Icons.add_box), Container(margin: EdgeInsets.only(left: 10), child: Text('Farmacias cercanas'))],),
                onTap: () {},
              ),
              ListTile(
                title: Row(children: [Icon(Icons.logout), Container(margin: EdgeInsets.only(left: 10), child: Text('Cerrar sesion'))],),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      // ####################  BODY  ####################
      body: ListView.builder(
        itemBuilder: (context, index){
          return Container(
            height: 80,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.white
            ),
            child: InkWell(
              onTap: (){print("MEDICAMENTO PULSADO");},
              child: ListView(
                padding: EdgeInsets.all(2),
                children: [
                  Text("DIAZEPAM",style: TextStyle(fontSize: 25),),
                  Text("Ultima dosis: 17/08/2023 - 09:00",style: TextStyle(fontSize: 16),),
                  Text("Proxima dosis: 18/08/2023 - 09:00",style: TextStyle(fontSize: 16),),
                ],
              ),
            )
          );
        },
        itemCount: 3,
      ),
      // #############  BOTTOMNAVIGATIONBAR  ############
      bottomNavigationBar: Container(
          height: 80,
          color: const Color.fromARGB(255, 5, 133, 9),
          child: InkWell(
            onTap: (){
              _loadPantallaAddMedicamento();
            },
            child: Container(
              padding: EdgeInsets.only(top: 8.0),
              child: const Column(
                children: [
                  Icon(
                    Icons.add,
                    size: 35,
                    color: Colors.white
                  ),
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

/**
Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.red,
            child: const Row(
              children: [
                Text(
                  "Dia:",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                Text(
                  "Mes:",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                Text(
                  "Año:",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
*/