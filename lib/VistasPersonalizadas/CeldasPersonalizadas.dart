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
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      padding: EdgeInsets.all(8.0),
      itemCount: productos.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12.0), 
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  productos[index].nombre,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
                SizedBox(height: 8.0),
                Container(
                  height: 100.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(productos[index].imagen),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Precio: ${productos[index].precio}€',
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
