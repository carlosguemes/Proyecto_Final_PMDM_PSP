import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../FbObjects/FbProducto.dart';
import '../FbObjects/FbUsuario.dart';
import '../Singletone/DataHolder.dart';
import '../VistasPersonalizadas/CeldasPersonalizadas.dart';
import '../VistasPersonalizadas/DrawerPersonalizado.dart';
import '../VistasPersonalizadas/ListasPersonalizadas.dart';
import '../VistasPersonalizadas/MenuBottom.dart';
import 'LoginView.dart';
import 'MapaView.dart';

class HomeView extends StatefulWidget{
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbProducto> productos = [];
  FbUsuario usuario = FbUsuario(nombre: "", edad: 0);

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

  void descargarUsuario() async{
    String uidUsuario = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<FbUsuario> reference = db
        .collection("Usuarios")
        .doc(uidUsuario)
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
        toFirestore: (FbUsuario usuario, _) => usuario.toFirestore());

    DocumentSnapshot<FbUsuario> docSnap = await reference.get();
    usuario = docSnap.data()!;
  }

  bool esLista = false;
  void onBottomMenuPressed(int indice) {
    setState(() {
      if (indice == 0){
        esLista = true;
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

  Widget? creadorDeItemLista(BuildContext context, int index){
    return ListasPersonalizadas(sText: productos[index].nombre,
      dFontSize: 20,
      mcColores: Colors.blue,
      iPosicion: index,
      onItemListaClickedFunction: onItemListaClicked,
      imagen: productos[index].imagen,
    );
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index){
    return Divider(color: Colors.orange);
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

  Widget celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: productos.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      );
    } else {
      return creadorCeldas(context, productos.length);
    }
  }

  @override
  void initState() {
    super.initState();
    descargarUsuario();
    descargarProductos();
  }

  Future <void> pedirTemperatura() async{
    try {
      double temperatura = await DataHolder().admin.pedirTemperaturasEn(40.422767815469285, -3.528639686059464);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Información'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('La temperatura actual en San Fernando es de: $temperatura ºC'),

              ],
            ),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error al obtener la temperatura'),
            actions: [
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Ajustes"),
      actions: [
        PopupMenuButton(
          onSelected: (indice) {
            switch (indice) {
              case 'apiTiempo':
                pedirTemperatura();
                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: 'apiTiempo',
              child: ListTile(
                leading: Icon(Icons.sunny_snowing),
                title: Text('Temperatura'),
              ),
            ),
          ],
        ),
      ],
      ),
      body: (
          Center(child: celdasOLista(esLista))
      ),

      bottomNavigationBar: MenuBottom(events: onBottomMenuPressed),

      drawer: DrawerPersonalizado(onItemTap: eventoDrawerPersonalizado,
      nombreUsuario: usuario.nombre,),

      floatingActionButton:FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/productocreateview");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}