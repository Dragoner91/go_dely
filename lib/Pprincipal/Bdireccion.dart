import 'package:flutter/material.dart';

void _pressButton() {
    
  }


class BarraDireccion extends StatefulWidget {
  const BarraDireccion({super.key});

  @override
  State<BarraDireccion> createState() => _BarraDireccionState();
}

class _BarraDireccionState extends State<BarraDireccion> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 47,
          child: IconButton(
              onPressed: _pressButton, icon: Icon(Icons.menu)),
        ),
        Container(
          width: 220,
          child: Text(
            'Direccion',
            style: TextStyle(
              fontSize: 24.0,
            ),),
        ),
        Container(
          width: 40,
          child: IconButton(
              onPressed: _pressButton,
              icon: Icon(Icons.expand_more)),
        ),
        Container(
          width: 40,
          child: IconButton(
              onPressed: _pressButton,
              icon: Icon(Icons.notifications)),
        ),
        Container(
          width: 50,
          child: IconButton(
              onPressed: _pressButton,
              icon: Icon(Icons.shopping_cart)),
        ),
      ],);
  }
}
