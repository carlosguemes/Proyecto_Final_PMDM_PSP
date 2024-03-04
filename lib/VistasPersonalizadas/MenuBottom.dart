import 'package:flutter/material.dart';

class MenuBottom extends StatelessWidget {
  Function (int indice)? events;
  MenuBottom({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => events!(0), child: Icon(Icons.list,color: Colors.pink,)),
          TextButton(onPressed: () => events!(1), child: Icon(Icons.grid_view,color: Colors.pink,)),
        ]
    );
  }
}