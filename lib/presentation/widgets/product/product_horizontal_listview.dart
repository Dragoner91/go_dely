import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/config/helpers/human_formats.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/infraestructure/mappers/cart_item_mapper.dart';
import 'package:go_dely/infraestructure/models/cart_item_local.dart';
import 'package:go_dely/aplication/providers/bottom_appbar_provider.dart';
import 'package:go_dely/aplication/providers/cart/cart_items_provider.dart';
import 'package:go_dely/aplication/providers/products/current_product_provider.dart';
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

  Future<bool> checkIfIsInCart() async {
    return await ref.read(cartItemsProvider.notifier).itemExistsInCart(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {

    final cartItemsNotifier = ref.watch(cartItemsProvider);
    final isInCart = checkIfIsInCart();

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
                        fit: BoxFit.contain,
                        height: 150,
                        width: 150,
                        loadingBuilder: (context, child, loadingProgress) {
                          if( loadingProgress != null){
                            return const Center(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Padding(
                                  padding: EdgeInsets.all(45),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2, 
                                    color: Color(0xFF5D9558),
                                  ),
                                ),
                              ),
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
                          child: FutureBuilder<bool>(
                            future: isInCart,
                            builder: (context, snapshot) {
                              final inCart = snapshot.hasData && snapshot.data == true;
                              return IconButton(
                                color: Colors.white,
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(snapshot.data == true ? Colors.black54 : const Color(0xFF5D9558)),
                                ),
                                onPressed: inCart ? null : () async {
                                  //*agregar producto al carrito
                                  final cart = ref.watch(cartItemsProvider.notifier).addItemToCart;
                                  cart(CartItemMapper.cartItemToEntity(CartLocal.fromEntity(widget.product, 1, widget.product.imageUrl[0], "Product")));
                                },
                                icon: inCart ? const Icon(Icons.check, size: 14, color: Colors.white,) : const Icon(Icons.add, size: 14, color: Colors.white,),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  widget.product.discount > 0 
                  ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber.shade600.withOpacity(0.75)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(HumanFormarts.percentage(widget.product.discount), style: const TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ),
                      )
                    ],
                  )
                  : const SizedBox.shrink(),
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

          //*price
          SizedBox(
            width: 150,
            child: Row( //*arreglar cuando este producto listo
              children: [

                const SizedBox(width: 5,),
                if (widget.product.discount > 0) ...[
                  Text(
                    "${HumanFormarts.numberCurrency(widget.product.price)} ${widget.product.currency}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Text(
                    "${HumanFormarts.numberCurrency(widget.product.price - ( widget.product.price * widget.product.discount))} ${widget.product.currency}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ] else ...[
                  Text(
                    "${HumanFormarts.numberCurrency(widget.product.price)} ${widget.product.currency}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
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