import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/config/helpers/human_formats.dart';
import 'package:go_dely/domain/entities/product/product.dart';
import 'package:go_dely/presentation/providers/bottom_appbar_provider.dart';
import 'package:go_dely/presentation/providers/products/current_product_provider.dart';
import 'package:go_router/go_router.dart';


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
      height: 260,
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

class _Slide extends ConsumerStatefulWidget {
  
  final Product product;

  const _Slide({required this.product});

  @override
  ConsumerState<_Slide> createState() => _SlideState();
}

class _SlideState extends ConsumerState<_Slide> {
  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),   
        border: Border.all(color: const Color.fromARGB(136, 186, 186, 186)),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //*imagen
          Container(
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
                    child: GestureDetector(
                      onTap: () {
                        //*colocar el id en el provider de currentProduct
                        ref.read(currentProduct.notifier).update((state) => [...state, widget.product] );
                        ref.read(currentStateNavBar.notifier).update((state) => -1);
                        context.push("/product");
                      },
                      child: Image.network(
                        widget.product.imageUrl[0],  //*siempre se visualiza la primera imagen del arreglo de imagenes
                        fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                        loadingBuilder: (context, child, loadingProgress) {
                          if( loadingProgress != null){
                            return const Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF5D9558),)),
                            );
                          }
                          return FadeIn(child: child);
                        },
                                  
                      ),
                    ),
                  ),
                  const SizedBox(height: 100,),
                  Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: IconButton(
                            color: Colors.white,
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(const Color(0xFF5D9558)),
                            ),
                            onPressed: () {
                              //*agregar producto al carrito
                            }, 
                            icon: const Icon(Icons.add, size: 14,)
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          //*title
          SizedBox(
            width: 150,
            child: Row(
              children: [
                const SizedBox(width: 5,),
                Expanded(
                  child: Text(
                    widget.product.name, //*arreglar cuando este producto listo
                    maxLines: 1,
                    style: textStyles.bodyLarge,
                  ),
                ),
                const SizedBox(width: 5,),
              ],
            ),
          ),

          //*rating
          SizedBox(
            width: 150,
            child: Row( //*arreglar cuando este producto listo
              children: [
                const SizedBox(width: 5,),
                Text(
                  "${widget.product.currency} ${HumanFormarts.numberCurrency(widget.product.price)}", //*arreglar cuando este producto listo
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 5,), 
                
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

          if(subtitle != null) FilledButton.tonal(
            onPressed: () {}, 
            style: ButtonStyle(
              visualDensity: VisualDensity.compact, 
              backgroundColor: WidgetStateProperty.all(const Color(0xFF5D9558)),
            ),
            child: Text(
              subtitle!, 
              style: const TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }
}