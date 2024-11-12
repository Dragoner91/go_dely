/*import 'package:flutter/material.dart';

class Botonproducto extends StatefulWidget {
  final String categoria ;
  const Botonproducto({super.key, required this.categoria});


  @override
  State<Botonproducto> createState() => _BotonproductoState();
}

class _BotonproductoState extends State<Botonproducto> {
  //String categoria ='';

  //_BotonproductoState(this.categoria)

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

*/

