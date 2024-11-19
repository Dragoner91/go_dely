import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/entities/combo/combo.dart';
import 'package:go_dely/domain/entities/product/product.dart';
import 'package:go_dely/presentation/providers/bottom_appbar_provider.dart';
import 'package:go_dely/presentation/providers/combos/combos_provider.dart';
import 'package:go_dely/presentation/providers/combos/current_combo_provider.dart';
import 'package:go_dely/presentation/widgets/combo/combo_horizontal_listview.dart';
import 'package:go_dely/presentation/widgets/common/custom_bottom_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:card_swiper/card_swiper.dart';


class ComboDetailsScreen extends ConsumerStatefulWidget {

  const ComboDetailsScreen({super.key,});

  @override
  ConsumerState<ComboDetailsScreen> createState() => _ComboDetailsScreenState();
}

class _ComboDetailsScreenState extends ConsumerState<ComboDetailsScreen> {

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
      bottomNavigationBar: const BottomAppBarCustom(),
      body: _Content(combo: combo,),
    );
  }
}

class _Content extends ConsumerStatefulWidget{

  final Combo? combo;

  const _Content({this.combo});

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

    final recomendedCombos = ref.watch(combosProvider); //*cambiar a recomendacion de productos por categoria o algo asi

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: _Slider(comboImages: [widget.combo!.imageUrl,widget.combo!.imageUrl,widget.combo!.imageUrl,]),
          ),
          Row(
            children: [
              const SizedBox(width: 20,),
              Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: Text(widget.combo!.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),maxLines: 3,)
              ),
              const Spacer(),
              Text("${widget.combo!.price} ${widget.combo!.currency}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
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
                      Text(widget.combo!.category, style: const TextStyle(fontSize: 18),),
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
            products: widget.combo!.products
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
          const SizedBox(height: 30,),
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