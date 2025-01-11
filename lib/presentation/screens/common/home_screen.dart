import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/combos/combos_provider.dart';
import 'package:go_dely/aplication/providers/products/product_provider.dart';
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

  @override
  void initState() {
    super.initState();
    if(mounted){
      _loadData();
    }
  }

  Future<void> _loadData() async {
    if(mounted){
      await ref.read(productsProvider.notifier).loadNextPage();
      await ref.read(combosProvider.notifier).loadNextPage();
    }
  }

  Future<void> _refreshData() async {
    if(mounted){
      await ref.read(productsProvider.notifier).refresh();
      await ref.read(combosProvider.notifier).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {

    final products = ref.watch(productsProvider);
    final combos = ref.watch(combosProvider);

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
                  ...products.where((product) => product.discount == 0)
                ],
                title: 'Products',
                subTitle: 'View All',
                loadNextPage: () => ref.read(productsProvider.notifier).loadNextPage(),
              ),
          
              
              ComboHorizontalListView(
                combos: [
                  ...combos
                ],
                title: 'Products Combos',
                subTitle: 'View All',
                loadNextPage: () => ref.read(combosProvider.notifier).loadNextPage(),
              ),
              
          
              ProductHorizontalListView(
                products: [
                  ...products.where((product) => product.discount > 0)
                ],
                title: 'Limited Offers',
                subTitle: 'View All',
                loadNextPage: () => ref.read(productsProvider.notifier).loadNextPage(),
              ),
                
              const SizedBox(height: 15,)
                
            ],
          ),
        ),
      ),
    );
  }
}