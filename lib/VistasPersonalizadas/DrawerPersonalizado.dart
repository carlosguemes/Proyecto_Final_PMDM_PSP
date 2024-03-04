import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerPersonalizado extends StatelessWidget{

  Function (int indice)? onItemTap;
  String nombreUsuario;
  DrawerPersonalizado({Key? key,
    required this.onItemTap,
    required this.nombreUsuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
                style: TextStyle(color: Colors.white),
                'Bienvenido ' + nombreUsuario
            ),
          ),
          ListTile(
            leading: Icon(Icons.arrow_back_outlined),
            selectedColor: Colors.blue,
            selected: true,
            title: const Text('Cerrar sesión'),
            onTap: () {
              onItemTap!(0);
            },
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: const Text('Mapa'),
            onTap: () {
              onItemTap!(1);
            },
          ),
        ],
      ),
    );
  }
}