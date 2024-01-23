import 'package:farmacapp/paginas/pantalla_mas_opciones_medicamento.dart';
import 'package:flutter/material.dart';

class PantallaAddMedicamento extends StatefulWidget {
  const PantallaAddMedicamento({super.key});

  @override
  State<PantallaAddMedicamento> createState() => _PantallaAddMedicamentoState();
}

class _PantallaAddMedicamentoState extends State<PantallaAddMedicamento> {

  // VARIABLES QUE USAREMOS PARA CONTROLAR SI SE HA ESCRITO ALGO O NO
  // CUANDO CREEMOS EL MEDICAMENTO-
  String nombre = "", fecha = "", hora = "";
  int dias = 0, dosis = 0;
  // var txt = TextEditingController();
  
  // FUNCION PARA CARGAR LA PANTALLA DE AÑADIR MAS OPCIONES AL MEDICAMENTO
  _loadPantallaMasOpcionesMedicamento () async{
    final destino = MaterialPageRoute(builder:(_)=>PantallaMasOpcionesMedicamento());
    final datoDevuelto = await Navigator.push(context, destino);
    
    setState((){
      
    });
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101)
    );
    if(picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TimeOfDay selectedHour = TimeOfDay.now();
  String selectedHourString = "Hora";
  Future<void> _selectHour(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child){
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if(picked != null && picked != selectedHour) {
      setState(() {
        selectedHour = picked;
        selectedHourString = "${selectedHour.hour}:${selectedHour.minute}";
        if(picked.hour < 10){
          selectedHourString = "0${selectedHour.hour}:${selectedHour.minute}";
        }
        if(picked.minute < 10){
          selectedHourString = "0${selectedHour.hour}:0${selectedHour.minute}";
        }
      });
    }
  }
  
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
                  hintText: "Nombre del medicamento",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value){
                  nombre = value;
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
              // TEXTO "Pulse en el recuadro e indique un numero =>"
              Container(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 8),
                  child: Text("Pulse en el recuadro e indique un numero => "),
                ),
              ),
              // TEXTFIELD DIAS
              Container(
                width: 45,
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "0",
                    border: OutlineInputBorder()
                  ),
                  onChanged: (value){
                    dias = int.parse(value);
                  },
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
              // TEXTO "Pulse en el recuadro e indique un numero =>"
              Container(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 8),
                  child: Text("Pulse en el recuadro e indique un numero => "),
                ),
              ),
              // TEXTFIELD DOSIS
              Container(
                width: 45,
                margin: EdgeInsets.only(bottom: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "0",
                    border: OutlineInputBorder()
                  ),
                  onChanged: (value){
                    dosis = int.parse(value);
                  },
                ),
              )
            ],
          ),
          // ROW FECHA DOSIS
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 50),
                child: Text(
                  "Fecha de la primera dosis:"
                ),
              ),
              Container(
                width: 120,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  // color: Colors.grey,
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: TextField(
                  // controller: txt,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "${selectedDate}".split(" ")[0],
                    border: OutlineInputBorder()
                  ),
                  onTap: (){
                    // IMPEDIMOS QUE ABRA EL TECLADO AL PULSAR EL EDITTEXT
                    FocusScope.of(context).requestFocus(FocusNode());
                    // ABRIMOS EL SELECTOR DE FECHA
                    _selectDate(context);

                    // FECHA DE PRUEBA
                    // DateTime a = new DateTime(
                    //   selectedDate.year,
                    //   selectedDate.month,
                    //   selectedDate.day,
                    //   selectedHour.hour,
                    //   selectedHour.minute
                    // );
                    // print("FECHA DE PRUEBA: $a");
                  },
                )
              )
            ],
          ),
          // ROW HORA DOSIS
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 58),
                child: Text(
                  "Hora de la primera dosis:"
                ),
              ),
              Container(
                width: 120,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    // hintText: "$selectedHourString",
                    hintText: "${selectedHour.hour}:${selectedHour.minute}",
                    border: OutlineInputBorder(),
                  ),
                  onTap: (){
                    // IMPEDIMOS QUE ABRA EL TECLADO AL PULSAR EL EDITTEXT
                    FocusScope.of(context).requestFocus(FocusNode());
                    // ABRIMOS EL SELECTOR DE HORA
                    _selectHour(context);
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
                  _loadPantallaMasOpcionesMedicamento();
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
              // COMPROBAR QUE ESTAN RELLENADOS LOS CAMPOS DE NOMBRE, DIAS Y DOSIS
              if(nombre == "" || dias == 0 || dosis == 0){
                showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Center(child: const Text('ERROR')),
                  content: const Text(
                    'Por favor, rellena los campos de nombre, dias y dosis incluidas.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('ACEPTAR'),
                    )
                  ],
                ),
              );
              }
              else{
                // GUARDAR MEDICAMENTO EN LA BASE DE DATOS
                // SI NO SE HA INDICADO FECHA Y HORA DE LA PRIMERA DOSIS, EL SISTEMA PONGA LA FECHA Y HORA ACTUAL
                Navigator.pop(context);
              }
            break;
            case 1:
              // SHOWDIALOG DE SI ESTA SEGURO QUE QUIERE CANCELAR
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Center(child: const Text('¡ATENCION!')),
                  content: const Text('¿Estas seguro de que deseas cancelar y volver a la agenda?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context, 'Cancel'); // QUITA EL RECUADRO DE ALERTA
                      },
                      child: const Text('CANCELAR'),
                    ),
                    TextButton(
                      onPressed: (){
                        // (CONFIRMAR) NO GUARDAR MEDICAMENTO Y VOLVER A LA AGENDA
                        Navigator.pop(context, 'OK'); // QUITA EL RECUADRO DE ALERTA
                        Navigator.pop(context);       // VOLVEMOS A LA PANTALLA DE LA AGENDA
                        // Navigator.of(context).pop();                     
                      },
                      child: const Text('CONFIRMAR'),
                    ),
                  ],
                ),
              );
            break;
          }
        },
      ),
    );
  }
}