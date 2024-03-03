import 'package:flutter/material.dart';
import '../FbObjects/FbProducto.dart';

class CeldasPersonalizadas extends StatelessWidget {
  final List<FbProducto> productos;
  final int iPosicion;
  final Function(int indice)? onItemListaClickedFunction;

  const CeldasPersonalizadas({
    Key? key,
    required this.productos,
    required this.iPosicion,
    required this.onItemListaClickedFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Puedes ajustar el número de elementos en cada fila según tus necesidades
        mainAxisSpacing: 8.0, // Espaciado entre filas
        crossAxisSpacing: 8.0, // Espaciado entre columnas
      ),
      padding: EdgeInsets.all(8.0), // Padding alrededor de la cuadrícula
      itemCount: productos.length, // Número total de elementos
      itemBuilder: (context, index) {
        return InkWell(
          child: Container(
            color: Colors.blue, // Color de los elementos de la cuadrícula
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  productos[index].nombre,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
                SizedBox(height: 8.0), // Agrega espacio entre el texto y la imagen
                Container(
                  height: 100.0, // Establece la altura según tus necesidades
                  width: double.infinity, // Asegúrate de que la imagen ocupe todo el ancho disponible
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(productos[index].imagen), // Reemplaza con la URL real de la imagen
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.0), // Agrega espacio entre la imagen y el precio
                Text(
                  'Precio: ${productos[index].precio}€', // Asumiendo que 'precio' es un double o int
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ],
            ),
          ),
          onTap: () {
            onItemListaClickedFunction!(index);
          },
        );
      },
    );
  }

}
