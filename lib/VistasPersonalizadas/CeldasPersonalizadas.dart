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
        crossAxisCount: 4, // number of items in each row
        mainAxisSpacing: 8.0, // spacing between rows
        crossAxisSpacing: 8.0, // spacing between columns
      ),
      padding: EdgeInsets.all(8.0), // padding around the grid
      itemCount: productos.length, // total number of items
      itemBuilder: (context, index) {
        return InkWell(
          child: Container(
            color: Colors.blue, // color of grid items
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  productos[index].nombre,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
                SizedBox(height: 8.0), // Add some space between text and image
                Container(
                  height: 220.0, // Set the height as needed
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(productos[index].imagen), // Replace with the actual image URL
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.0), // Add some space between image and price
                Text(
                  'Precio: ${productos[index].precio}\€', // Assuming precio is a double or int
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
