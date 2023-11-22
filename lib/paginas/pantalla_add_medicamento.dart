import 'package:flutter/material.dart';

class PantallaAddMedicamento extends StatefulWidget {
  const PantallaAddMedicamento({super.key});

  @override
  State<PantallaAddMedicamento> createState() => _PantallaAddMedicamentoState();
}

class _PantallaAddMedicamentoState extends State<PantallaAddMedicamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #################### APPBAR ####################
      appBar: AppBar(
        automaticallyImplyLeading: false, // HACE QUE NO SALGA EL BOTON DE VOLVER
        title: Center(
          child: Text("AÑADIR UN MEDICAMENTO"),
        ),
      ),
      // ####################  BODY  ####################
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // TEXTO: "Introduzca el nombre del medicamento"
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "Introduzca el nombre del medicamento",
                style: TextStyle(
                  fontSize: 19
                ),
              ),
            ),
          ),
          // TEXFIELD NOMBRE USUARIO
          Center(
            child: Container(
              width: 350,
              margin: EdgeInsets.only(bottom: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Nombre de usuario",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                  
                },
              ),
            ),
          ),
          // TEXTO: "¿Durante cuantos dias tiene que tomarlo?"
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "¿Durante cuantos dias tiene que tomarlo?",
                style: TextStyle(
                  fontSize: 19
                ),
              ),
            ),
          ),
          // ROW DIAS
          Row(
            children: [
              Container(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 8),
                  child: Text(
                    "Pulse en el recuadro e indique un numero => ",
                    style: TextStyle(
                      
                    ),
                  ),
                ),
              ),
              Container(
                width: 45,
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "0",
                    border: OutlineInputBorder()
                  ),
                  onChanged: (value){},
                ),
              )
            ],
          ),
          // TEXTO: "¿Cuantas dosis vienen en la caja?"
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                "¿Cuantas dosis vienen en la caja?",
                style: TextStyle(
                  fontSize: 19
                ),
              ),
            ),
          ),
          // ROW NUMERO DOSIS
          Row(
            children: [
              Container(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 8),
                  child: Text(
                    "Pulse en el recuadro e indique un numero => ",
                    style: TextStyle(
                      
                    ),
                  ),
                ),
              ),
              Container(
                width: 45,
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "0",
                    border: OutlineInputBorder()
                  ),
                  onChanged: (value){},
                ),
              )
            ],
          ),
          // ROW FECHA DOSIS
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 30),
                child: Text(
                  "Introduzca la fecha de la primera dosis:"
                ),
              ),
              Container(
                width: 70,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Fecha",
                    border: OutlineInputBorder(),
                  ),
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(19701231),
                      lastDate: DateTime.now(),
                    );
                  },
                  onChanged: (value){
                    
                  },
                )
              )
            ],
          ),
          // ROW HORA DOSIS
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 37),
                child: Text(
                  "Introduzca la hora de la primera dosis:"
                ),
              ),
              Container(
                width: 70,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Hora",
                    border: OutlineInputBorder(),
                  ),
                  onTap: (){
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now()
                    );
                  },
                  onChanged: (value){
                    
                  },
                )
              )
            ],
          ),
          // BUTTON MAS OPCIONES
          Center(
              child: Container(
                width: 300,
                margin: EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: TextButton(
                  child: const Text(
                    "MAS OPCIONES",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22
                    ),
                  ),
                  onPressed: (){
                    // IR A PANTALLA "MAS OPCIONES"
                  },
                ),
              ),
            ),
        ],
      ),
      // #############  BOTTOMNAVIGATIONBAR  ############
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: "Guardar medicamento",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: "Cancelar y volver a la agenda"
          ),
        ],
        onTap: (value){
          switch(value){
            case 0:
              // COMPROBAR QUE ESTAN RELLENADOS TODOS LOS CAMPOS
              // GUARDAR MEDICAMENTO Y VOLVER A LA AGENDA
            break;
            case 1:
              // SHOWDIALOG DE SI ESTA SEGURO QUE QUIERE CANCELAR??
              // NO GUARDAR MEDICAMENTO Y VOLVER A LA AGENDA
            break;
          }
        },
      ),
    );
  }
}