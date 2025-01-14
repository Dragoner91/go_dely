import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/products/product_repository_provider.dart';
import 'package:go_dely/config/helpers/human_formats.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/infraestructure/mappers/cart_item_mapper.dart';
import 'package:go_dely/infraestructure/models/cart_item_local.dart';
import 'package:go_dely/aplication/providers/bottom_appbar_provider.dart';
import 'package:go_dely/aplication/providers/cart/cart_items_provider.dart';
import 'package:go_dely/aplication/providers/combos/combos_provider.dart';
import 'package:go_dely/aplication/providers/combos/combos_repository_provider.dart';
import 'package:go_dely/aplication/providers/combos/current_combo_provider.dart';
import 'package:go_dely/presentation/widgets/combo/combo_horizontal_listview.dart';
import 'package:go_dely/presentation/widgets/common/custom_bottom_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';



class ComboDetailsScreen extends ConsumerStatefulWidget {

  const ComboDetailsScreen({super.key,});

  @override
  ConsumerState<ComboDetailsScreen> createState() => _ComboDetailsScreenState();
}

class _ComboDetailsScreenState extends ConsumerState<ComboDetailsScreen> {
  final PanelController _panelController = PanelController();
  final ValueNotifier<bool> _isBottomAppBarVisible = ValueNotifier(true);
  late List<Product> products;

  Future<Combo> _loadCombo() async {
    products = [];
    final comboId = ref.read(currentCombo).lastOrNull?.id;
    final resultCombo = await ref.read(combosRepositoryProvider).getComboById(comboId!);
    final combo = resultCombo.unwrap();
    for( var productId in combo.products ) {
      final resultProducts = await ref.read(productRepositoryProvider).getProductById(productId);
      products.add(resultProducts.unwrap());
    }
    return combo;
  }

  Future<Combo> _loadProduct() async {
    final comboId = ref.read(currentCombo).lastOrNull?.id;
    final combo = await ref.read(combosRepositoryProvider).getComboById(comboId!);
    return combo.unwrap();
  }

  @override 
  Widget build(BuildContext context) {

    final combo = ref.watch(currentCombo).lastOrNull;
    if(combo == null) return const SizedBox();


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(combo.name),
        leading: IconButton(onPressed: () {
            ref.read(currentCombo.notifier).update((state) {
              state.removeLast();
              return [...state];
            } ) ;
            if(ref.watch(currentCombo).isEmpty) ref.read(currentStateNavBar.notifier).update((state) => 2);
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: _isBottomAppBarVisible,
        builder: (context, isVisible, child) {
          return isVisible ? const BottomAppBarCustom() : const SizedBox.shrink();
        },
      ),
      body: SlidingUpPanel(
        controller: _panelController,
        maxHeight: MediaQuery.of(context).size.height * 0.20,
        minHeight: 0,
        color: Colors.transparent,
        onPanelSlide: (position) {
          if (position > 0.1) {
            _isBottomAppBarVisible.value = false;
          } else {
            _isBottomAppBarVisible.value = true;
          }
        },
        panel: FutureBuilder(
          future: _loadCombo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    strokeWidth: 4, 
                    color: Color(0xFF5D9558),
                  ),
                )
              );
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading combo'),);
            }
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
                child: _PanelContent(combo: snapshot.data as Combo, panelController: _panelController,)
              );
            }
            return const Center(child: Text('No data available'),);
          },
        ),
        body: FutureBuilder(
          future: _loadCombo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    strokeWidth: 4, 
                    color: Color(0xFF5D9558),
                  ),
                )
              );
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading combo'),);
            }
            if (snapshot.hasData) {
              return _Content(combo: snapshot.data as Combo, products: products, panelController: _panelController,);
            }
            return const Center(child: Text('No data available'),);
          },
        ),
      ),
    );
  }
}

class _PanelContent extends ConsumerStatefulWidget {
  final Combo combo;
  final PanelController panelController;

  const _PanelContent({required this.combo, required this.panelController});

  @override
  __PanelContentState createState() => __PanelContentState();
}

class __PanelContentState extends ConsumerState<_PanelContent> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                disabledColor: Colors.black26,
                color: const Color(0xFF5D9558),
                icon: const Icon(
                  Icons.remove_circle_outline_outlined,
                  size: 45,
                ),
                //* decrementar cantidad item
                onPressed: () {
                  setState(() {
                    if (_quantity > 1) _quantity--;
                  });
                },
              ),
              Container(
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                          width: 1,
                          color: const Color(0xFF5D9558))),
                  child: Text(
                    _quantity.toString(),
                    style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  )),
              IconButton(
                icon: const Icon(
                  Icons.add_circle_outline_outlined,
                  color: Color(0xFF5D9558),
                  size: 45,
                ),
                onPressed: () {
                  setState(() {
                    _quantity++;
                  });
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        FilledButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFF5D9558))
          ),
          onPressed: () {
            final cart = ref.watch(cartItemsProvider.notifier).addItemToCart;
            cart(CartItemMapper.cartItemToEntity(CartLocal.fromEntity(widget.combo, _quantity, widget.combo.imageUrl[0], "Combo")));
            widget.panelController.close();
          },
          child: const SizedBox(
            width: 100,
            child: Center(child: Text('Add to Cart'))
          ),
        ),
      ],
    );
  }
}

class _Content extends ConsumerStatefulWidget{

  final Combo? combo;
  final List<Product> products;
  final PanelController panelController;

  const _Content({this.combo, required this.panelController, required this.products});

  @override
  ConsumerState<_Content> createState() => _ContentState();
}

class _ContentState extends ConsumerState<_Content> {

  @override
  void initState() {
    super.initState();
  }

  Future<bool> checkIfIsInCart() async {
    return await ref.read(cartItemsProvider.notifier).itemExistsInCart(widget.combo!.id);
  }

  @override
  Widget build(BuildContext context) {

    final recomendedCombos = ref.watch(combosProvider); //*cambiar a recomendacion de productos por categoria o algo asi
    final isInCart = checkIfIsInCart();
    final cartItemsNotifier = ref.watch(cartItemsProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                _Slider(comboImages: widget.combo!.imageUrl),
                if(widget.combo!.discount > 0)
                Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.amber.shade600.withOpacity(0.75)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("${HumanFormarts.percentage(widget.combo!.discount)} OFF", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                          ),
                        ),
                      )
                    ],
                  ),
              ]
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 20,),
              Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: Text(widget.combo!.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),maxLines: 3,)
              ),
              const Spacer(),
              if (widget.combo!.discount > 0) 
                Column(
                  children: [
                    Text(
                      "${HumanFormarts.numberCurrency(widget.combo!.price)} ${widget.combo!.currency}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      "${HumanFormarts.numberCurrency(widget.combo!.price - ( widget.combo!.price * widget.combo!.discount))} ${widget.combo!.currency}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color.fromARGB(255, 80, 137, 74)
                      ),
                    ),
                  ],
                )
               else ...[
                  Text(
                    "${HumanFormarts.numberCurrency(widget.combo!.price)} ${widget.combo!.currency}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color.fromARGB(255, 80, 137, 74)
                    ),
                  ),
                ],
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
                      Text(widget.combo!.categories.toString(), style: const TextStyle(fontSize: 18),),
                      const SizedBox(width: 20,),
                    ],
                  ),
              ],
              ),
              const Spacer(),
              FutureBuilder<bool>(
                future: isInCart,
                builder: (context, snapshot) {
                  final inCart = snapshot.hasData && snapshot.data == true;
                  return FilledButton(
                    onPressed: 
                      inCart 
                      ? null
                      : widget.panelController.open,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(snapshot.data == true ? Colors.black54 : const Color(0xFF5D9558))
                    ),
                    child: 
                        inCart 
                        ? const Row(
                            children: [
                              Text("Already Added ", style: TextStyle(color: Colors.white),),
                              Icon(Icons.check_circle_outline_outlined, color: Colors.white,),
                            ],
                          )
                        :
                          const Row(
                            children: [
                              Text("Add to Cart "),
                              Icon(Icons.shopping_cart),
                            ],
                          )
                  );
                },
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
                child: Text(widget.combo!.description, style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 18), maxLines: 5,),
              ),
              const SizedBox(width: 20,),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              const SizedBox(width: 20,),
              Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: const Text("Products included", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),maxLines: 3,)
              ),
            ],
          ),
          const SizedBox(height: 5,),
          _ListProducts(
            products: widget.products
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ComboHorizontalListView(
              combos: [
                ...recomendedCombos,
              ],
              title: 'Recomended Combos',
              loadNextPage: () {},
            ),
          ),
          const SizedBox(height: 200,),
        ],
      ),
    );
  }
}

class _ListProducts extends StatelessWidget {

  final List<Product> products;

  const _ListProducts({required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...products.map((e) => _ProductListItem(product: e)),
      ],
    );
  }


}

class _ProductListItem extends StatelessWidget{

  final Product product;

  const _ProductListItem({required this.product});

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      border: Border.all(width: 2, color: Colors.black38),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: SizedBox(
        height: 120,
        child: DecoratedBox(
          decoration: decoration,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(product.imageUrl[0], fit: BoxFit.contain,)
                  ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name, 
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 18
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      product.description, 
                      style: const TextStyle(
                        fontWeight: FontWeight.w200, 
                        fontSize: 16
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
        ),
    );
  }

}

class _Slider extends StatelessWidget {

  final List<String> comboImages;

  const _Slider({required this.comboImages});

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
            itemCount: comboImages.length,
            itemBuilder: (context, index) {
              final image = comboImages[index];
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
          fit: BoxFit.scaleDown,
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