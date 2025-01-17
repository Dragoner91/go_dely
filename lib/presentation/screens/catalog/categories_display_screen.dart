import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/categoria/category_provider.dart';
import 'package:go_dely/aplication/providers/combos/category_combos_provider.dart';
import 'package:go_dely/aplication/providers/combos/combos_provider.dart';
import 'package:go_dely/aplication/providers/products/category_product_provider.dart';
import 'package:go_dely/aplication/providers/products/product_provider.dart';
import 'package:go_dely/presentation/widgets/combo/combo_horizontal_listview.dart';
import 'package:go_dely/presentation/widgets/product/product_horizontal_listview.dart';
import 'package:go_dely/presentation/widgets/widgets.dart';

class CategoriesDisplayScreen extends StatelessWidget {

  final String name = "HomeScreen";

  const CategoriesDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldkey = GlobalKey<ScaffoldState>();

    return FadeIn(
      child: Scaffold(
          key: scaffoldkey,
          appBar: const CustomAppBar(),
          drawer: FadeInLeftBig(duration: const Duration(milliseconds: 400),child: CustomSideMenu(scaffoldkey: scaffoldkey),),
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

  late String categoryId;

  @override
  void initState() {
    super.initState();
    if(mounted){
      _loadCategory();
      _loadData();
    }
  }

  void _loadCategory() {
    categoryId = ref.read(currentCategory.notifier).state;
  }

  Future<void> _loadData() async {
    if(mounted){
      await ref.read(categoriesProductsProvider.notifier).loadNextPage(categoryId);
      await ref.read(categoriesCombosProvider.notifier).loadNextPage(categoryId);
    }
  }

  Future<void> _refreshData() async {
    if(mounted){
      await ref.read(categoriesProductsProvider.notifier).refresh(categoryId);
      await ref.read(categoriesCombosProvider.notifier).refresh(categoryId);
    }
  }

  @override
  Widget build(BuildContext context) {

    final categoryProducts = ref.watch(categoriesProductsProvider);
    final categoryCombos = ref.watch(categoriesCombosProvider);

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final bottomAppBarColor = theme.colorScheme.surfaceContainer;

    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      color: const Color(0xFF5D9558),
      onRefresh: _refreshData,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor.withAlpha(124), bottomAppBarColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
                
              ProductHorizontalListView(
                products: [
                  ...categoryProducts
                ],
                title: 'Products',
                subTitle: 'View All',
                loadNextPage: () => ref.read(categoriesProductsProvider.notifier).loadNextPage(categoryId),
              ),
          
              
              ComboHorizontalListView(
                combos: [
                  ...categoryCombos
                ],
                title: 'Products Combos',
                subTitle: 'View All',
                loadNextPage: () => ref.read(categoriesCombosProvider.notifier).loadNextPage(categoryId),
              ),
              
                
              const SizedBox(height: 15,)
                
            ],
          ),
        ),
      ),
    );
  }
}