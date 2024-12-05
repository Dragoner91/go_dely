import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/config/helpers/human_formats.dart';
import 'package:go_dely/infraestructure/mappers/cart_item_mapper.dart';
import 'package:go_dely/infraestructure/models/cart_item_local.dart';
import 'package:go_dely/aplication/providers/bottom_appbar_provider.dart';
import 'package:go_dely/aplication/providers/cart/cart_items_provider.dart';
import 'package:go_dely/aplication/providers/products/current_product_provider.dart';
import 'package:go_router/go_router.dart';

class DiscountListview extends StatefulWidget {
  final List<Product> productos;
  final VoidCallback? loadNextPage;
  const DiscountListview({super.key,required this.productos,this.loadNextPage});

  @override
  State<DiscountListview> createState() => _DiscountListviewState();
}

class _DiscountListviewState extends State<DiscountListview> {

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

    final titleStyle =  Theme.of(context).textTheme.titleLarge;

    return SizedBox(
      height:680,
      child: Column(
        children: [
          //Text('Discounts',
            //style: titleStyle,),

          const SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.productos.length,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _SlideDiscount(producto: widget.productos[index]);

              },
            ),
          )

        ],
      ),
    );
  }
}

class _SlideDiscount extends ConsumerStatefulWidget {

  final Product producto;
  const _SlideDiscount({super.key, required this.producto});

  @override
  ConsumerState<_SlideDiscount> createState() => _SlideDiscountState();
}

class _SlideDiscountState extends ConsumerState<_SlideDiscount> {
  double calcularPrecio(double price, double discount) {
    return price - (price * discount);
  }
  Future<bool> checkIfIsInCart() async {
    return await ref.read(cartItemsProvider.notifier).itemExistsInCart(widget.producto.id);
  }

  @override
  Widget build(BuildContext context) {

    final titleStyle =  Theme.of(context).textTheme.titleLarge;
    final isInCart = checkIfIsInCart();
    return Padding(
      padding: const EdgeInsets.all(3),
      child: GestureDetector(
        onTap: (){
          ref.read(currentProduct.notifier).update((state) => [...state, widget.producto] );
          ref.read(currentStateNavBar.notifier).update((state) => -1);
          context.push("/product");

        },
        child: Container(

              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: const Color.fromARGB(136, 186, 186, 186)),
                shape: BoxShape.rectangle,
              ),
            child: Stack(
              children:[Row(
                children: [
                  //Expanded(child: Container(),),
                  const SizedBox(width: 6,),
                  Column(
                    children:[
                      const SizedBox(height: 20,),
                      Image.asset(
                        widget.producto.imageUrl[0],
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,),
                      const SizedBox(height: 20,),
                    ],
                  ),
                  Expanded(child: Container(),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 5,),
                          //Expanded(child: Container(),),
                          Text(
                            widget.producto.name,
                            style: titleStyle,
                          ),
                          const SizedBox(width: 5,),
                          //Expanded(child: Container(),),

                        ],
                      ),
                      const SizedBox(height: 10,),


                      Row(
                        children: [
                          const SizedBox(width: 5,),
                          Text(
                            widget.producto.description,
                            style: TextStyle(fontSize: 12),
                            maxLines: 5,
                          ),
                          const SizedBox(width: 5,),

                        ],
                      ),


                    ],
                  ),
                  Expanded(child: Container(),),
                  Column(
                    children: [
                      Text(widget.producto.price.toString() +' '+ widget.producto.currency,
                        style: TextStyle(fontSize: 12,
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.red,
                          decorationThickness: 2.0,
                        ),
                      ),
                      Text(calcularPrecio(widget.producto.price, widget.producto.discount).toString() +' '+ widget.producto.currency,
                        style: TextStyle(fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FutureBuilder<bool>(
                        future: isInCart,
                        builder: (context, snapshot) {
                          final inCart = snapshot.hasData && snapshot.data == true;
                          return
                            /*SizedBox(
                            width:110, // Ajusta el ancho
                            height: 24,
                            child:*/ FilledButton(
                                onPressed: inCart ? null : () async {
                                  //*agregar producto al carrito
                                  final cart = ref.watch(cartItemsProvider.notifier).addItemToCart;
                                  cart(CartItemMapper.cartItemToEntity(CartLocal.fromEntity(widget.producto, 1, widget.producto.imageUrl[0])));
                                },
                                style: ButtonStyle(
                                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                                EdgeInsets.symmetric(horizontal: 8, vertical: 5),),
                                    backgroundColor: WidgetStatePropertyAll(snapshot.data == true ? Colors.black54 : const Color(0xFF5D9558)),
                                    minimumSize: WidgetStateProperty.all<Size>
                                      (Size(70, 24),),
                                ),
                                child: inCart
                                    ? const Row(
                                  children: [
                                    Text("Already Added ", style: TextStyle(color: Colors.white),),
                                    Icon(Icons.check_circle_outline_outlined, color: Colors.white,),
                                  ],
                                ):
                                    Text("Add to Cart",
                                      style: TextStyle(fontSize: 12),),


                            );
                          //);
                        },
                      ),

                    ],),
                  //Expanded(child: Container(),),
                  const SizedBox(width: 6,),

                ],
              ),
                Row(
                  children:[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.amber.shade600.withOpacity(0.75)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("${HumanFormarts.percentage(widget.producto.discount)} OFF", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                        ),
                      ),
                    ),
                    Expanded(child: Container(),),
                    /*FutureBuilder<bool>(
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
                          cart(CartItemMapper.cartItemToEntity(CartLocal.fromEntity(widget.producto, 1, widget.producto.imageUrl[0])));
                        },
                        icon: inCart ? const Icon(Icons.check, size: 16, color: Colors.white,) : const Icon(Icons.add, size: 16, color: Colors.white,),
                      );
                    },
                  ),*/*/
                  ]
                ),
              ]
            )
          ),


      ),
    );
  }
}

