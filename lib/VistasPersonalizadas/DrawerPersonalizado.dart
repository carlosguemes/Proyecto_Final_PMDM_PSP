import 'package:flutter/material.dart';

class DrawerPersonalizado extends StatelessWidget{

  Function (int indice)? onItemTap;
  DrawerPersonalizado({Key? key, required this.onItemTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
                style: TextStyle(color: Colors.white),
                'Ajustes'
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
            leading: Icon(Icons.ad_units),
            title: const Text('Registrarse'),
            onTap: () {
              onItemTap!(1);
            },
          ),
        ],
      ),
    );
  }

}