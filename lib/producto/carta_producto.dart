import 'package:flutter/material.dart';


void _pressButton() {
    
  }

Widget cartaProducto(ProductoSimple){
  return Card(
    margin: const EdgeInsets.all(5.0),
    child: Column(children: [
      const IconButton(
        onPressed: _pressButton,
        icon: Icon(Icons.add),
        ),
        Image.asset(ProductoSimple.imagen, width: 120, height: 120),
        Text(ProductoSimple.name),
        Text('${ProductoSimple.precio} USD')
    ]     
     ),   
  );
}