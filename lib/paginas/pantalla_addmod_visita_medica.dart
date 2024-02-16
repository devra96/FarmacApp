import 'package:farmacapp/database/db.dart';
import 'package:farmacapp/modelos/usuario.dart';
import 'package:farmacapp/modelos/visitamedica.dart';
import 'package:farmacapp/provider/modo_edicion.dart';
import 'package:farmacapp/provider/modo_trabajo.dart';
import 'package:farmacapp/provider/usuario_supervisor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PantallaVisitaMedica extends StatefulWidget {
  const PantallaVisitaMedica({super.key});

  @override
  State<PantallaVisitaMedica> createState() => _PantallaVisitaMedicaState();
}

class _PantallaVisitaMedicaState extends State<PantallaVisitaMedica> {
  final _formKey = GlobalKey<FormState>();

  // INSTANCIA A LA BASE DE DATOS LOCAL
  BDHelper bdHelper = BDHelper();

  // VARIABLES QUE GUARDARAN EL VALOR INTRODUCIDO EN LOS CAMPOS
  late String especialidad, doctor, lugar, fecha, hora;

  // INSTANCIA DEL MODELO DE VISITAS MEDICAS PARA USAR SUS METODOS DE INSERCION Y MODIFICACION
  VisitaMedica v = new VisitaMedica();

  // VARIABLE USADA PARA SI ESTA ACTIVADO EL MODO EDICION, QUE SOLO MODIFIQUE LOS CAMPOS
  // UNA VEZ (PORQUE SINO LOS MODIFICA TODO EL RATO) Y ASI PERMITA EDITARLOS
  bool primeraVez = true;

  // TEXTO APPBAR (AÑADIENDO O MODIFICANDO) EN BASE AL MODO DE EDICION ACTIVADO O DESACTIVADO
  String textoAppBar = "AÑADIENDO VISITA";

  // CONTROLLERS PARA INSERTAR LOS VALORES DE LA VISITA MEDICA SELECCIONADA EN LOS CAMPOS
  // (EN EL MODO EDICION)
  TextEditingController _campoEspecialidad = TextEditingController();
  TextEditingController _campoDoctor = TextEditingController();
  TextEditingController _campoLugar = TextEditingController();
  TextEditingController _campoFecha = TextEditingController();
  TextEditingController _campoHora = TextEditingController();
  
  @override
  Widget build(BuildContext context) {

    // PROVIDERS
    var usuarioIniciado = Provider.of<Usuario>(context);
    var usuarioSupervisor = Provider.of<UsuarioSupervisor>(context);
    var visitaMedicaSeleccionada = Provider.of<VisitaMedica>(context);
    final modoTrabajo = Provider.of<ModoTrabajo>(context);
    var modoEdicion = Provider.of<ModoEdicion>(context);

    // SI ESTA ACTIVADO EL MODO EDICION
    if(modoEdicion.modoedicion && primeraVez){
      // PARA QUE SOLO ENTRE EN ESTE IF UNA VEZ
      primeraVez = false;

      // TEXTO DEL APPBAR
      textoAppBar = "MODIFICANDO VISITA";

      // GUARDAMOS E INSERTAMOS LOS DATOS DE LA VISITA MEDICA EN LOS CAMPOS
      especialidad = visitaMedicaSeleccionada.especialidad;
      doctor = visitaMedicaSeleccionada.doctor;
      lugar = visitaMedicaSeleccionada.lugar;
      fecha = visitaMedicaSeleccionada.fechayhora.substring(0, 10);
      hora = visitaMedicaSeleccionada.fechayhora.substring(13, 18);

      _campoEspecialidad.text = visitaMedicaSeleccionada.especialidad;
      _campoDoctor.text = visitaMedicaSeleccionada.doctor;
      _campoLugar.text = visitaMedicaSeleccionada.lugar;
      _campoFecha.text = visitaMedicaSeleccionada.fechayhora.substring(0, 10);
      _campoHora.text = visitaMedicaSeleccionada.fechayhora.substring(13, 18);
    }

    return Scaffold(
      // #################### APPBAR ####################
      appBar: AppBar(
        automaticallyImplyLeading: false, // HACE QUE NO SALGA EL BOTON DE VOLVER
        title: Center(child: Text(textoAppBar)),
      ),
      // ####################  BODY  ####################
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(15),
            physics: BouncingScrollPhysics(),
            children: [
              // CAMPO ESPECIALIDAD
              TextFormField(
                controller: _campoEspecialidad,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('Especialidad'),
                ),
                validator: (valor){
                  if(valor == null || valor.isEmpty){
                    return "El campo no puede estar vacio.";
                  }
                  else{
                    return null;
                  }
                },
                onSaved: (valor){
                  if(valor != null){
                    especialidad = valor;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              // CAMPO NOMBRE DEL DOCTOR
              TextFormField(
                controller: _campoDoctor,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('Nombre del doctor'),
                ),
                validator: (valor){
                  if(valor == null || valor.isEmpty){
                    return "El campo no puede estar vacio.";
                  }
                  else{
                    return null;
                  }
                },
                onSaved: (valor){
                  if(valor != null){
                    doctor = valor;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              // CAMPO LUGAR DE LA VISITA
              TextFormField(
                controller: _campoLugar,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text('Lugar de la visita'),
                ),
                validator: (valor){
                  if(valor == null || valor.isEmpty){
                    return "El campo no puede estar vacio.";
                  }
                  else{
                    return null;
                  }
                },
                onSaved: (valor){
                  if(valor != null){
                    lugar = valor;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              // CAMPO FECHA DE LA VISITA
              TextFormField(
                controller: _campoFecha,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  label: Text("Fecha de la visita (en formato 'DD/MM/YYYY')"),
                ),
                validator: (valor){
                  if(valor == null || valor.isEmpty){
                    return 'El campo no puede estar vacio';
                  }

                  if(RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').hasMatch(valor) == false){
                    return 'El formato de la fecha no es correcto';
                  }

                  List<String> partes = valor.split("/");
                  int dia = int.tryParse(partes[0])!;
                  int mes = int.tryParse(partes[1])!;
                  int anio = int.tryParse(partes[2])!;

                  try{
                    DateTime fecha = new DateTime(anio, mes, dia);
                  }
                  catch(e){
                    return 'La fecha no es correcta';
                  };
                  
                  return null;
                },
                onSaved: (valor){
                  if(valor!=null){
                    fecha = valor;
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              // CAMPO HORA DE LA VISITA
              TextFormField(
                controller: _campoHora,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  label: Text('Hora de la visita (en formato HH:MM)'),
                ),
                validator: (valor){
                  if(valor==null || valor.isEmpty){
                    return 'El campo no puede estar vacio';
                  }

                  if(RegExp(r'^[0-2][0-9]:[0-5][0-9]$').hasMatch(valor)==false){
                    return 'El formato de la fecha no es correcto';
                  }
                  else{
                    return null;
                  }
                },
                onSaved: (valor) {
                  if(valor!=null){
                    hora = valor;
                  }
                },
              ),
              SizedBox(
                height: 30,
              ),
              // BOTON GUARDAR
              // ElevatedButton(
              //   child: Text('Guardar'),
              //   onPressed: (){
                  // if(_formKey.currentState!.validate()) {
                  //   _formKey.currentState!.save();

                  //   // bdHelper.insertarBD('VisitaMedica', visitaMedica.toMap());
                    
                  //   Navigator.pop(context);
                  // }
              //   },
              // ),
              Container(
                  width: 345,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Color(0xFF009638),
                    borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: TextButton(
                    child: const Text(
                      "GUARDAR VISITA",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: () async{
                      if(_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        // CONCATENAMOS LA FECHA Y HORA EN UN UNICO STRING
                        String fechayhora = "$fecha - $hora";
                        
                        // MODO AÑADIR VISITA
                        if(!modoEdicion.modoedicion){
                          // INSERCION MODO REMOTO
                          if(modoTrabajo.modoLocal){
                            // MODO SUPERVISOR (UN SUPERVISOR LE AÑADE EL MEDICAMENTO A UN USUARIO)
                            if(usuarioSupervisor.modosupervisor){
                              v = await v.createVisitaMedica(
                                usuarioIniciado.id,
                                usuarioSupervisor.nombre,
                                especialidad,
                                doctor,
                                lugar,
                                fechayhora
                              );
                            }
                            // MODO "NORMAL" (UN USUARIO/SUPERVISOR SE AÑADE SU PROPIO MEDICAMENTO)
                            else{
                              v = await v.createVisitaMedica(
                                usuarioSupervisor.supervisoriniciado ? usuarioSupervisor.id : usuarioIniciado.id,
                                usuarioSupervisor.supervisoriniciado ? usuarioSupervisor.nombre : usuarioIniciado.nombre,
                                especialidad,
                                doctor,
                                lugar,
                                fechayhora
                              );
                            }
                          }
                          // INSERCION MODO LOCAL
                          else{
                            // MODO SUPERVISOR (UN SUPERVISOR LE AÑADE EL MEDICAMENTO A UN USUARIO)
                            if(usuarioSupervisor.modosupervisor){
                              bdHelper.insertarBD("visitasmedicas", {
                                "id_usuario": usuarioIniciado.id,
                                "gestionadopor": usuarioSupervisor.nombre,
                                "especialidad": especialidad,
                                "doctor": doctor,
                                "lugar": lugar,
                                "fechayhora": fechayhora
                              });
                            }
                            // MODO "NORMAL" (UN USUARIO/SUPERVISOR SE AÑADE SU PROPIO MEDICAMENTO)
                            else{
                              bdHelper.insertarBD("visitasmedicas", {
                                "id_usuario": usuarioSupervisor.supervisoriniciado ? usuarioSupervisor.id : usuarioIniciado.id,
                                "gestionadopor": usuarioSupervisor.supervisoriniciado ? usuarioSupervisor.nombre : usuarioIniciado.nombre,
                                "especialidad": especialidad,
                                "doctor": doctor,
                                "lugar": lugar,
                                "fechayhora": fechayhora
                              });
                            }
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("VISITA MEDICA INSERTADA CORRECTAMENTE.")
                            )
                          );

                          // Navigator.pop(context);
                        }
                        // MODO MODIFICAR VISITA
                        else{
                          // MODIFICAR MODO REMOTO
                          if(modoTrabajo.modoLocal){
                            await v.updateVisitaMedica(
                              visitaMedicaSeleccionada.id,
                              // usuarioIniciado.id,
                              usuarioSupervisor.supervisoriniciado ? usuarioSupervisor.nombre : usuarioIniciado.nombre,
                              especialidad,
                              doctor,
                              lugar,
                              fechayhora
                            );
                          }
                          // MODIFICAR MODO LOCAL
                          else{
                            await bdHelper.actualizarBD("visitasmedicas", {
                              "id": visitaMedicaSeleccionada.id,
                              // "id_usuario": usuarioIniciado.id,
                              "gestionadopor": usuarioSupervisor.supervisoriniciado ? usuarioSupervisor.nombre : usuarioIniciado.nombre,
                              "especialidad": especialidad,
                              "doctor": doctor,
                              "lugar": lugar,
                              "fechayhora": fechayhora
                            });
                          }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("VISITA MEDICA MODIFICADA CORRECTAMENTE.")
                            )
                          );

                        }
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}