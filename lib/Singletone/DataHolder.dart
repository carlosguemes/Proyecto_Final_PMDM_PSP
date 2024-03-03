import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_final_pmdm_psp/FbObjects/FbProducto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataHolder{
  FbProducto? productoGuardado;

  static final DataHolder _dataHolder = new DataHolder._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;

  factory DataHolder(){
    return _dataHolder;
  }

  DataHolder._internal(){
    initCachedFbProducto();
  }

  void saveSelectedProductoInCache() async{
    if (productoGuardado!=null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('titulo', productoGuardado!.nombre);
      prefs.setDouble('precio', productoGuardado!.precio);
      prefs.setString('cuerpo', productoGuardado!.imagen);
    }
  }



  Future<FbProducto?> initCachedFbProducto() async{
    if (productoGuardado!=null) return productoGuardado;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? nombre = prefs.getString('nombre');
    nombre??="";

    double? precio = prefs.getDouble('precio');
    precio??=0;

    String? imagen = prefs.getString('imagen');
    imagen??="";

    productoGuardado=FbProducto(nombre: nombre, precio: precio, imagen: imagen);

    return productoGuardado;
  }
}