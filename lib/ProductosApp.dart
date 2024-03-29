import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_final_pmdm_psp/Vistas/CrearProductosView.dart';
import 'package:proyecto_final_pmdm_psp/Vistas/PerfilView.dart';

import 'OnBoarding/SplashView.dart';
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
      theme:ThemeData(
        textTheme: GoogleFonts.offsideTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/registerview': (context) => RegisterView(),
        '/homeview': (context) => HomeView(),
        '/loginview': (context) => LoginView(),
        '/productosview': (context) => ProductosView(),
        '/mapaview': (context) => MapaView(),
        '/perfilview': (context) => PerfilView(),
        '/productocreateview': (context) => CrearProductosView(),
        '/splashview': (context) => SplashView()
      },
      initialRoute: '/splashview',
    );
  }

}