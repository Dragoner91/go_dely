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
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            barraDireccion(),
           
            barraBusqueda(),

            barraCategorias(),
           
            categoriaProducto('Combos de Productos'),

            categoriaProducto('Ofertas limitadas'),  
  


          ],
        ),
      ),
    );
  }
}


