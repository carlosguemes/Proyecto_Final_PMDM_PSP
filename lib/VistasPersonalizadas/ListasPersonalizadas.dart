
import 'package:flutter/material.dart';

class ListasPersonalizadas extends StatelessWidget {

  final String sText;
  final double dFontSize;
  final MaterialColor mcColores;
  final int iPosicion;
  final Function (int indice)? onItemListaClickedFunction;
  final String imagen;

  const ListasPersonalizadas({super.key,
    required this.sText,
    required this.dFontSize,
    required this.mcColores,
    required this.iPosicion,
    required this.onItemListaClickedFunction,
    required this.imagen
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Container(
          color: mcColores,
          child: Row(
            children: [
              Image.network(imagen,
                  width: 100,
                  height: 100),
              Text(sText, style: TextStyle(fontSize: dFontSize)),
              TextButton(onPressed: null,
                  child: Text("+", style: TextStyle(fontSize: dFontSize)))
            ],
          )
      ),
      onTap: () {
        onItemListaClickedFunction!(iPosicion);
      },
    );

  }
}