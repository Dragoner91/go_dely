import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_dely/domain/entities/categories/categories.dart';

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
    return ListView.builder(
      itemCount: widget.categories.length,
      itemBuilder: (context, index) {
        final category = widget.categories[index];
        return ListTile(
          leading: Image.network(category.imageUrl, width: 50, height: 50),
          title: Text(category.name),
          onTap: () {
            // Acción al tocar una categoría
          },
        );
      },
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
    //final textStyles = Theme.of(context).textTheme;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: const Color.fromARGB(136, 186, 186, 186)),
        shape: BoxShape.rectangle,
      ),
      child: ListTile(
        title: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: const Color.fromARGB(136, 186, 186, 186)),
            shape: BoxShape.rectangle,
          ),
          child: SizedBox(
            width: 150,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: //Image.network(
                  Image.asset(
                    categorias.imageUrl[
                        0], 
                    fit: BoxFit.cover,
                    height: 150,
                    width: 150,
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
                  height: 100,
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
              style: titleStyle,
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
      ),
    );
  }
}
