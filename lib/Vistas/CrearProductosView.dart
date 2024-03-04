import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_final_pmdm_psp/VistasPersonalizadas/SnackBarMensaje.dart';
import 'package:proyecto_final_pmdm_psp/VistasPersonalizadas/TextEditingPersonalizado.dart';

import '../FbObjects/FbProducto.dart';
import '../Singletone/DataHolder.dart';

class CrearProductosView extends StatefulWidget{
  @override
  State<CrearProductosView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<CrearProductosView> {
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
      });
    }
  }

  void subirProducto() async{
    final storageRef = FirebaseStorage.instance.ref();

    String rutaEnNube=
        FirebaseAuth.instance.currentUser!.uid+"/Imagenes/" +
        DateTime.now().millisecondsSinceEpoch.toString();
    final rutaAFicheroEnNube = storageRef.child(rutaEnNube);
    final metadata = SettableMetadata(contentType: "image/jpeg");

    //------------INICIO DE SUBIR IMAGEN--------------//

    if (tecNombre.text == "" || tecPrecio.text == "" || _imagePreview.path == ""){
      SnackBarMensaje().muestraSnackBar(context, "Debe introducir todos los campos y subir una imagen");
      print(_imagePreview.path);
    }
    else{
      try{
        await rutaAFicheroEnNube.putFile(_imagePreview, metadata);
      } on FirebaseException catch (o){
        print("ERROR AL SUBIR LA IMAGEN: " + o.toString());
      }
      print("Se ha subido la imagen");


      String imgUrl = await rutaAFicheroEnNube.getDownloadURL();

      print("Se ha subido la imagen " + imgUrl);

    //------------FIN DE SUBIR IMAGEN--------------//

    //------------INICIO DE SUBIR POST--------------//


      FbProducto productoNuevo = new FbProducto(
          nombre: tecNombre.text,
          precio: int.parse(tecPrecio.text),
          imagen: imgUrl
      );

      DataHolder().crearProductoEnFirebase(productoNuevo);

      //------------FIN DE SUBIR POST--------------//

      Navigator.of(context).pushNamed('/homeview');
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(title: Text('Crear nuevo producto')),
      body: Column(
        children: [
          TextEditingPersonalizado(controlador: tecNombre, texto: "Escribe el nombre", contrasenya: false),
          TextEditingPersonalizado(controlador: tecPrecio, texto: "Escribe el precio", contrasenya: false),
          if (_imagePreview.path != "")
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
              TextButton(onPressed: subirProducto, child: Text("Guardar")),
            ],
          ),
        ],
      ),
    );
  }

}