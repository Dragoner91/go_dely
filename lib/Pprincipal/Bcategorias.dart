import 'package:flutter/material.dart';

  /*

  void _pressButton() {
    
  }*/



  String categoriaActual = 'Todo';
Widget botonProducto(String categoria){
  return Botonproducto(categoria: categoria);
}
/*
 Widget botonProducto(String categoria){
  if (categoriaActual == categoria){
    return TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                          WidgetStateProperty.all<Color>(const Color.fromARGB(242, 5, 175, 11)),
                        foregroundColor: 
                          WidgetStateProperty.all<Color>(const Color.fromARGB(241, 255, 255, 255)),  
                                                  
                      ),
                      
                      onPressed: (){

                        categoriaActual = categoria;
                      },
                      child: Text(categoria,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                    ),
                    ));
  }
  else {
    return TextButton(
                      onPressed: (){
                        setState((){

                        });
                      },
                      child: Text(categoria,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                                        ),
                                        ));
  }
 }


 */
class Botonproducto extends StatefulWidget {
  final String categoria ;
  const Botonproducto({super.key, required this.categoria});


  @override
  State<Botonproducto> createState() => _BotonproductoState();
}

class _BotonproductoState extends State<Botonproducto> {


  @override
  Widget build(BuildContext context) {
    if (categoriaActual == widget.categoria){
      return TextButton(
          style: ButtonStyle(
            backgroundColor:
            WidgetStateProperty.all<Color>(const Color.fromARGB(242, 5, 175, 11)),
            foregroundColor:
            WidgetStateProperty.all<Color>(const Color.fromARGB(241, 255, 255, 255)),

          ),

          onPressed: (){
            setState((){
              categoriaActual = widget.categoria;
            });
          },
          child: Text(widget.categoria,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ));
    }
    else {
      return TextButton(
          onPressed: (){
            setState((){
              categoriaActual = widget.categoria;
            });
          },
          child: Text(widget.categoria,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ));
    }
  }
}




class BarraCategorias extends StatefulWidget {
  const BarraCategorias({super.key});

  @override
  State<BarraCategorias> createState() => _BarraCategoriasState();
}

class _BarraCategoriasState extends State<BarraCategorias> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 500,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          botonProducto('Todo'),

          botonProducto('Comida'),

          botonProducto('Medicina'),

          botonProducto('Belleza'),

          botonProducto('Carros'),

          botonProducto('Utiles'),

          botonProducto('Mascotas'),

          botonProducto('Limpieza'),

          botonProducto('Herramientas'),

          botonProducto('Hogar'),

        ],
      ),
    );
  }
}
