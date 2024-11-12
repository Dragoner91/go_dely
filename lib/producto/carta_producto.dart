import 'package:flutter/material.dart';



void _pressButton() {
    
  }

Widget cartaProducto(ProductoSimple){
  return CartaProducto(ProductoSimple: ProductoSimple,

  );
}

class CartaProducto extends StatefulWidget {
  final ProductoSimple;
  const CartaProducto({super.key,required this.ProductoSimple});

  @override
  State<CartaProducto> createState() => _CartaProductoState();
}

class _CartaProductoState extends State<CartaProducto> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5.0),
      child: Column(children: [
        const IconButton(
          onPressed: _pressButton,
          icon: Icon(Icons.add),
        ),
        Image.asset(widget.ProductoSimple.imagen, width: 120, height: 120),
        Text(widget.ProductoSimple.name),
        Text('${widget.ProductoSimple.precio} USD')
      ]
      ),
    );
  }
}
