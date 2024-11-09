import 'package:flutter/material.dart';

void _pressButton() {
    
  }

Widget barraDireccion(){
  return const Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: _pressButton, icon: Icon(Icons.menu)),
                ),
                Expanded(
                  flex: 7,
                  child: Text(
                    'Direccion',
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: _pressButton,
                      icon: Icon(Icons.expand_more)),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: _pressButton,
                      icon: Icon(Icons.notifications)),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: _pressButton,
                      icon: Icon(Icons.shopping_cart)),
                ),
              ],
            );
}