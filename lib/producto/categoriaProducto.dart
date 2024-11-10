import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_dely/producto/productoSimple.dart';
import 'package:go_dely/producto/carta_producto.dart';

void _pressButton() {}
List<ProductoSimple> productos1 = [
  ProductoSimple('producto1', 19.0, 'assets/combo2.jpg'),
  ProductoSimple('producto2', 18.0, 'assets/combo_belleza.png'),
  ProductoSimple('producto3', 15.0, 'assets/combo_carros.png'),
  ProductoSimple('producto4', 19.0, 'assets/combo1.jpg'),
  ProductoSimple('producto5', 18.0, 'assets/combo_fiesta.png'),
  ProductoSimple('producto6', 15.0, 'assets/combo_nestle.png')
];

Widget categoriaProducto(String categoria) {
  return Column(children: [
    Row(
      children: [
  
         Text(categoria,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              )),
        
        TextButton(
              onPressed: _pressButton,
              child: const Text('Ver todo',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Color.fromARGB(242, 5, 175, 11),
                  ))),
        
      ],
    ),
    //Row(children: productos1.map((ProductoSimple) => cartaProducto(ProductoSimple)).toList()),
    
    Container(
      
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:productos1.map((ProductoSimple) => cartaProducto(ProductoSimple)).toList()
      ),
      //Row(children: productos1.map((ProductoSimple) => cartaProducto(ProductoSimple)).toList()),
      constraints:BoxConstraints.loose(Size(1300, 245.0)),
      
    )
    
  ]);
}
