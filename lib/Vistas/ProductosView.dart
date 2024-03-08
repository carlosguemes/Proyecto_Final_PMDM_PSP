import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_final_pmdm_psp/FbObjects/FbProducto.dart';
import 'package:proyecto_final_pmdm_psp/VistasPersonalizadas/SnackBarMensaje.dart';

import '../Singletone/DataHolder.dart';
import '../VistasPersonalizadas/TextEditingPersonalizado.dart';

class ProductosView extends StatefulWidget{
  @override
  State<ProductosView> createState() => _ProductosViewState();
}

class _ProductosViewState extends State<ProductosView> {
  bool cambioImagen = false;

  String idProducto = "";

  FbProducto _datosProducto =
  FbProducto(nombre: "nombre", precio: 0, imagen: "imagen");

  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController tecNombre = TextEditingController();

  TextEditingController tecPrecio = TextEditingController();

  ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");

  void onGalleryClicked() async{
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  }

  void onCameraClicked() async{
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image!=null){
      setState(() {
        _imagePreview=File(image.path);
        cambioImagen = true;
      });
    }
  }

  void guardaId() async{
    final CollectionReference productosCollection = FirebaseFirestore.instance.collection('Productos');

    try {
      // Realizar una consulta para obtener el documento con el nombre específico
      QuerySnapshot querySnapshot = await productosCollection.where('Nombre', isEqualTo: _datosProducto.nombre).limit(1).get();

      // Verificar si hay documentos que coincidan con el criterio de búsqueda
      if (querySnapshot.docs.isNotEmpty) {
        // Obtener el ID del primer documento que coincide
        idProducto = querySnapshot.docs.first.id;
      }

      else{
        print("No se encontro");
      }
    } catch (e) {
      print('Error al obtener el ID del producto: $e');
    }

  }

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

    tecNombre.text = _datosProducto.nombre;
    tecPrecio.text = _datosProducto.precio.toString();
  }

  void actualizarPost() async{

    final CollectionReference productosCollection = FirebaseFirestore.instance.collection('Productos');

    try {
      // Realizar una consulta para obtener el documento con el nombre específico
      QuerySnapshot querySnapshot = await productosCollection.where('Nombre', isEqualTo: _datosProducto.nombre).limit(1).get();

      // Verificar si hay documentos que coincidan con el criterio de búsqueda
      if (querySnapshot.docs.isNotEmpty) {
        // Obtener el ID del primer documento que coincide
        idProducto = querySnapshot.docs.first.id;

        FbProducto producto = FbProducto(nombre: _datosProducto.nombre, precio: _datosProducto.precio, imagen: _datosProducto.imagen);
        if (cambioImagen){
          final storageRef = FirebaseStorage.instance.ref();

          String rutaEnNube=
              FirebaseAuth.instance.currentUser!.uid+"/Imagenes/" +
                  DateTime.now().millisecondsSinceEpoch.toString();
          final rutaAFicheroEnNube = storageRef.child(rutaEnNube);
          final metadata = SettableMetadata(contentType: "image/jpeg");

          try{
            await rutaAFicheroEnNube.putFile(_imagePreview, metadata);
          } on FirebaseException catch (o){
            print("ERROR AL SUBIR LA IMAGEN: " + o.toString());
          }
          print("Se ha subido la imagen");
          String imgUrl = await rutaAFicheroEnNube.getDownloadURL();

          print("-----------------> texto: " + tecPrecio.text);

          try{
            producto = FbProducto(nombre: tecNombre.text,
                precio: int.parse(tecPrecio.text), imagen: imgUrl);
          } on Exception catch (e){
            SnackBarMensaje().muestraSnackBar(context, "No se ha podido guardar el producto. Ingrese bien todos los campos. El precio debe ser un número entero");
            Navigator.of(context).popAndPushNamed('/homeview');
          }
        }

        else{
          try{
            producto = FbProducto(nombre: tecNombre.text,
                precio: int.parse(tecPrecio.text), imagen: _datosProducto.imagen);
          } on Exception catch (e){
            SnackBarMensaje().muestraSnackBar(context, "No se ha podido guardar el producto. Ingrese bien todos los campos. El precio debe ser un número entero");
            Navigator.of(context).popAndPushNamed('/homeview');
          }

        }

        print("----------------------->ID: " + idProducto);
        await db.collection("Productos").doc(idProducto).update(producto.toFirestore());

        Navigator.of(context).popAndPushNamed('/homeview');
      }

      else{
        print("No se encontro");
      }
    } catch (e) {
      print('Error al obtener el ID del producto: $e');
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edita el producto')),
      body: Column(
        children: [
          TextEditingPersonalizado(controlador: tecNombre, texto: "Nombre del producto", contrasenya: false),
          TextEditingPersonalizado(controlador: tecPrecio, texto: "Precio del producto", contrasenya: false),
          if (!cambioImagen)
            Image.network(_datosProducto.imagen, width: 100, height: 100)

          else
            Image.file(_imagePreview, width: 100, height: 100),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: onGalleryClicked, child: Text("Galeria")),
              TextButton(onPressed: onCameraClicked, child: Text("Camara")),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: actualizarPost, child: Text("Guardar")),
            ],
          ),
        ],
      ),
    );
  }

}

