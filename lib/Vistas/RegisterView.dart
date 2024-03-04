
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../VistasPersonalizadas/SnackBarMensaje.dart';
import '../VistasPersonalizadas/TextEditingPersonalizado.dart';

class RegisterView extends StatelessWidget{
  TextEditingController correoUsuarioController = TextEditingController();
  TextEditingController contrasenyaUsuarioController = TextEditingController();
  TextEditingController repiteContrasenyaUsuarioController = TextEditingController();

  late BuildContext _context;

  void botonAceptar() async{
    if (contrasenyaUsuarioController.text != repiteContrasenyaUsuarioController.text){
      SnackBarMensaje().muestraSnackBar(_context, "Las contraseñas no coinciden");
    }

    else{
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: correoUsuarioController.text,
          password: contrasenyaUsuarioController.text,
        );
        Navigator.of(_context).popAndPushNamed('/loginview');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          SnackBarMensaje().muestraSnackBar(_context, "La contraseña es demasiado débil");
        } else if (e.code == 'email-already-in-use') {
          SnackBarMensaje().muestraSnackBar(_context, "El email ya está registrado");
        }
      } catch (e) {
        SnackBarMensaje().muestraSnackBar(_context, "No se ha podido conectar con la base de datos");
      }
    }
  }

  void botonCancelar(){
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        title: const Text('Registro'),
      ),

      body: Column(children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Text('Identifíquese como nuevo usuario', style: TextStyle(fontSize: 25)),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),

        TextEditingPersonalizado(
            controlador: correoUsuarioController,
            texto: 'Introduce tu correo',
            contrasenya: false
        ),

        TextEditingPersonalizado(
            controlador: contrasenyaUsuarioController,
            texto: 'Introduce tu contraseña',
            contrasenya: true
        ),

        TextEditingPersonalizado(
            controlador: repiteContrasenyaUsuarioController,
            texto: 'Repite tu contraseña',
            contrasenya: true
        ),

        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: TextButton(onPressed: botonAceptar,
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: Text("Aceptar")),),

          Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: TextButton(onPressed: botonCancelar,
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: Text("Cancelar")),)
        ],)
      ]),
    );
  }

}