import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FbObjects/FbUsuario.dart';
import '../VistasPersonalizadas/TextEditingPersonalizado.dart';

class LoginView extends StatelessWidget{

  late BuildContext _context;

  TextEditingController correoUsuarioController = TextEditingController();
  TextEditingController contrasenyaUsuarioController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  void botonAceptar() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: correoUsuarioController.text,
        password: contrasenyaUsuarioController.text,
      );

      String uidUsuario = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference<FbUsuario> reference = db
          .collection("Usuarios")
          .doc(uidUsuario)
          .withConverter(fromFirestore: FbUsuario.fromFirestore,
          toFirestore: (FbUsuario usuario, _) => usuario.toFirestore());

      DocumentSnapshot<FbUsuario> docSnap = await reference.get();
      if (docSnap.exists) {
        FbUsuario usuario = docSnap.data()!;
        if (usuario != null) {
          print("Nombre del usuario: " + usuario.nombre);
          print("Edad del usuario: " + usuario.edad.toString());
          Navigator.of(_context).popAndPushNamed("/homeview");
        }
      }

      else{
        Navigator.of(_context).popAndPushNamed('/perfilview');
      }

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