import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/modelos/medicamento.dart';
// import 'package:farmacapp/paginas/pantalla_medicamento.dart';
import 'package:farmacapp/paginas/pantalla_addmod_medicamento.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/provider/modo_trabajo.dart';
import 'package:farmacapp/widgets/dialogo.dart';
import 'package:farmacapp/widgets/dialogo_confirmacion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PantallaDetalleMedicamento extends StatefulWidget {
  const PantallaDetalleMedicamento({super.key});

  @override
  State<PantallaDetalleMedicamento> createState() => _PantallaDetalleMedicamentoState();
}

class _PantallaDetalleMedicamentoState extends State<PantallaDetalleMedicamento> {

  // INSTANCIA A LA BASE DE DATOS LOCAL SQLITE
  BDHelper bdHelper = BDHelper();

  // NAVIGATION BAR
  int currentPageIndex = 0;

  // INSTANCIA OBJETO MEDICAMENTO
  Medicamento m = new Medicamento();

  // VARIABLES A USAR EN BASE A SI QUEDAN DOSIS DEL MEDICAMENTO O NO
  late String pd;
  late String textoRegistrarRenovar;  
  late bool renovar;
  late String textoInformativo;

  _loadPantallaMedicamento() async {
    final destino = MaterialPageRoute(builder: (_) => PantallaMedicamento());
    final datoDevuelto = await Navigator.push(context, destino);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    var medicamentoSeleccionado = Provider.of<Medicamento>(context);
    var modoTrabajo = Provider.of<ModoTrabajo>(context);
    var modoEdicion = Provider.of<ModoEdicion>(context);

    // SI YA NO QUEDAN DOSIS DEL MEDICAMENTO:
    // - EN LA FECHA DE LA PROXIMA DOSIS SALDRA UN "-"
    // - EL BOTON TENDRA EL TEXTO "RENOVAR" EN VEZ DE "REGISTRAR"
    // - CUANDO PULSEMOS EL BOTON, SE MOSTRARA EL TEXTO CORRESPONDIENTE A LA FUNCION DE RENOVAR
    // SI QUEDAN DOSIS, SE APLICARA TODO LO CONTRARIO
    if(medicamentoSeleccionado.dosisrestantes == 0){
      pd = "-";
      textoRegistrarRenovar = "RENOVAR MEDICAMENTO";
      renovar = true;
      textoInformativo = "¡Medicamento renovado correctamente!\n\nSe ha registrado la fecha y hora actual como el momento en el que ha tomado la primera dosis. De no ser asi, por favor, modifiquela.";
    }
    else{
      pd = "${medicamentoSeleccionado.fechahoraproximadosis.day}/${medicamentoSeleccionado.fechahoraproximadosis.month}/${medicamentoSeleccionado.fechahoraproximadosis.year} - ${medicamentoSeleccionado.fechahoraproximadosis.hour}:${medicamentoSeleccionado.fechahoraproximadosis.minute}";
      textoRegistrarRenovar = "REGISTRAR DOSIS";
      renovar = false;
      textoInformativo = "¡Dosis registrada correctamente!";
    }

    return Scaffold(
      // #################### APPBAR ####################
      appBar: AppBar(
        title: Text("${medicamentoSeleccionado.nombre}"),
      ),
      // ####################  BODY  ####################
      body: <Widget>[
        // PAGINA CARACTERISTICAS PRINCIPALES
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CUADRO FOTO
            Center(
              child: Container(
                width: 300,
                height: 200,
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  border: Border.all()
                ),
                // child: const Column(
                //   children: [
                //     Padding(padding: EdgeInsets.only(top: 65)),
                //     Icon(Icons.photo_camera, size: 60, color: Colors.white,),
                //   ]
                // ),
                child: Image.asset('assets/images/medicamento-generico.jpg'),
              ),
            ),
            // ESPACIO
            SizedBox(
              height: 20,
            ),
            // ROW DOSIS INCLUIDAS Y RESTANTES
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // TEXTO "DOSIS INCLUIDAS"
                        Text(
                          'Dosis incluidas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // NUMERO DOSIS INCLUIDAS
                        Text(
                          '${medicamentoSeleccionado.dosisincluidas}',
                          style: TextStyle(
                            fontSize: 36
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        // TEXTO "DOSIS RESTANTES"
                        Text(
                          'Dosis restantes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // NUMERO DOSIS RESTANTES
                        Text(
                          '${medicamentoSeleccionado.dosisrestantes}',
                          style: TextStyle(
                            fontSize: 36
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ESPACIO
            SizedBox(
              height: 15,
            ),
            // TEXTO "ULTIMA DOSIS CONSUMIDA"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                "Ultima dosis consumida",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline
                ),
              ),
            ),
            // FECHA Y HORA DE LA ULTIMA DOSIS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                "${medicamentoSeleccionado.fechahoraultimadosis.day}/${medicamentoSeleccionado.fechahoraultimadosis.month}/${medicamentoSeleccionado.fechahoraultimadosis.year} - ${medicamentoSeleccionado.fechahoraultimadosis.hour}:${medicamentoSeleccionado.fechahoraultimadosis.minute}",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // ESPACIO
            SizedBox(
              height: 20,
            ),
            // TEXTO "PROXIMA DOSIS A CONSUMIR"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                "Proxima dosis a consumir",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline
                ),
              ),
            ),
            // FECHA Y HORA DE LA PROXIMA DOSIS
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                pd,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // BOTON REGISTRAR O RENOVAR DOSIS
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
                    textoRegistrarRenovar,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: () async{

                    // FECHAS EN FORMATO SQLITE
                    String fud = DateTime.now().toIso8601String();
                    String fpd = DateTime.now().add(Duration(hours: medicamentoSeleccionado.tiempoconsumo)).toIso8601String();

                    // FUNCION RENOVAR MEDICAMENTO
                    if(renovar){
                      // MODO REMOTO
                      if(modoTrabajo.modoLocal){
                        await m.registrarDosis(
                          medicamentoSeleccionado.id,
                          medicamentoSeleccionado.dosisincluidas,
                          DateTime.now(),
                          DateTime.now().add(Duration(hours: medicamentoSeleccionado.tiempoconsumo)),
                        );
                      }
                      // MODO LOCAL
                      else{
                        int resultadoRegistroDosis = await bdHelper.actualizarBD("medicamentos", {
                          "id": medicamentoSeleccionado.id,
                          "dosisrestantes": medicamentoSeleccionado.dosisincluidas,
                          "fechahoraultimadosis": fud,
                          "fechahoraproximadosis": fpd
                        });
                        print("ID REGISTRO DOSIS LOCAL: $resultadoRegistroDosis");
                      }

                      Navigator.pop(context);

                      showDialog<void>(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) => Dialogo(texto: textoInformativo)
                      );
                    }
                    // FUNCION REGISTRAR DOSIS
                    else{
                      // SI LA FECHA ACTUAL ES ANTERIOR A LA FECHA DE PROXIMA CONSUMICION
                      if(DateTime.now().isBefore(medicamentoSeleccionado.fechahoraproximadosis)){
                        showDialog<void>(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => Dialogo(texto: "¡Aun no es la hora de tomarte la dosis! Espera hasta la fecha y/o hora indicada en el apartado 'Proxima dosis a consumir'.")
                        );
                      }
                      // EN CASO CONTRARIO
                      else{
                        // GUARDAMOS EN UNA VARIABLE LAS DOSIS RESTANTES MENOS UNA
                        int dosisrestantesmenosuna = medicamentoSeleccionado.dosisrestantes - 1;

                        // MODO REMOTO
                        if(modoTrabajo.modoLocal){
                          await m.registrarDosis(
                            medicamentoSeleccionado.id,
                            dosisrestantesmenosuna,
                            DateTime.now(),
                            DateTime.now().add(Duration(hours: medicamentoSeleccionado.tiempoconsumo)),
                          );
                        }
                        // MODO LOCAL
                        else{
                          int resultadoRegistroDosis = await bdHelper.actualizarBD("medicamentos", {
                            "id": medicamentoSeleccionado.id,
                            "dosisrestantes": dosisrestantesmenosuna,
                            "fechahoraultimadosis": fud,
                            "fechahoraproximadosis": fpd
                          });
                          print("ID REGISTRO DOSIS LOCAL: $resultadoRegistroDosis");
                        }

                        Navigator.pop(context);

                        showDialog<void>(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => Dialogo(texto: textoInformativo)
                        );
                      }
                    }
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

        // PAGINA OTRAS CARACTERISTICAS
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TEXTO "NORMAS DE CONSUMO"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                'Normas de consumo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // TEXTAREA
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Container(
                height: 150,
                width: 290,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    medicamentoSeleccionado.normasconsumo,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            // ESPACIO
            SizedBox(
              height: 20,
            ),
            // TEXTO "CARACTERISTICAS GENERALES"
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                'Caracteristicas generales',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // TEXTAREA
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Container(
                height: 150,
                width: 290,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    medicamentoSeleccionado.caracteristicas,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            // ESPACIO
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48),
              child: Text(
                "Tiempo de consumicion: Cada ${medicamentoSeleccionado.tiempoconsumo} hora(s)",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              ),
            ),
            // ESPACIO
            SizedBox(
              height: 20,
            ),
            // BOTON MODIFICAR MEDICAMENTO
            Center(
              child: Container(
                width: 300,
                height: 55,
                decoration: const BoxDecoration(
                  color: Color(0xFF009638),
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: TextButton(
                  child: const Text(
                    "MODIFICAR MEDICAMENTO",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: (){
                    // ACTIVAMOS EL MODO DE EDICION
                    modoEdicion.modoedicion = true;
                    // VAMOS A LA PANTALLA DE MEDICAMENTO
                    _loadPantallaMedicamento();
                  },
                ),
              ),
            ),
            // ESPACIO
            SizedBox(
              height: 20,
            ),
            // BOTON ELIMINAR MEDICAMENTO
            Center(
              child: Container(
                width: 300,
                height: 55,
                decoration: const BoxDecoration(
                  color: Color(0xFF009638),
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: TextButton(
                  child: const Text(
                    "ELIMINAR MEDICAMENTO",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: () async{
                    await showDialog<void>(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) => DialogoConfirmacion(title: "ATENCIÓN", texto: '¿Esta seguro de borrar el medicamento? Una vez confirmada la operacion, no habra marcha atras.')
                    );

                    if(modoEdicion.confirmacion){
                      // ELIMINAR MODO REMOTO
                      if(modoTrabajo.modoLocal){
                        await m.deleteMedicamento(medicamentoSeleccionado.id);
                      }
                      // ELIMINAR MODO LOCAL
                      else{
                        int resultadoDelete = await bdHelper.eliminarBD("medicamentos", medicamentoSeleccionado.id);
                        print("MEDICAMENTO ELIMINADO CORRECTAMENTE CON ID: $resultadoDelete");
                      }
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("MEDICAMENTO ELIMINADO CORRECTAMENTE.")
                        )
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        )

      ][currentPageIndex],
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
            icon: Icon(Icons.list),
            label: 'Caracteristicas principales',
          ),
          NavigationDestination(
            icon: Icon(Icons.add),
            label: 'Otras caracteristicas',
          )
        ],
      ),
    );
  }
}