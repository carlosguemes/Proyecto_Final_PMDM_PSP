import 'package:flutter/material.dart';
import 'package:proyecto_final_pmdm_psp/FbObjects/FbProducto.dart';

import '../Singletone/DataHolder.dart';

class ProductosView extends StatefulWidget{
  @override
  State<ProductosView> createState() => _ProductosViewState();
}

class _ProductosViewState extends State<ProductosView> {
  FbProducto _datosProducto =
  FbProducto(nombre: "nombre", precio: 0, imagen: "imagen");

  @override
  void initState() {
    super.initState();
    cargarProductoGuardadoEnCache();
  }

  void cargarProductoGuardadoEnCache() async{
    var temp1 = await DataHolder().initCachedFbProducto();

    setState(() {
      _datosProducto = temp1!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Producto")),
      body: Column(
        children: [
          Text(_datosProducto.nombre),
          Image.network(_datosProducto.imagen, width: 100, height: 100),
          Text(_datosProducto.precio.toString()),
        ],

      ),
    );
  }
}

