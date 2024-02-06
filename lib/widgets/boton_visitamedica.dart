import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BotonVisitaMedica extends StatelessWidget {
  final String especialidad;
  final String doctor;
  final String lugar;
  final String fechayhora;
  
  const BotonVisitaMedica({
    super.key,
    required this.especialidad,
    required this.doctor,
    required this.lugar,
    required this.fechayhora,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Text(
        "ESPECIALIDAD: $especialidad\nDOCTOR: $doctor\nLUGAR: $lugar\nFECHA Y HORA: $fechayhora",
        style: TextStyle(
          fontSize: 12
        ),
      ),
    );
  }
}