import 'package:flutter/material.dart';

import 'Vistas/HomeView.dart';
import 'Vistas/LoginView.dart';
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
      },
      initialRoute: '/loginview',
    );
  }

}