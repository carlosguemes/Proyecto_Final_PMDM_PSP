import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../VistasPersonalizadas/TextEditingPersonalizado.dart';

class LoginView extends StatelessWidget{

  late BuildContext _context;

  TextEditingController correoUsuarioController = TextEditingController();
  TextEditingController contrasenyaUsuarioController = TextEditingController();

  void botonAceptar() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: correoUsuarioController.text,
        password: contrasenyaUsuarioController.text,
      );
      Navigator.of(_context).popAndPushNamed('/homeview');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void botonRegistro() {
    Navigator.of(_context).popAndPushNamed('/registerview');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Login'),
      ),

      body: Column(children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Text('Loguéate con tu usuario', style: TextStyle(fontSize: 25)),
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


        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: TextButton(onPressed: botonAceptar,
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: Text("Aceptar")),),

          Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: TextButton(onPressed: botonRegistro,
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: Text("Registro")),)
        ],)
      ]),
    );
  }

}