import 'package:flutter/material.dart';

class BotonMedicamento extends StatelessWidget {
  final String nombre;
  final String ultimaDosis;
  final String proximaDosis;
  
  const BotonMedicamento({
    super.key,
    required this.nombre,
    required this.ultimaDosis,
    required this.proximaDosis,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Text(
        "$nombre\nUltima dosis: $ultimaDosis\nProxima dosis: $proximaDosis",
        style: TextStyle(
          fontSize: 16
        ),
      ),
    );
  }
}