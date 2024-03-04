import 'package:cloud_firestore/cloud_firestore.dart';

class FbUsuario{

  final String nombre;
  final int edad;

  FbUsuario({
    required this.nombre,
    required this.edad,
  });

  factory FbUsuario.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbUsuario(
        nombre: data?['Nombre'],
        edad: data?['Edad'] != null ? data!['Edad'] : 0,
        );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (nombre != null) "Nombre": nombre,
      if (edad != null) "Edad": edad,
    };
  }

}