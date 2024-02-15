import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/modelos/medicamento.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/modelos/visitamedica.dart';
// import 'package:farmacapp/paginas/pantalla_add_medicamento.dart';
// import 'package:farmacapp/paginas/pantalla_add_visita_medica.dart';
import 'package:farmacapp/paginas/pantalla_detalle_medicamento.dart';
import 'package:farmacapp/paginas/pantalla_farmacias_cercanas.dart';
import 'package:farmacapp/paginas/pantalla_inicio.dart';
import 'package:farmacapp/paginas/pantalla_inicio_sesion.dart';
import 'package:farmacapp/paginas/pantalla_addmod_visita_medica.dart';
import 'package:farmacapp/paginas/pantalla_addmod_medicamento.dart';
import 'package:farmacapp/paginas/pantalla_perfil.dart';
import 'package:farmacapp/paginas/pantalla_reponer_medicamento.dart';
import 'package:farmacapp/paginas/pantalla_usuarios.dart';
// import 'package:farmacapp/paginas/pantalla_visitas_medicas.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/provider/modo_trabajo.dart';
import 'package:farmacapp/provider/usuario_supervisor.dart';
import 'package:farmacapp/widgets/boton_click_visita_medica.dart';
import 'package:farmacapp/widgets/boton_medicamento.dart';
import 'package:farmacapp/widgets/boton_visitamedica.dart';
import 'package:farmacapp/widgets/dialogo.dart';
import 'package:farmacapp/widgets/dialogo_confirmacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:http/http.dart' as http;

class PantallaAgenda extends StatefulWidget {
  const PantallaAgenda({super.key});

  @override
  State<PantallaAgenda> createState() => _PantallaAgendaState();
}

class _PantallaAgendaState extends State<PantallaAgenda> {
  
  // INSTANCIA BASE DE DATOS LOCAL
  BDHelper bdHelper = BDHelper();
  
  final Medicamento m = new Medicamento();
  final VisitaMedica v = new VisitaMedica();

  // NAVIGATION BAR
  int currentPageIndex = 0;

  // HORA ACTUAL
  final DateTime horaActual = DateTime.now();

  // COLOR FONDO BOTON MEDICAMENTO (PARA INDICAR SI HAY QUE TOMARLO O NO)
  MaterialColor colorFondo = Colors.red;

  // VARIABLE DONDE GUARDAREMOS LA FECHA DE LA PROXIMA DOSIS A CONSUMIR
  // O UN "-" SI YA NO QUEDAN DOSIS
  late String pd;

  // METODOS
  _loadPantallaMedicamento() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaMedicamento());
    final datoDevuelto = await Navigator.push(context, destino);

    setState(() {});
  }

  _loadPantallaPerfil() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaPerfil());
    final datoDevuelto = await Navigator.push(context, destino);

    setState(() {});
  }

  // BORRAR
  // _loadPantallaAddMedicamento2() async {
  //   final destino = MaterialPageRoute(builder: (_) => PantallaAddMedicamento());
  //   final datoDevuelto = await Navigator.push(context, destino);

  //   setState(() {});
  // }

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

  _loadPantallaInicio() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaInicio());
    final datoDevuelto = await Navigator.push(context, destino);

    setState(() {});
  }

  // _loadPantallaVisitasMedicas() async {
  //   final destino = MaterialPageRoute(builder: (_) => PantallaVisitasMedicas());
  //   final datoDevuelto = await Navigator.push(context, destino);

  //   setState(() {});
  // }

  _loadPantallaVisitaMedica() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaVisitaMedica());
    final datoDevuelto = await Navigator.push(context, destino);

    setState(() {});
  }

  _loadPantallaUsuarios() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaUsuarios());
    final datoDevuelto = await Navigator.push(context, destino);

    setState(() {});
  }

  // HABRIA QUE PROGRAMAR QUE LA FUNCION DEVUELVA UN VALOR U OTRO
  // EN BASE AL BOTON QUE SE HAYA PULSADO

  // SUSTITUIR POR BOTON CONFIRMACION??
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
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool("sesionIniciada", false);
              
              Navigator.pop(context, 'OK');
              _loadPantallaInicio();
            },
            child: const Text('CONFIRMAR'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // PROVIDERS    
    var modoTrabajo = Provider.of<ModoTrabajo>(context);
    var usuarioIniciado = Provider.of<Usuario>(context);
    var medicamentoSeleccionado = Provider.of<Medicamento>(context);
    var visitaMedicaSeleccionada = Provider.of<VisitaMedica>(context);
    var modoEdicion = Provider.of<ModoEdicion>(context);
    var usuarioSupervisor = Provider.of<UsuarioSupervisor>(context);

    // _cargarSharedPreferences() async{
    //   final SharedPreferences prefs = await SharedPreferences.getInstance();
    //   if(prefs.getBool("recuperacionUsuario")!){
    //     modoTrabajo.modoLocal = prefs.getBool("modoTrabajo")!;

    //     // SI INICIAMOS SESION DE SUPERVISOR
    //     if(prefs.getBool("supervisorIniciado")!){
    //       usuarioSupervisor.supervisoriniciado = true;
    //       usuarioSupervisor.modosupervisor = false;
    //       usuarioSupervisor.id = prefs.getInt("id")!;
    //       usuarioSupervisor.id_supervisor = prefs.getInt("id_supervisor")!;
    //       usuarioSupervisor.nombre = prefs.getString("nombre")!;
    //       usuarioSupervisor.correo = prefs.getString("correo")!;
    //       usuarioSupervisor.password = prefs.getString("password")!;
    //     }
    //     // SI INICIAMOS SESION ESTANDAR
    //     else{
    //       usuarioSupervisor.supervisoriniciado = false;
    //       usuarioSupervisor.modosupervisor = false;
    //       usuarioIniciado.id = prefs.getInt("id")!;
    //       usuarioIniciado.id_supervisor = prefs.getInt("id_supervisor")!;
    //       usuarioIniciado.nombre = prefs.getString("nombre")!;
    //       usuarioIniciado.correo = prefs.getString("correo")!;
    //       usuarioIniciado.password = prefs.getString("password")!;
    //     }
    //   }
    //   else{
    //     prefs.setBool("recuperacionUsuario", true);
    //   }
    // }

    // _cargarSharedPreferences();

    // METODO PARA LLAMAR AL METODO OPORTUNO PARA RECUPERAR LOS MEDICAMENTOS
    // SEGUN SI ESTAMOS EN "MODO REMOTO" O "MODO LOCAL"
    Future<List<Medicamento>> recuperarMedicamentos() async{
      // MODO REMOTO
      if(modoTrabajo.modoLocal){
        return m.getMedicamentosUsuario(
          usuarioSupervisor.supervisoriniciado
          ? usuarioSupervisor.id
          : usuarioIniciado.id
        );
      }
      // MODO LOCAL
      else{
        return await bdHelper.getMedicamentosUsuario(
          usuarioSupervisor.supervisoriniciado
          ? usuarioSupervisor.id
          : usuarioIniciado.id
        );
      }
    }

    // METODO PARA LLAMAR AL METODO OPORTUNO PARA RECUPERAR LOS MEDICAMENTOS
    // SEGUN SI ESTAMOS EN "MODO REMOTO" O "MODO LOCAL"
    Future<List<VisitaMedica>> recuperarVisitasMedicas() async{
      // MODO REMOTO
      if(modoTrabajo.modoLocal){
        return v.getVisitasMedicasUsuario(
          usuarioSupervisor.supervisoriniciado
          ? usuarioSupervisor.id
          : usuarioIniciado.id
        );
      }
      // MODO LOCAL
      else{
        return await bdHelper.getVisitasMedicasUsuario(
          usuarioSupervisor.supervisoriniciado
          ? usuarioSupervisor.id
          : usuarioIniciado.id
        );
      }
    }

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(); // Cerrar la aplicación directamente
        return true;

        // Invocar la plataforma Android para ir a la pantalla de inicio del dispositivo
        // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        // return false; // Evitar que la aplicación se cierre
      },
      child: Scaffold(
        // #################### APPBAR ####################
        appBar: AppBar(
          title: Center(
            child: Text("Agenda de ${
              usuarioSupervisor.supervisoriniciado
              ? usuarioSupervisor.nombre.indexOf(" ") == -1
                ? usuarioSupervisor.nombre
                : usuarioSupervisor.nombre.substring(0, usuarioSupervisor.nombre.indexOf(" "))
              : usuarioIniciado.nombre.indexOf(" ") == -1
                ? usuarioIniciado.nombre
                : usuarioIniciado.nombre.substring(0, usuarioIniciado.nombre.indexOf(" "))
            }")
          ),
          actions: [
            // IconButton(
            //   onPressed: (){
            //     _cerrarSesion();
            //     // HABRIA QUE CONTROLAR QUE EN BASE AL VALOR DEVUELTO
            //     // POR LA FUNCION, VUELVA O NO A LA PANTALLA DE LOGIN
            //   },
            //   icon: Icon(Icons.logout)
            // )
            PopupMenuButton(
              icon: Icon(Icons.add),
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text('Nuevo medicamento'),
                    value: 'nuevomedicamento',
                  ),
                  PopupMenuItem(
                    child: Text('Nueva visita medica'),
                    value: 'nuevavisita',
                  ),
                ];
              },
              onSelected: (value) async{
                // DESACTIVAMOS EL MODO DE EDICION
                modoEdicion.modoedicion = false;
      
                // MODO SUPERVISOR DESACTIVADO
                usuarioSupervisor.modosupervisor = false;
      
                if(value == 'nuevomedicamento'){
                  _loadPantallaMedicamento();
                }
                else{
                  _loadPantallaVisitaMedica();
                }
              },
            ),
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
                // SUSTITUIR ESTO POR LA IMAGEN DEL ABUELO
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("assets/images/abuelo.jpg")
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(bottom: 12),
                //   child: const Text(
                //     "Nombre Apellido1 Apellido2", // AQUI IRIAN EL NOMBRE Y APELLIDOS SACADOS DEL USUARIO
                //     textAlign: TextAlign.center,
                //     style: TextStyle(fontSize: 20),
                //   ),
                // ),
                // BOTON PERFIL
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.person),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text('Perfil')
                      )
                    ],
                  ),
                  onTap: (){
                    // modoEdicion.modoedicion = true;
                    usuarioSupervisor.modosupervisor = false;
                    // IR A PANTALLA PERFIL
                    _loadPantallaPerfil();
                  },
                ),
                // BOTON FARMACIAS CERCANAS
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
                // // BOTON 
                // ListTile(
                //   title: Row(
                //     children: [
                //       Icon(Icons.list),
                //       Container(
                //         margin: EdgeInsets.only(left: 10),
                //         child: Text('Reponer medicamentos')
                //       )
                //     ],
                //   ),
                //   onTap: () {
                //     _loadPantallaReponerMedicamento();
                //   },
                // ),
                // BOTON MIS USUARIOS
                // (VISIBLE SOLO SI HA INICIADO SESION UN SUPERVISOR Y NO ESTAMOS EN MODO SUPERVISOR)
                usuarioSupervisor.supervisoriniciado
                ?
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.supervised_user_circle),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text('Mis usuarios'))
                    ],
                  ),
                  onTap: (){
                    // IR A PANTALLA USUARIOS
                    _loadPantallaUsuarios();
                  },
                )
                : Container(),
                // BOTON CONFIGURACION (SI ESTAMOS EN MODO SUPERVISOR, SE DESACTIVA)
                // !usuarioSupervisor.modosupervisor
                // ?
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
                // : Container(),
                // BOTON CERRAR SESION (SI ESTAMOS EN MODO SUPERVISOR, SE DESACTIVA)
                // !usuarioSupervisor.modosupervisor
                // ?
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
                // : Container(),
              ],
            ),
          ),
        ),
        // ####################  BODY  ####################
        body: <Widget>[
          // MEDICAMENTOS
          Container(
            child: FutureBuilder(
              future: recuperarMedicamentos(),
              builder: (context, AsyncSnapshot<List<Medicamento>> snapshot){
                print("SNAPSHOT DATA: ${snapshot.data}");
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      // PRUEBA PARA SUMAR HORAS A UNA FECHA
                      // DateTime prueba = snapshot.data![index].fechahoraultimadosis.add(Duration(hours: 1));
      
                      // COMPROBACION DE SI LA FECHA ACTUAL ES POSTERIOR A LA FECHA DE LA PROXIMA DOSIS
                      // SI ES POSTERIOR: COLOR DE FONDO DEL MEDICAMENTO EN ROJO, INDICANDO QUE HABRIA QUE TOMARLO
                      // EN CASO CONTRARIO: COLOR DE FONDO DEL MEDICAMENTO EN VERDE, INDICANDO QUE TODO CORRECTO
                      if(snapshot.data![index].dosisrestantes == 0){
                        colorFondo = Colors.grey;
                        pd = "-";
                      }
                      else if(horaActual.isAfter(snapshot.data![index].fechahoraproximadosis)){
                        colorFondo = Colors.red;
                        pd = "${snapshot.data![index].fechahoraproximadosis.day}/${snapshot.data![index].fechahoraproximadosis.month}/${snapshot.data![index].fechahoraproximadosis.year} - ${snapshot.data![index].fechahoraproximadosis.hour}:${snapshot.data![index].fechahoraproximadosis.minute}";
                      }
                      else{
                        colorFondo = Colors.green;
                        pd = "${snapshot.data![index].fechahoraproximadosis.day}/${snapshot.data![index].fechahoraproximadosis.month}/${snapshot.data![index].fechahoraproximadosis.year} - ${snapshot.data![index].fechahoraproximadosis.hour}:${snapshot.data![index].fechahoraproximadosis.minute}";
                      }
      
                      return Container(
                        height: 160,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white
                        ),
                        child: InkWell(
                          onTap: () {
                            // MODO SUPERVISOR DESACTIVADO
                            usuarioSupervisor.modosupervisor = false;
      
                            // RECOGER DATOS MEDICAMENTO SELECCIONADO
                            medicamentoSeleccionado.id = snapshot.data![index].id;
                            medicamentoSeleccionado.nombre = snapshot.data![index].nombre;
                            medicamentoSeleccionado.dosisincluidas = snapshot.data![index].dosisincluidas;
                            medicamentoSeleccionado.dosisrestantes = snapshot.data![index].dosisrestantes;
                            medicamentoSeleccionado.tiempoconsumo = snapshot.data![index].tiempoconsumo;
                            medicamentoSeleccionado.fechahoraultimadosis = snapshot.data![index].fechahoraultimadosis;
                            medicamentoSeleccionado.fechahoraproximadosis = snapshot.data![index].fechahoraproximadosis;
                            medicamentoSeleccionado.gestionadopor = snapshot.data![index].gestionadopor;
                            medicamentoSeleccionado.normasconsumo = snapshot.data![index].normasconsumo;
                            medicamentoSeleccionado.caracteristicas = snapshot.data![index].caracteristicas;
                            // IR A LA PANTALLA DETALLE MEDICAMENTO
                            _loadPantallaDetalleMedicamento();
                          },
                          child: BotonMedicamento(
                            nombre: snapshot.data![index].nombre,
                            ultimaDosis: "${snapshot.data![index].fechahoraultimadosis.day}/${snapshot.data![index].fechahoraultimadosis.month}/${snapshot.data![index].fechahoraultimadosis.year} - ${snapshot.data![index].fechahoraultimadosis.hour}:${snapshot.data![index].fechahoraultimadosis.minute}",
                            // ultimaDosis: "${prueba.day}/${prueba.month}/${prueba.year} - ${prueba.hour}:${prueba.minute}",
                            proximaDosis: pd,
                            dosisRestantes: snapshot.data![index].dosisrestantes,
                            colorFondo: colorFondo
                          ),
                        ),
                      );
                    }
                  );
                }
                else{
                  // TEXTO NO HAY MEDICAMENTOS Y AÑADIR UNO
                  print("ELSE SNAPSHOT SIN DATA");
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'NO HAY MEDICAMENTOS REGISTRADOS. HAGA CLICK EN EL BOTON "+" DE ARRIBA PARA AÑADIR UN NUEVO MEDICAMENTO.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
      
          // VISITAS MEDICAS
          Container(
            child: FutureBuilder(
              future: recuperarVisitasMedicas(),
              builder: (context, AsyncSnapshot<List<VisitaMedica>> snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      return Container(
                        height: 175,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.white
                        ),
                        child: InkWell(
                          onTap: () async{
                            // MODO SUPERVISOR DESACTIVADO
                            usuarioSupervisor.modosupervisor = false;
                            
                            // ESTABLECEMOS AMBOS VALORES EN false POR SI EL USUARIO QUITA EL ALERTDIALOG
                            // PULSANDO FUERA DE EL, AL BOTON DE ATRAS O A CANCELAR
                            modoEdicion.modoedicion = false;
                            modoEdicion.confirmacion = false;
      
                            // RECOGEMOS LOS DATOS DE LA VISITA MEDICA PULSADA
                            visitaMedicaSeleccionada.id = snapshot.data![index].id;
                            visitaMedicaSeleccionada.id_usuario = snapshot.data![index].id_usuario;
                            visitaMedicaSeleccionada.gestionadopor = snapshot.data![index].gestionadopor;
                            visitaMedicaSeleccionada.especialidad = snapshot.data![index].especialidad;
                            visitaMedicaSeleccionada.doctor = snapshot.data![index].doctor;
                            visitaMedicaSeleccionada.lugar = snapshot.data![index].lugar;
                            visitaMedicaSeleccionada.fechayhora = snapshot.data![index].fechayhora; 
                            
                            // ABRIR MENU MODIFICAR O BORRAR
                            await showDialog<void>(
                              context: context,
                              builder: (BuildContext context) => BotonClickVisitaMedica()
                            );
      
                            // SI EL USUARIO QUIERE MODIFICAR, VAMOS A LA PANTALLA DE VISITA MEDICA
                            if(modoEdicion.modoedicion){
                              _loadPantallaVisitaMedica();
                            }
                            // SI EL USUARIO QUIERE ELIMINAR, MOSTRAMOS DIALOGO DE CONFIRMACION
                            else if(modoEdicion.confirmacion){
                              await showDialog<void>(
                                context: context,
                                builder: (BuildContext context) => DialogoConfirmacion(title: "ATENCIÓN", texto: '¿Esta seguro de borrar la visita medica? Una vez confirmada la operacion, no habra marcha atras.')
                              );
      
                              if(modoEdicion.confirmacion){
                                // ELIMINACION VISITA MODO REMOTO
                                if(modoTrabajo.modoLocal){
                                  v.deleteVisitaMedica(visitaMedicaSeleccionada.id);
                                }
                                // ELIMINACION VISITA MODO LOCAL
                                else{
                                  int resultadoDelete = await bdHelper.eliminarBD("visitasmedicas", visitaMedicaSeleccionada.id);
                                  print("VISITA MEDICA ELIMINADA CORRECTAMENTE CON ID: $resultadoDelete");
                                }
      
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("VISITA MEDICA ELIMINADA CORRECTAMENTE.")
                                  )
                                );
                              }
                            }
                            // SI EL USUARIO DA A CANCELAR (NO OCURRE NADA)
                            else{
                              
                            }
                            
                          },
                          child: BotonVisitaMedica(
                            especialidad: snapshot.data![index].especialidad,
                            doctor: snapshot.data![index].doctor,
                            lugar: snapshot.data![index].lugar,
                            fechayhora: snapshot.data![index].fechayhora
                          )
                        ),
                      );
                    }
                  );
                }
                else{
                  // TEXTO NO HAY MEDICAMENTOS Y AÑADIR UNO
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'NO HAY VISITAS MEDICAS REGISTRADAS. HAGA CLICK EN EL BOTON "+" DE ARRIBA PARA AÑADIR UNA NUEVA VISITA MEDICA.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ][currentPageIndex],
        // ############# FLOATINGACTIONBUTTON #############
        // floatingActionButton: FloatingActionButton.extended(
        //    onPressed: () {
        //   // Acción a realizar cuando se presione el botón
        //   },
        //   label: Text('Nuevo medicamento'),
        //   icon: Icon(Icons.add),
        //   backgroundColor: Color(0xFF009638), // Color de fondo del botón
        // ),
        // #############  BOTTOMNAVIGATIONBAR  ############
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index){
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Color(0xFF009638),
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.medication),
              icon: Icon(Icons.medication_outlined),
              label: 'Medicamentos',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.medical_information),
              icon: Icon(Icons.medical_information_outlined),
              label: 'Visitas medicas',
            )
          ],
        ),
      ),
    );
  }
}