import 'package:flutter/material.dart';
import 'package:go_dely/producto/productoSimple.dart';
import 'package:go_dely/producto/carta_producto.dart';
void _pressButton() {
    
  }
  List<ProductoSimple> productos1 = [ProductoSimple('producto1',19.0,'assets/combo2.jpg'),
ProductoSimple('producto2',18.0,'assets/combo_belleza.png'),
ProductoSimple('producto3',15.0,'assets/combo_carros.png'),
ProductoSimple('producto4',31.0,'assets/combo_vitaminas.png'),
ProductoSimple('producto5',29.0,'assets/combo_polar.png'),
];


Widget categoriaProducto(String categoria){
  return Column(
    children:[Row(children: [
                Expanded(
                  flex: 3,
                  child: Text(categoria,
                  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,)
                        ),
                ),
                Expanded(
                  flex: 2,
                  child: TextButton(
                        onPressed: _pressButton,
                        child: const Text('Ver todo',
                        style: TextStyle(
                        fontSize: 24.0,
                        color: Color.fromARGB(242, 5, 175, 11),
                        )
                        )),
                ),
              ],),
              Row(children: productos1.map((ProductoSimple) => cartaProducto(ProductoSimple)).toList()),
              ] 
  )
            ;
}