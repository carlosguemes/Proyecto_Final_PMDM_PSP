import 'package:flutter/material.dart';

class SnackBarMensaje{

  void muestraSnackBar(BuildContext context, String mensaje){
    ScaffoldMessenger.of(context).showSnackBar
      (SnackBar(content: Text(mensaje)));
  }

}