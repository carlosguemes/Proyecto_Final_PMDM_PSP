import 'package:flutter/material.dart';

class TextEditingPersonalizado extends StatelessWidget {
  static const double paddingVertical = 10;
  static const double paddingFraction = 0.30;

  TextEditingController controlador;
  String texto;
  bool contrasenya;

  TextEditingPersonalizado({
    required this.controlador,
    required this.texto,
    required this.contrasenya,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tamanyoHorizontal = screenWidth * paddingFraction;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: tamanyoHorizontal,
        vertical: paddingVertical,
      ),
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: TextFormField(
          controller: controlador,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: texto,
            fillColor: Colors.white,
            filled: true,
          ),
          obscureText: contrasenya,
        ),
      ),
    );
  }
}
