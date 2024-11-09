import 'package:flutter/material.dart';

void _pressButton() {
    
  }

Widget barraCategorias(){
  return Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                          WidgetStateProperty.all<Color>(const Color.fromARGB(242, 5, 175, 11)),
                        foregroundColor: 
                          WidgetStateProperty.all<Color>(const Color.fromARGB(241, 255, 255, 255)),  
                                                  
                      ),
                      onPressed: _pressButton,
                      child: const Text('Todo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                    ),
                    )),
                ),
                    Expanded(
                      child: TextButton(
                      onPressed: _pressButton,
                      child: const Text('Comida',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                                        ),
                                        )),
                    ),
                    Expanded(
                      child: TextButton(
                      onPressed: _pressButton,
                      child: const Text('Medicina',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,  
                        fontSize: 24.0,
                                        ),
                                        )),
                    ),
                    Expanded(
                      child: TextButton(
                      onPressed: _pressButton,
                      child: const Text('Belleza',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                                        ),
                                        )),
                    ),
              ],
            );
}