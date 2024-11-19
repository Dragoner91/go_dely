import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/presentation/providers/combos/combos_provider.dart';
import 'package:go_dely/presentation/providers/products/product_provider.dart';
import 'package:go_dely/presentation/widgets/combo/combo_horizontal_listview.dart';
import 'package:go_dely/presentation/widgets/product/product_horizontal_listview.dart';
import 'package:go_dely/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  final String name = "HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldkey = GlobalKey<ScaffoldState>();

    return FadeIn(
      child: Scaffold(
          key: scaffoldkey,
          appBar: const CustomAppBar(),
          drawer: FadeInUpBig(duration: const Duration(milliseconds: 400),child: CustomSideMenu(scaffoldkey: scaffoldkey),),
          bottomNavigationBar: const BottomAppBarCustom(),
          body: _Content(),
          ),
    );
  }
}

class _Content extends ConsumerStatefulWidget {

  @override
  ConsumerState<_Content> createState() => _ContentState();
}

class _ContentState extends ConsumerState<_Content> {

  @override
  void initState() {
    super.initState();
    final products = ref.read( productsProvider.notifier ).loadNextPage();
    final combos = ref.read( combosProvider.notifier ).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final products = ref.watch(productsProvider);
    final combos = ref.watch(combosProvider);

    return SingleChildScrollView(
      child: Column(
        children: [

          ProductHorizontalListView(
            products: [
              ...products
            ],
            title: 'Productos',
            subTitle: 'Ver todo',
            loadNextPage: () => ref.read(productsProvider.notifier).loadNextPage(),
          ),

          /*
          ComboHorizontalListView(
            combos: [
              ...combos
            ],
            title: 'Combos de Productos',
            subTitle: 'Ver todo',
            loadNextPage: () => ref.read(combosProvider.notifier).loadNextPage(),
          ),
          */

          ProductHorizontalListView(
            products: [
              ...products
            ],
            title: 'Ofertas Limitadas',
            subTitle: 'Ver todo',
            loadNextPage: () => ref.read(productsProvider.notifier).loadNextPage(),
          ),

          const SizedBox(height: 15,)

        ],
      ),
    );
  }
}