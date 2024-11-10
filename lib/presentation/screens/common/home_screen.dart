import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_dely/domain/entities/product/product.dart';
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

class _Content extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProductHorizontalListView(
            products: [Product(),Product(),Product(),],
            title: 'Combos de Productos',
            subTitle: 'Ver todo',
            loadNextPage: () {},
          ),

          ProductHorizontalListView(
            products: [Product(),Product(),Product(),],
            title: 'Ofertas Limitadas',
            subTitle: 'Ver todo',
            loadNextPage: () {},
          ),


          ProductHorizontalListView(
            products: [Product(),Product(),Product(),],
            title: 'Comida',
            subTitle: 'Ver todo',
            loadNextPage: () {},
          ),


          const SizedBox(height: 15,)

        ],
      ),
    );
  }
}