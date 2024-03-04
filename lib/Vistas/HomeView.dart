import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FbObjects/FbProducto.dart';
import '../Singletone/DataHolder.dart';
import '../VistasPersonalizadas/CeldasPersonalizadas.dart';
import '../VistasPersonalizadas/DrawerPersonalizado.dart';
import 'LoginView.dart';
import 'MapaView.dart';
import 'RegisterView.dart';

class HomeView extends StatefulWidget{
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbProducto> productos = [];

  void descargarProductos() async{
    CollectionReference<FbProducto> reference = db
        .collection("Productos")
        .withConverter(fromFirestore: FbProducto.fromFirestore,
        toFirestore: (FbProducto post, _) => post.toFirestore());

    QuerySnapshot<FbProducto> querySnap = await reference.get();
    for (int i = 0; i < querySnap.docs.length; i++){
      setState(() {
        productos.add(querySnap.docs[i].data());
      });

    }
  }

  bool esLista = false;
  void onBottomMenuPressed(int indice) {
    setState(() {
      if (indice == 0){
        esLista = true;
        print('object');
      }
      else if (indice == 1){
        esLista = false;
      }
    });
  }

  void eventoDrawerPersonalizado(int indice){
    if (indice == 0){
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil (
        MaterialPageRoute (builder: (BuildContext context) => LoginView()),
        ModalRoute.withName('/loginview'),
      );
    }

    else if (indice == 1){
      Navigator.of(context).pushAndRemoveUntil (
        MaterialPageRoute (builder: (BuildContext context) => MapaView()),
        ModalRoute.withName('/mapaview'),
      );
    }
  }

  void onItemListaClicked(int index){
    DataHolder().productoGuardado = productos[index];
    DataHolder().saveSelectedProductoInCache();
    Navigator.of(context).pushNamed('/productosview');
  }

  Widget creadorCeldas(BuildContext context, int index){
    return CeldasPersonalizadas(
      productos: productos,
      iPosicion: index,
      onItemListaClickedFunction: onItemListaClicked,
    );
  }

  Widget vistaProductos(){
    return creadorCeldas(context, productos.length);
  }

  @override
  void initState() {
    descargarProductos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajustes")),
      body: (
          Center(child: vistaProductos())
      ),
      drawer: DrawerPersonalizado(onItemTap: eventoDrawerPersonalizado),

      floatingActionButton:FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/productocreateview");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}