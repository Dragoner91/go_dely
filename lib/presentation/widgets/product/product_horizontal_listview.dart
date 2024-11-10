import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_dely/domain/entities/product/product.dart';


class ProductHorizontalListView extends StatefulWidget {

  final List<Product> products;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const ProductHorizontalListView({super.key, required this.products, this.title, this.subTitle, this.loadNextPage});

  @override
  State<ProductHorizontalListView> createState() => _ProductHorizontalListViewState();
}

class _ProductHorizontalListViewState extends State<ProductHorizontalListView> {
  
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if( widget.loadNextPage == null) return;
      if( (scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent ){
        widget.loadNextPage!();
      }
    },);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Column(
        children: [

          if( widget.title != null || widget.subTitle != null ) _Title(title: widget.title, subtitle: widget.subTitle),
          const SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.products.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _Slide(product: widget.products[index]);
              },
            ),
          )

        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  
  final Product product;

  const _Slide({required this.product});

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*imagen
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/combo_hogar.png', //*arreglar cuando este producto listo
                fit: BoxFit.cover,
                width: 150,
                /*
                loadingBuilder: (context, child, loadingProgress) {
                  if( loadingProgress != null){
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2,)),
                    );
                  }
                  return FadeIn(child: child);
                },
                */
              ),
            ),
          ),

          //*title
          SizedBox(
            width: 150,
            child: Text(
              'product.title', //*arreglar cuando este producto listo
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),

          //*rating
          SizedBox(
            width: 150,
            child: Row( //*arreglar cuando este producto listo
              children: [
                Icon( Icons.star_half_outlined, color: Colors.yellow.shade800,),
                const SizedBox(width: 3,), 
                //const SizedBox(width: 10,),
                const Spacer(),
                
              ],
            ),
          )




      ]),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {

    final titleStyle =  Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [

          if(title != null) Text(title!, style: titleStyle),

          const Spacer(),

          if(subtitle != null) FilledButton.tonal(onPressed: () {}, style: ButtonStyle(visualDensity: VisualDensity.compact, backgroundColor: WidgetStateProperty.all(const Color(0xFF5D9558)),),child: Text(subtitle!, style: const TextStyle(color: Colors.white),),),
          
        ],
      ),
    );
  }
}