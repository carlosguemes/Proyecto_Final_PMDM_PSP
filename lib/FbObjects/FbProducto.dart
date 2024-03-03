import 'package:cloud_firestore/cloud_firestore.dart';

class FbProducto{

  final String nombre;
  final double precio;
  final String imagen;

  FbProducto({
    required this.nombre,
    required this.precio,
    required this.imagen
  });

  factory FbProducto.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbProducto(
        nombre: data?['Nombre'],
        precio: data?['Precio'],
        imagen: data?['Imagen']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "Nombre": nombre,
      if (precio != null) "Precio": precio,
      if (imagen != null) "Imagen": imagen
    };
  }

}