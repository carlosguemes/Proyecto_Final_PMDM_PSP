import 'package:flutter/material.dart';
import 'package:proyecto_final_pmdm_psp/Vistas/CrearProductosView.dart';
import 'package:proyecto_final_pmdm_psp/Vistas/PerfilView.dart';

import 'Vistas/HomeView.dart';
import 'Vistas/LoginView.dart';
import 'Vistas/MapaView.dart';
import 'Vistas/ProductosView.dart';
import 'Vistas/RegisterView.dart';

class ProductosApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/registerview': (context) => RegisterView(),
        '/homeview': (context) => HomeView(),
        '/loginview': (context) => LoginView(),
        '/productosview': (context) => ProductosView(),
        '/mapaview': (context) => MapaView(),
        '/perfilview': (context) => PerfilView(),
        '/productocreateview': (context) => CrearProductosView(),
      },
      initialRoute: '/homeview',
    );
  }

}