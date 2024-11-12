import 'package:flutter/material.dart';

void _pressButton() {}


class barraBusqueda extends StatefulWidget {
  const barraBusqueda({super.key});

  @override
  State<barraBusqueda> createState() => _barraBusquedaState();
}

class _barraBusquedaState extends State<barraBusqueda> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
    Container(
      width: 50,
      child: IconButton(onPressed: _pressButton, icon: Icon(Icons.search)),
    ),
    Container(
      width: 340,
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Busca  categoria o producto',
        ),
      ),
    ),
  ]);;
  }
}
