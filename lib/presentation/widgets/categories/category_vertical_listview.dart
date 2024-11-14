import 'package:flutter/material.dart';
import 'package:go_dely/domain/entities/categories/categories.dart';

class CategoryVerticalListView extends StatefulWidget {

  final List<Categories> categorias;
  //final VoidCallback? loadNextPage;
  //const CategoryVerticalListView({super.key, this.title, this.descripcion, this.loadNextPage});
  const CategoryVerticalListView({super.key, required this.categorias});

  @override
  State<CategoryVerticalListView> createState() => _CategoryVerticalListViewState();
}



class _CategoryVerticalListViewState extends State<CategoryVerticalListView> {

  final scrollController = ScrollController();

  /*@override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if( widget.loadNextPage == null) return;
      if( (scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent ){
        widget.loadNextPage!();
      }
    },);
  }*/

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:680,
      child: Column(
        children: [

          const SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.categorias.length,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _SlideCategorias(categorias: widget.categorias[index]);
              },
            ),
          )

        ],
      ),
    );
  }
}

class _SlideCategorias extends StatelessWidget {
  
  
  final Categories categorias;
  

  const _SlideCategorias({required this.categorias});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final titleStyle =  Theme.of(context).textTheme.titleLarge;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),        
        border: Border.all(color: const Color.fromARGB(136, 186, 186, 186)),
        shape: BoxShape.rectangle,
      ),
      child: ListTile(
    title: SizedBox(
            child: Row(
              children: [
                const SizedBox(width: 5,),
                Text(
                  categorias.name, 
                  
                  style: titleStyle,
                ),
                const SizedBox(width: 5,),
              ],
            ),
          ),
    subtitle: SizedBox(
            child: Row( 
              children: [
                const SizedBox(width: 5,),
                Text(
                  categorias.ejemplos, 
                  style: textStyles.bodyLarge,
                ),
                const SizedBox(width: 5,), 
                
              ],
            ),
          ),

    onTap: () {
    // Acción al tocar una categoría
  },
  )




      /*Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          SizedBox(
            child: Row(
              children: [
                const SizedBox(width: 5,),
                Text(
                  categorias.name, 
                  
                  style: titleStyle,
                ),
                const SizedBox(width: 5,),
              ],
            ),
          ),


          SizedBox(
            child: Row( 
              children: [
                const SizedBox(width: 5,),
                Text(
                  categorias.descripcion, 
                  style: textStyles.bodyLarge,
                ),
                const SizedBox(width: 5,), 
                
              ],
            ),
          )




      ]),*/
    );
  }
}