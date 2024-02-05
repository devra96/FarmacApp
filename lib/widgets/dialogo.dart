import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Dialogo extends StatelessWidget {
  final String texto;
  
  const Dialogo({
    super.key,
    required this.texto
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        texto,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14
        )
      ),
      actions: <TextButton>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Center(child: Text('Aceptar')),
        )
      ],
    );
  }
}