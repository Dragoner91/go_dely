import 'package:flutter/material.dart';

void _pressButton() {
    
  }

Widget barraBusqueda(){
  return Row(children: [
              Expanded(
                flex: 1,
                child: IconButton(
                        onPressed: _pressButton,
                        icon: const Icon(Icons.search)
                        ),
              ),
                      Expanded(
                        flex: 19,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0.0,5.0,50.0,10.0),
                          child: const TextField(
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Busca  categoria o producto',
                                            ),
                                          ),
                        ),
                      ),
            ],);


}