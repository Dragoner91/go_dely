import 'package:flutter/material.dart';
//import 'package:animate_do/animate_do.dart';
import 'package:go_dely/domain/categories/categories.dart';

class CategoryIconListview extends StatefulWidget {
  final List<Categories> categories;
  const CategoryIconListview({
    super.key,
    required this.categories,
  });

  @override
  State<CategoryIconListview> createState() => _CategoryIconListviewState();
}

class _CategoryIconListviewState extends State<CategoryIconListview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: GridView.builder(
        gridDelegate: const
          SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Número de columnas
          crossAxisSpacing: 10, // Espacio entre columnas
          mainAxisSpacing: 10, // Espacio entre filas
        ),
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          //final category = widget.categories[index];
          return _SlideCategorias(categorias: widget.categories[index]);
          /*ListTile(
            title: Image.network(category.imageUrl, width: 50, height: 50),
            subtitle: Text(category.name),
            onTap: () {
              // Acción al tocar una categoría
            },
          );*/
        },
      ),
    );
  }
}

class _SlideCategorias extends StatelessWidget {
  //final String name;
  //final String descripcion;
  final Categories categorias;

  const _SlideCategorias({required this.categorias});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    //final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Center(
        child: Column(
        
          children:[ /*OutlinedButton(
            onPressed: () {
              // Acción al presionar el botón
            },
            style: ButtonStyle(
              side: WidgetStateProperty.all(BorderSide.none), // Remueve el borde
            ),
            child:*/ Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border:
                Border.all(color: const Color.fromARGB(136, 186, 186, 186)),
                shape: BoxShape.rectangle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 70,
                  width: 70,
                  child: Stack(
                    children: [
                      ClipRRect(
                        //borderRadius: BorderRadius.circular(20),
                        child: //Image.network(
                        Center(
                          child: Image.asset(
                            categorias.imageUrl,
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
                            /*loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress != null) {
                                return const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF5D9558),
                                  )),
                                );
                              }
                              return FadeIn(child: child);
                            },*/
                          ),
                        ),
                      ),
                      OutlinedButton(
                      onPressed: () {
                    // Acción al presionar el botón
                    },
                    style: ButtonStyle(
                    side: WidgetStateProperty.all(BorderSide.none), // Remueve el borde
                    ),
                
                        child: const SizedBox(
                          height: 110,
                          width: 100,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          //),
          Row(
            children: [
              Expanded(child: Container()),
              const SizedBox(
                width: 5,
              ),
              Text(
                categorias.name,
                style: //const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                textStyles.bodyLarge,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(child: Container()),
            ],
          ),
        
        ]),
      );
    //);


    /*Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: const Color.fromARGB(136, 186, 186, 186)),
        shape: BoxShape.rectangle,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

            title: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border:
                  Border.all(color: const Color.fromARGB(136, 186, 186, 186)),
              shape: BoxShape.rectangle,
            ),
            child: SizedBox(
              width: 100,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: //Image.network(
                        Image.asset(
                      categorias.imageUrl,
                      fit: BoxFit.cover,
                      height: 85,
                      width: 85,
                      /*loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF5D9558),
                          )),
                        );
                      }
                      return FadeIn(child: child);
                    },*/
                    ),
                  ),
                  const SizedBox(
                    height: 90,
                    width: 90,
                  ),
                ],
              ),
            ),
          ),
          subtitle: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              Text(
                categorias.name,
                style: //const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                textStyles.bodyLarge,
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        onTap: () {
          // Acción al tocar una categoría
        },
           ),
    );*/
  }
}
