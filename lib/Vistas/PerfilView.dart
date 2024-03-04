import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FbObjects/FbUsuario.dart';

class PerfilView extends StatelessWidget{

  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecEdad = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  void onClickAceptar() async{

    FbUsuario usuario = FbUsuario(nombre: tecUsername.text,
        edad: int.parse(tecEdad.text));

    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;

    await db.collection("Usuarios").doc(uidUsuario).set(usuario.toFirestore());

    Navigator.of(_context).popAndPushNamed('/homeview');
  }

  void onClickCancelar(){
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        centerTitle: true,
        shadowColor: Colors.blue,
        backgroundColor: Colors.black26,
      ),

      body: Column(children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Text("Personaliza tu perfil", style: TextStyle(fontSize: 25)),
        Padding(
          padding:EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 16),
          child: Flexible (child: SizedBox(width: 400, child: TextField(
            controller: tecUsername,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              //hintText: 'Nombre',
              labelText: 'Nombre',
            ),
          ),
          ),
          ),
        ),

        Padding(
          padding:EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 0),
          child: Flexible(
              child: SizedBox(width: 400,
                child: TextFormField(
                  controller: tecEdad,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    //hintText: 'Input Password',
                    labelText: 'Edad',
                  ),
                ),
              )
          ),
        ),

        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: TextButton(onPressed: onClickAceptar,
                child: Text("Aceptar")),),

          Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: TextButton(onPressed: onClickCancelar,
                child: Text("Cancelar")),)
        ],)

      ],),

    );


  }

}