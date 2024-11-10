import 'package:flutter/material.dart';

  /*void _pressButton1(String categoriaBoton) {
    categoriaActual = categoriaBoton;
  }*/
  
  void _pressButton() {
    
  }

  int selector = 1;
  String categoriaActual = 'Todo';


 Widget botonProducto(String categoria){
  //String categoriaBoton = categoria;
  if (categoriaActual == categoria){
    return TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                          WidgetStateProperty.all<Color>(const Color.fromARGB(242, 5, 175, 11)),
                        foregroundColor: 
                          WidgetStateProperty.all<Color>(const Color.fromARGB(241, 255, 255, 255)),  
                                                  
                      ),
                      onPressed: _pressButton,
                      child: Text(categoria,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                    ),
                    ));
  }
  else {
    return TextButton(
                      onPressed: _pressButton,
                      child: Text(categoria,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                                        ),
                                        ));
  }
 }

Widget barraCategorias(){
  return  Row(
        
        children:[
                Expanded(
                  child:botonProducto('Todo')

                ),

                    
            
                    Expanded(
                      child: botonProducto('Comida')
                      
                    ),
                                           

                    Expanded(
                      child: botonProducto('Medicina')
                    ),


                    Expanded(
                      child: botonProducto('Belleza')
                    ),
              ],
            );
}