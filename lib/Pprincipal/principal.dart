import 'package:flutter/material.dart';
import 'package:go_dely/Pprincipal/Bbusqueda.dart';
import 'package:go_dely/Pprincipal/Bcategorias.dart';
import 'package:go_dely/Pprincipal/Bdireccion.dart';
import 'package:go_dely/producto/categoriaProducto.dart';



class Principal extends StatefulWidget {
  const Principal({super.key, required this.title});

  final String title;

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 229, 229),
      body: Center(
        
    
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                
               
                BarraDireccion(),
               
                barraBusqueda(),

                BarraCategorias(),
               

                Categoriaproducto(categoria: 'Combos de Productos'),
                Categoriaproducto(categoria: 'Ofertas'),
                Categoriaproducto(categoria: 'Comida'),
                Categoriaproducto(categoria: 'Medicina'),
                Categoriaproducto(categoria: 'Carros')
            
              ],
            ),
          ),
        
      ),
    );
  }
}


