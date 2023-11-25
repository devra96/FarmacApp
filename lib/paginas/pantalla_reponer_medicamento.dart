import 'package:flutter/material.dart';

class PantallaReponerMedicamento extends StatefulWidget {
  const PantallaReponerMedicamento({super.key});

  @override
  State<PantallaReponerMedicamento> createState() => _PantallaReponerMedicamentoState();
}

class _PantallaReponerMedicamentoState extends State<PantallaReponerMedicamento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // #################### APPBAR ####################
      appBar: AppBar(
        title: Text("REPONER MEDICAMENTOS"),
      ),
      // ####################  BODY  ####################
      body: Center(
        child: Text(
          "No hay medicamentos a reponer. Se indicara en esta pagina los medicamentos a reponer cuando se vayan a agotar sus dosis.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22
          ),
        )
      )
    );
  }
}