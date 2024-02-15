import 'dart:io';

// import 'package:camera/camera.dart';
import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/modelos/medicamento.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/provider/modo_trabajo.dart';
import 'package:farmacapp/provider/usuario_supervisor.dart';
import 'package:farmacapp/widgets/boton_add_imagen.dart';
import 'package:farmacapp/widgets/dialogo.dart';
import 'package:farmacapp/widgets/dialogo_dosis_consumidas.dart';
import 'package:farmacapp/widgets/take_picture_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PantallaMedicamento extends StatefulWidget {
  const PantallaMedicamento({super.key});

  @override
  State<PantallaMedicamento> createState() => _PantallaMedicamentoState();
}

class _PantallaMedicamentoState extends State<PantallaMedicamento> {

  // VARIABLES PARA SI MODIFICAMOS LA FOTO DEL MEDICAMENTO
  // Y CARGAMOS UNA DE LA CAMARA O GALERIA
  bool fotoModificada = false;
  File ? _selectedImage;

  // INSTANCIA A LA BASE DE DATOS LOCAL SQLITE
  BDHelper bdHelper = BDHelper();

  // VARIABLE USADA PARA SI ESTA ACTIVADO EL MODO EDICION, QUE SOLO MODIFIQUE LOS CAMPOS
  // UNA VEZ (PORQUE SINO LOS MODIFICA TODO EL RATO) Y ASI PERMITA EDITARLOS
  bool primeraVez = true;

  // NAVIGATION BAR
  int currentPageIndex = 0;

  TextEditingController _textFieldNombre = TextEditingController();
  TextEditingController _textFieldDosis = TextEditingController();
  TextEditingController _textFieldHoras = TextEditingController();
  TextEditingController _textFieldNormasConsumo = TextEditingController();
  TextEditingController _textFieldCaracteristicas = TextEditingController();

  // TEXTO APPBAR (AÑADIENDO O MODIFICANDO)
  String textoAppBar = "AÑADIENDO MEDICAMENTO";
  
  // RUTA FOTO (PARA MODO AÑADIR O MODIFICAR)
  String rutaFoto = "assets/images/image_add_photo.png";

  // VARIABLES QUE USAREMOS PARA CONTROLAR SI SE HA ESCRITO ALGO O NO
  // CUANDO CREEMOS EL MEDICAMENTO
  String nombre = "", normasconsumo = "", caracteristicas = "", stringDosis = "", stringHoras = "";
  int dosis = 0, horas = 0;

  DateTime selectedDate = DateTime.now();                 // GUARDA LA FECHA SELECCIONADA EN EL DATEPICKER. POR DEFECTO, FECHA ACTUAL
  String selectedDateString = "Dia";                      // STRING QUE MUESTRA LA FECHA SELECCIONADA EN EL DATEPICKER

  // METODO QUE MUESTRA EL DATEPICKER AL PULSAR EN EL EDITTEXT "FECHA PRIMERA DOSIS"
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
        selectedDateString = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
        if(selectedDate.day < 10){
          selectedDateString = "0${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
        }
        if(selectedDate.month < 10){
          selectedDateString = "${selectedDate.day}/0${selectedDate.month}/${selectedDate.year}";
        }
        if(selectedDate.day < 10 && selectedDate.month < 10){
          selectedDateString = "0${selectedDate.day}/0${selectedDate.month}/${selectedDate.year}";
        }
      });
    }
  }

  TimeOfDay selectedHour = TimeOfDay.now();               // GUARDA LA HORA SELECCIONADA EN EL TIMEPICKER. POR DEFECTO, HORA ACTUAL
  String selectedHourString = "Hora";                     // STRING QUE MUESTRA LA ULTIMA HORA SELECCIONADA EN EL TIMEPICKER
  
  // METODO QUE MUESTRA EL TIMEPICKER AL PULSAR EN EL EDITTEXT "FECHA PRIMERA DOSIS"
  Future<void> _selectHour(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedHour,
      builder: (BuildContext context, Widget? child){
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if(picked != null) {
      setState(() {
        selectedHour = picked;
        selectedHourString = "${selectedHour.hour}:${selectedHour.minute}";
        if(picked.hour < 10){
          selectedHourString = "0${selectedHour.hour}:${selectedHour.minute}";
        }
        if(picked.minute < 10){
          selectedHourString = "${selectedHour.hour}:0${selectedHour.minute}";
        }
        if(picked.hour < 10 && picked.minute < 10){
          selectedHourString = "0${selectedHour.hour}:0${selectedHour.minute}";
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // PROVIDERS
    var usuarioIniciado = Provider.of<Usuario>(context);
    var usuarioSupervisor = Provider.of<UsuarioSupervisor>(context);
    var medicamentoSeleccionado = Provider.of<Medicamento>(context);
    final modoTrabajo = Provider.of<ModoTrabajo>(context);
    var modoEdicion = Provider.of<ModoEdicion>(context);

    // SI ESTA ACTIVADO EL MODO EDICION, SE RELLENAN LOS CAMPOS CON LOS DATOS DEL MEDICAMENTO A EDITAR
    if(modoEdicion.modoedicion && primeraVez){
      primeraVez = false;

      textoAppBar = "MODIFICANDO MEDICAMENTO";

      rutaFoto = "assets/images/medicamento-generico.jpg";

      nombre = medicamentoSeleccionado.nombre;
      dosis = medicamentoSeleccionado.dosisincluidas;
      stringDosis = medicamentoSeleccionado.dosisincluidas.toString();
      horas = medicamentoSeleccionado.tiempoconsumo;
      stringHoras = medicamentoSeleccionado.tiempoconsumo.toString();
      normasconsumo = medicamentoSeleccionado.normasconsumo;
      caracteristicas = medicamentoSeleccionado.caracteristicas;

      _textFieldNombre.text = medicamentoSeleccionado.nombre;
      _textFieldDosis.text = medicamentoSeleccionado.dosisincluidas.toString();
      _textFieldHoras.text = medicamentoSeleccionado.tiempoconsumo.toString();
      _textFieldNormasConsumo.text = medicamentoSeleccionado.normasconsumo;
      _textFieldCaracteristicas.text = medicamentoSeleccionado.caracteristicas;
      selectedDate = medicamentoSeleccionado.fechahoraultimadosis;
      selectedHour = TimeOfDay(
        hour: medicamentoSeleccionado.fechahoraultimadosis.hour,
        minute: medicamentoSeleccionado.fechahoraultimadosis.minute
      );

      selectedDateString = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      if(selectedDate.day < 10){
        selectedDateString = "0${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      }
      if(selectedDate.month < 10){
        selectedDateString = "${selectedDate.day}/0${selectedDate.month}/${selectedDate.year}";
      }
      if(selectedDate.day < 10 && selectedDate.month < 10){
        selectedDateString = "0${selectedDate.day}/0${selectedDate.month}/${selectedDate.year}";
      }

      selectedHourString = "${selectedDate.hour}:${selectedDate.minute}";
      if(selectedDate.hour < 10){
        selectedHourString = "0${selectedDate.hour}:${selectedDate.minute}";
      }
      if(selectedDate.minute < 10){
        selectedHourString = "${selectedDate.hour}:0${selectedDate.minute}";
      }
      if(selectedDate.hour < 10 && selectedDate.minute < 10){
        selectedHourString = "0${selectedDate.hour}:0${selectedDate.minute}";
      }
    }

    return Scaffold(
      // #################### APPBAR ####################
      appBar: AppBar(
        automaticallyImplyLeading: false, // HACE QUE NO SALGA EL BOTON DE VOLVER
        title: Center(child: Text(textoAppBar)),
      ),
      // ####################  BODY  ####################
      body: <Widget>[
        // PAGINA CARACTERISTICAS PRINCIPALES
        Center(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TEXTO Y TEXTFIELD "INTRODUZCA EL NOMBRE DEL MEDICAMENTO"
                Text(
                  "Introduzca el nombre del medicamento",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    width: 350,
                    // margin: EdgeInsets.only(bottom: 20),
                    child: TextField(
                      controller: _textFieldNombre,
                      decoration: InputDecoration(
                        hintText: "Nombre del medicamento",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      onChanged: (value){
                        nombre = value;
                      },
                    ),
                  ),
                ),
                // ESPACIO
                SizedBox(
                  height: 30,
                ),
                // TEXTO "INTRODUZCA LA CANTIDAD DE DOSIS INCLUIDAS"
                Text(
                  "Introduzca la cantidad de dosis incluidas",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // ROW CANTIDAD DOSIS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      // TEXTO "Pulse e indique un numero"
                      Container(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16, left: 8),
                          child: Text(
                            "Pulse e indique un numero  -->",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                        ),
                      ),
                      // TEXTFIELD CANTIDAD DOSIS
                      Container(
                        width: 45,
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: _textFieldDosis,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: " 0",
                            border: OutlineInputBorder()
                          ),
                          onChanged: (value){
                            stringDosis = value;
                            dosis = int.parse(value);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                // ESPACIO
                SizedBox(
                  height: 10,
                ),
                // TEXTO "¿CADA CUANTAS HORAS TIENE QUE TOMARLO?"
                Text(
                  "¿Cada cuantas horas tiene que tomarlo?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // ROW HORAS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      // TEXTO "Pulse e indique un numero"
                      Container(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16, left: 8),
                          child: Text(
                            "Pulse e indique un numero  -->",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                          ),
                        ),
                      ),
                      // TEXTFIELD HORAS
                      Container(
                        width: 45,
                        margin: EdgeInsets.only(bottom: 20),
                        child: TextField(
                          controller: _textFieldHoras,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: " 0",
                            border: OutlineInputBorder()
                          ),
                          onChanged: (value){
                            stringHoras = value;
                            horas = int.parse(value);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                // ESPACIO
                SizedBox(
                  height: 5,
                ),
                // ROW FECHA ULTIMA DOSIS
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 14),
                        child: Text(
                          "Fecha de la ultima dosis: ",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: InkWell(
                          child: Center(
                            child: Text(
                              "${selectedDateString}".split(" ")[0],
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: (){
                            _selectDate(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                // ESPACIO
                SizedBox(
                  height: 20,
                ),
                // ROW HORA ULTIMA DOSIS
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 23),
                        child: Text(
                          "Hora de la ultima dosis: ",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: InkWell(
                          child: Center(
                            child: Text(
                              "$selectedHourString",
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: (){
                            _selectHour(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                // ESPACIO
                SizedBox(
                  height: 30,
                ),
                // BOTON GUARDAR MEDICAMENTO
                Container(
                  width: 345,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Color(0xFF009638),
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: TextButton(
                    child: const Text(
                      "GUARDAR MEDICAMENTO",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: ()async{
                      // CREAMOS UN DATETIME QUE "JUNTE" LA FECHA Y HORA SELECCIONADAS
                      DateTime selectedDateTime = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedHour.hour,
                        selectedHour.minute
                      );

                      // 1. COMPROBACION DE CAMPOS VACIOS (NOMBRE, DOSIS, HORAS, FECHA Y HORA)
                      if(nombre == "" || stringDosis == "" || stringHoras == ""){
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => Dialogo(texto: "Por favor, rellena todos los campos.")
                        );
                      }
                      else if(selectedDateString == "Dia" || selectedHourString == "Hora"){
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) => Dialogo(texto: "Por favor, introduzca la fecha y hora en la que se ha tomado la ultima dosis.\n\nNOTA: Si aun no se ha tomado la dosis o no recuerda el momento en el que lo hizo, introduzca la fecha actual.")
                        );
                      }
                      // 2. COMPROBACION DE MODO REMOTO
                      else{
                        // // MODO REMOTO
                        // if(modoTrabajo.modoLocal){
                        //   Medicamento m = new Medicamento();
                        //   // AÑADIR MEDICAMENTO REMOTO
                        //   if(!modoEdicion.modoedicion){
                        //     m = await m.createMedicamento(
                        //       usuarioIniciado.id,
                        //       nombre,
                        //       dosis,
                        //       horas,
                        //       selectedDateTime,
                        //       selectedDateTime.add(Duration(hours: horas)),
                        //       usuarioIniciado.nombre,
                        //       normasconsumo,
                        //       caracteristicas
                        //     );
                        //     Navigator.pop(context);
                        //   }
                        //   // MODIFICAR MEDICAMENTO REMOTO
                        //   else{
                        //     // SI SE HAN MODIFICADO EL NUMERO DE DOSIS INCLUIDAS
                        //     if(medicamentoSeleccionado.dosisincluidas != dosis){
                        //       modoEdicion.dosisconsumidas = 0;
                        //       await showDialog<void>(
                        //         barrierDismissible: false,
                        //         context: context,
                        //         builder: (BuildContext context) => DialogoDosisConsumidas(dosisincluidas: dosis)
                        //       );
                        //     }

                        //     // COMPROBACIONES DE SI NO SE HA MODIFICADO NADA???

                        //     await m.updateMedicamento(
                        //       medicamentoSeleccionado.id,
                        //       nombre,
                        //       dosis,
                        //       modoEdicion.dosisconsumidas,
                        //       horas,
                        //       selectedDateTime,
                        //       selectedDateTime.add(Duration(hours: horas)),
                        //       normasconsumo,
                        //       caracteristicas
                        //     );
                        //     Navigator.pop(context);
                        //     Navigator.pop(context);
                        //   }
                        // }
                        // // MODO LOCAL
                        // else{
                        //   // AÑADIR MEDICAMENTO LOCAL
                        //   if(!modoEdicion.modoedicion){
                        //     // FECHAS
                        //     String fud = selectedDateTime.toIso8601String();
                        //     String fpd = selectedDateTime.add(Duration(hours: horas)).toIso8601String();

                        //     bdHelper.insertarBD("medicamentos", {
                        //       "id_usuario": usuarioIniciado.id,
                        //       "nombre": nombre,
                        //       "dosisincluidas": dosis,
                        //       "dosisrestantes": dosis,
                        //       "tiempoconsumo": horas,
                        //       "fechahoraultimadosis": fud,
                        //       "fechahoraproximadosis": fpd,
                        //       "gestionadopor": usuarioIniciado.nombre,
                        //       "normasconsumo": normasconsumo,
                        //       "caracteristicas": caracteristicas
                        //     });

                        //     Navigator.pop(context);
                        //   }
                        //   // MODIFICAR MEDICAMENTO LOCAL
                        //   else{
                            
                        //   }
                        // }

                        
                        // 2. COMPROBACION DE SI SE VA A CREAR O MODIFICAR

                        Medicamento m = new Medicamento();
                        // FECHAS EN FORMATO SQLITE
                        String fud = selectedDateTime.toIso8601String();
                        String fpd = selectedDateTime.add(Duration(hours: horas)).toIso8601String();

                        // MODO AÑADIR MEDICAMENTO
                        if(!modoEdicion.modoedicion){
                          // AÑADIR MODO REMOTO
                          if(modoTrabajo.modoLocal){
                            // MODO SUPERVISOR (UN SUPERVISOR LE AÑADE EL MEDICAMENTO A UN USUARIO)
                            if(usuarioSupervisor.modosupervisor){
                              m = await m.createMedicamento(
                                usuarioIniciado.id,
                                nombre,
                                dosis,
                                horas,
                                selectedDateTime,
                                selectedDateTime.add(Duration(hours: horas)),
                                usuarioSupervisor.nombre,
                                normasconsumo,
                                caracteristicas
                              );
                            }
                            // MODO "NORMAL" (UN USUARIO/SUPERVISOR SE AÑADE SU PROPIO MEDICAMENTO)
                            else{
                              m = await m.createMedicamento(
                                usuarioSupervisor.supervisoriniciado ? usuarioSupervisor.id : usuarioIniciado.id,
                                nombre,
                                dosis,
                                horas,
                                selectedDateTime,
                                selectedDateTime.add(Duration(hours: horas)),
                                usuarioSupervisor.supervisoriniciado ? usuarioSupervisor.nombre : usuarioIniciado.nombre,
                                normasconsumo,
                                caracteristicas
                              );
                            }
                          }
                          // AÑADIR MODO LOCAL
                          else{
                            // FECHAS
                            // String fud = selectedDateTime.toIso8601String();
                            // String fpd = selectedDateTime.add(Duration(hours: horas)).toIso8601String();

                            // MODO SUPERVISOR (UN SUPERVISOR LE AÑADE EL MEDICAMENTO A UN USUARIO)
                            if(usuarioSupervisor.modosupervisor){
                              bdHelper.insertarBD("medicamentos", {
                                "id_usuario": usuarioIniciado.id,
                                "nombre": nombre,
                                "dosisincluidas": dosis,
                                "dosisrestantes": (dosis-1),
                                "tiempoconsumo": horas,
                                "fechahoraultimadosis": fud,
                                "fechahoraproximadosis": fpd,
                                "gestionadopor": usuarioSupervisor.nombre,
                                "normasconsumo": normasconsumo,
                                "caracteristicas": caracteristicas
                              });
                            }
                            // MODO "NORMAL" (UN USUARIO/SUPERVISOR SE AÑADE SU PROPIO MEDICAMENTO)
                            else{
                              bdHelper.insertarBD("medicamentos", {
                                "id_usuario": usuarioSupervisor.supervisoriniciado ? usuarioSupervisor.id : usuarioIniciado.id,
                                "nombre": nombre,
                                "dosisincluidas": dosis,
                                "dosisrestantes": (dosis-1),
                                "tiempoconsumo": horas,
                                "fechahoraultimadosis": fud,
                                "fechahoraproximadosis": fpd,
                                "gestionadopor": usuarioSupervisor.supervisoriniciado ? usuarioSupervisor.nombre : usuarioIniciado.nombre,
                                "normasconsumo": normasconsumo,
                                "caracteristicas": caracteristicas
                              });
                            }
                          }
                          Navigator.pop(context);
                        }
                        // MODO MODIFICAR MEDICAMENTO
                        else{
                          modoEdicion.dosisconsumidas = 0;
                          modoEdicion.confirmacion = true;

                          // VARIABLE QUE GUARDARA LAS DOSIS RESTANTES DEL MEDICAMENTO
                          // SEGUN SI HEMOS ACTUALIZADO LAS DOSIS INCLUIDAS O NO
                          int dr;
                          
                          // SI SE HAN MODIFICADO EL NUMERO DE DOSIS INCLUIDAS
                          if(medicamentoSeleccionado.dosisincluidas != dosis){
                            await showDialog<void>(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => DialogoDosisConsumidas(dosisincluidas: dosis)
                            );
                            
                            // SE RESTAN LAS DOSIS QUE SE HAYAN CONSUMIDO A LAS NUEVAS "DOSIS INCLUIDAS" ACTUALIZADAS
                            if(modoEdicion.dosisconsumidas > 0){
                              dr = dosis - modoEdicion.dosisconsumidas;
                            }
                            // SI NO SE HA CONSUMIDO NINGUNA, SE INDICAN LAS MISMAS DOSIS RESTANTES QUE INCLUIDAS
                            else{
                              dr = dosis;
                            }
                          }
                          // SI NO SE HAN ACTUALIZADO, SE MANTIENE EL NUMERO DE DOSIS RESTANTES QUE HABIA
                          else{
                            dr = medicamentoSeleccionado.dosisrestantes;
                          }

                          if(modoEdicion.confirmacion){
                            // MODIFICAR MODO REMOTO
                            if(modoTrabajo.modoLocal){
                              await m.updateMedicamento(
                                medicamentoSeleccionado.id,
                                nombre,
                                dosis,
                                dr,
                                horas,
                                selectedDateTime,
                                selectedDateTime.add(Duration(hours: horas)),
                                usuarioSupervisor.supervisoriniciado ? usuarioSupervisor.nombre : usuarioIniciado.nombre,
                                normasconsumo,
                                caracteristicas
                              );
                            }
                            // MODIFICAR MODO LOCAL
                            else{
                              int resultadoUpdate = await bdHelper.actualizarBD("medicamentos", {
                                "id": medicamentoSeleccionado.id,
                                // "id_usuario": usuarioIniciado.id,
                                "nombre": nombre,
                                "dosisincluidas": dosis,
                                "dosisrestantes": dr,
                                "tiempoconsumo": horas,
                                "fechahoraultimadosis": fud,
                                "fechahoraproximadosis": fpd,
                                "gestionadopor": usuarioSupervisor.supervisoriniciado ? usuarioSupervisor.nombre : usuarioIniciado.nombre,
                                "normasconsumo": normasconsumo,
                                "caracteristicas": caracteristicas
                              });
                              print("MEDICAMENTO ACTUALIZADO EN BD LOCAL CON RESULTADO: $resultadoUpdate");
                            }

                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        }
                      }
                    },
                  ),
                ),
                // ESPACIO
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),

        // PAGINA OTRAS CARACTERISTICAS
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // TEXTO "FOTOGRAFIA DEL MEDICAMENTO"
                Text(
                  "Fotografia del medicamento",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                // RECUADRO FOTO
                Center(
                  child: InkWell(
                    child: Container(
                      width: 300,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all()
                      ),
                      child: fotoModificada ? Image.file(_selectedImage!,fit: BoxFit.fill) : Image.asset(rutaFoto)
                    ),
                    onTap: () async{
                      // EL MOVIL PEDIRA INCLUIR UNA FOTO
                      print("EL MOVIL PEDIRA UNA FOTO");
                      
                      // // Obtain a list of the available cameras on the device.
                      // final cameras = await availableCameras();
                      // // Get a specific camera from the list of available cameras.
                      // final firstCamera = cameras.first;
                      // final destino = MaterialPageRoute(builder: (_) => TakePictureScreen(camera: firstCamera));
                      // final datoDevuelto = await Navigator.push(context, destino);
                      // setState(() {
                      //   rutaFoto = "assets/images/medicamento-generico.jpg";
                      // });

                      modoEdicion.fotocamara = 0;
                      
                      await showDialog<void>(
                        // barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) => BotonAddImagen()
                      );
                      
                      if(modoEdicion.fotocamara != 0){
                        _pickImage(modoEdicion.fotocamara);
                      }
                    },
                  )
                ),
                // Center(
                //   child: InkWell(
                //     onTap: (){
                //       // EL MOVIL PEDIRA INCLUIR UNA FOTO
                //       print("EL MOVIL PEDIRA UNA FOTO");
                //     },
                //     child: Container(
                //       width: 300,
                //       height: 150,
                //       decoration: BoxDecoration(
                //         color: Colors.grey,
                //         border: Border.all()
                //       ),
                //       child: const Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           // Padding(padding: EdgeInsets.only(top: 50)),
                //           Icon(Icons.photo_camera, size: 60, color: Colors.white,),
                //           Text("Añadir una foto", style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold))
                //         ]
                //       ),
                //     ),
                //   )
                // ),
                // ESPACIO
                SizedBox(
                  height: 20,
                ),
                // TEXTO "NORMAS DE CONSUMO DEL MEDICAMENTO"
                Text(
                  "Normas de consumo del medicamento",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    width: 300,
                    height: 150,
                    child: TextField(
                      maxLines: 8,
                      controller: _textFieldNormasConsumo,
                      decoration: InputDecoration(
                        hintText: "Normas de consumo del medicamento",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      onChanged: (value){
                        normasconsumo = value;
                      },
                    ),
                  ),
                ),
                // ESPACIO
                SizedBox(
                  height: 20,
                ),
                // TEXTO "NORMAS DE CONSUMO DEL MEDICAMENTO"
                Text(
                  "Caracteristicas del medicamento",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    width: 300,
                    height: 150,
                    child: TextField(
                      maxLines: 8,
                      controller: _textFieldCaracteristicas,
                      decoration: InputDecoration(
                        hintText: "Caracteristicas del medicamento",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                      onChanged: (value){
                        caracteristicas = value;
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
          ),
        )
      ][currentPageIndex],
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

  Future _pickImage(int fromCamera) async{
    final returnedImage;
    
    if(fromCamera == 1){
      returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    }
    else{
      returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    if(returnedImage == null) return;

    setState(() {
      fotoModificada = true;
      _selectedImage = File(returnedImage!.path);
    });
  }
}