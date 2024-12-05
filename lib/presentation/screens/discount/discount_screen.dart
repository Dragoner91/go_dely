import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/presentation/widgets/discount/discount_litview.dart';
import 'package:go_dely/presentation/widgets/widgets.dart';
import 'package:go_dely/aplication/providers/products/discount_provider.dart';


class DiscountScreen extends StatelessWidget {
  const DiscountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();


    return FadeIn(
      child: Scaffold(
        key: scaffoldkey,
        appBar: const CustomAppBar(),
        drawer: FadeInUpBig(duration: const Duration(milliseconds: 400),child: CustomSideMenu(scaffoldkey: scaffoldkey),),
        bottomNavigationBar: const BottomAppBarCustom(),
        body: const ContentDiscountScreen(),
      ),
    );
  }
}

class ContentDiscountScreen extends ConsumerStatefulWidget {
  const ContentDiscountScreen({super.key});

  @override
  ConsumerState<ContentDiscountScreen> createState() => _ContentDiscountScreenState();
}

class _ContentDiscountScreenState extends ConsumerState<ContentDiscountScreen> {

  final List<Product> productos= [
    Product(id: '1', name: 'Producto1', price: 10.0, description: 'descripcion del producto', imageUrl: ['assets/food.png'], weight: '10g', currency: '\$', stock: 5, category: 'categoria', discount: 0.1),
    Product(id: '2', name: 'Producto2', price: 12.0, description: 'descripcion del producto', imageUrl: ['assets/medicine.png'], weight: '10g', currency: '\$', stock: 5, category: 'categoria', discount: 0.1),
    Product(id: '3', name: 'Producto3', price: 15.0, description: 'descripcion del producto', imageUrl: ['assets/baby.png'], weight: '10g', currency: '\$', stock: 5, category: 'categoria', discount: 0.15),
    Product(id: '4', name: 'Producto4', price: 20.0, description: 'descripcion del producto', imageUrl: ['assets/home.png'], weight: '10g', currency: '\$', stock: 5, category: 'categoria', discount: 0.2),
    Product(id: '5', name: 'Producto5', price: 10.0, description: 'descripcion del producto', imageUrl: ['assets/food.png'], weight: '10g', currency: '\$', stock: 5, category: 'categoria', discount: 0.15),
    Product(id: '6', name: 'Producto6', price: 12.0, description: 'descripcion del producto', imageUrl: ['assets/medicine.png'], weight: '10g', currency: '\$', stock: 5, category: 'categoria', discount: 0.15),
    Product(id: '7', name: 'Producto7', price: 15.0, description: 'descripcion del producto', imageUrl: ['assets/baby.png'], weight: '10g', currency: '\$', stock: 5, category: 'categoria', discount: 0.2),
    Product(id: '8', name: 'Producto8', price: 20.0, description: 'descripcion del producto', imageUrl: ['assets/home.png'], weight: '10g', currency: '\$', stock: 5, category: 'categoria', discount: 0.3),

  ];
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await ref.read(discountsProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(discountsProvider);
    return DiscountListview(productos: [
      ...products
    ],loadNextPage: () => ref.read(discountsProvider.notifier).loadNextPage(),);
  }
}

