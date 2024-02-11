import 'package:farmacapp/modelos/medicamento.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PantallaDetalleMedicamento extends StatefulWidget {
  const PantallaDetalleMedicamento({super.key});

  @override
  State<PantallaDetalleMedicamento> createState() => _PantallaDetalleMedicamentoState();
}

class _PantallaDetalleMedicamentoState extends State<PantallaDetalleMedicamento> {

  // NAVIGATION BAR
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

    var medicamentoSeleccionado = Provider.of<Medicamento>(context);
    var modoEdicion = Provider.of<ModoEdicion>(context);

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
                "${medicamentoSeleccionado.fechahoraproximadosis.day}/${medicamentoSeleccionado.fechahoraproximadosis.month}/${medicamentoSeleccionado.fechahoraproximadosis.year} - ${medicamentoSeleccionado.fechahoraproximadosis.hour}:${medicamentoSeleccionado.fechahoraproximadosis.minute}",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // BOTON REGISTRAR DOSIS
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
                    "REGISTRAR DOSIS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: (){
              
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
                    // VAMOS A LA PANTALLA DE AÑADIR MEDICAMENTO

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
                  onPressed: (){
                    // ALERT DE SI ESTAS SEGURO, AL DARLE QUE SI, ELIMINAR Y VOLVER ATRAS (TOAST SE HA ELIMINADO)
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