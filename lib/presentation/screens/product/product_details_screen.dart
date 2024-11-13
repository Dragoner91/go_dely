import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/entities/product/product.dart';
import 'package:go_dely/presentation/providers/bottom_appbar_provider.dart';
import 'package:go_dely/presentation/providers/products/current_product_provider.dart';
import 'package:go_dely/presentation/providers/products/product_provider.dart';
import 'package:go_dely/presentation/widgets/common/custom_bottom_app_bar.dart';
import 'package:go_dely/presentation/widgets/product/product_horizontal_listview.dart';
import 'package:go_router/go_router.dart';
import 'package:card_swiper/card_swiper.dart';


class ProductDetailsScreen extends ConsumerStatefulWidget {

  const ProductDetailsScreen({super.key,});

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {

  @override 
  Widget build(BuildContext context) {

    final product = ref.watch(currentProduct).lastOrNull;
    if(product == null) return const CircularProgressIndicator();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.name),
        leading: IconButton(onPressed: () {
            ref.read(currentProduct.notifier).update((state) {
              state.removeLast();
              return [...state];
            } ) ;
            if(ref.watch(currentProduct).isEmpty) ref.read(currentStateNavBar.notifier).update((state) => 2);
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      bottomNavigationBar: const BottomAppBarCustom(),
      body: _Content(product: product,),
    );
  }
}

class _Content extends ConsumerStatefulWidget{

  final Product? product;

  const _Content({this.product});

  @override
  ConsumerState<_Content> createState() => _ContentState();
}

class _ContentState extends ConsumerState<_Content> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final recomendedProducts = ref.watch(productsProvider); //*cambiar a recomendacion de productos por categoria o algo asi

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: _Slider(productImages: [...widget.product!.imageUrl,...widget.product!.imageUrl,...widget.product!.imageUrl,]),
          ),
          Row(
            children: [
              const SizedBox(width: 20,),
              Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: Text(widget.product!.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),maxLines: 3,)
              ),
              const Spacer(),
              Text("${widget.product!.price} \$${widget.product!.currency}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
              const SizedBox(width: 20,),
            ],
          ),
          const SizedBox(height: 25,),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 20,),
                      const Text("Category: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      const SizedBox(width: 5,),
                      Text(widget.product!.category, style: const TextStyle(fontSize: 18),),
                      const SizedBox(width: 20,),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 20,),
                      const Text("Presentation: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      const SizedBox(width: 5,),
                      Text(widget.product!.weight, style: const TextStyle(fontSize: 18),),
                      const SizedBox(width: 20,),
                    ],
                  ),
              ],
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  //* agregar al carrito el producto actual, para cuando se haga
                }, 
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFF5D9558))
                ),
                child: const Row(
                  children: [
                    Text("Add to Cart  "),
                    Icon(Icons.shopping_cart),
                  ],
                )
              ),
              const SizedBox(width: 15,),
            ],
          ),
          
          const SizedBox(height: 25,),
          Row(
            children: [
              const SizedBox(width: 20,),
              Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 350),
                child: Text(widget.product!.description+widget.product!.description+widget.product!.description+widget.product!.description+widget.product!.description, style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 18), maxLines: 5,),
              ),
              const SizedBox(width: 20,),
            ],
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductHorizontalListView(
              products: [
                ...recomendedProducts,...recomendedProducts,
              ],
              title: 'Recomended Products',
              loadNextPage: () {},
            ),
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}

class _Slider extends StatelessWidget {

  final List<String> productImages;

  const _Slider({required this.productImages});

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(width: 2)
    );

    return SizedBox(
      height: 300,
      child: DecoratedBox(
        decoration: decoration,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Swiper(
            pagination: const SwiperPagination(
              margin: EdgeInsets.only(top: 0),
              builder: DotSwiperPaginationBuilder(
                activeColor: Color(0xFF5D9558),
                color: Colors.black45
              )
            ),
            loop: false,
            itemCount: productImages.length,
            itemBuilder: (context, index) {
              final image = productImages[index];
              return _Slide(image: image);
            },
          ),
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final String image;

  const _Slide({required this.image});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          image, 
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if(loadingProgress != null){
              return const DecoratedBox(decoration: BoxDecoration(color: Colors.black12));
            }
            return FadeIn(child: child);
          },
          )
        ),
      );
  }
}