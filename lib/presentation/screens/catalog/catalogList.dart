import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_dely/presentation/widgets/categories/category_vertical_listview.dart';
import 'package:go_dely/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/entities/categories/categories.dart';



class Cataloglist extends StatelessWidget {
  const Cataloglist({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();
    

    return FadeIn(
      child: Scaffold(
          key: scaffoldkey,
          appBar: const CatalogoAppBar(),
          drawer: FadeInUpBig(duration: const Duration(milliseconds: 400),child: CustomSideMenu(scaffoldkey: scaffoldkey),),
          bottomNavigationBar: const BottomAppBarCustom(),          
          body: ContentCatalogList(),
          ),
    );
  }
}

class ContentCatalogList extends StatefulWidget {
  const ContentCatalogList({super.key});

  @override
  State<ContentCatalogList> createState() => _ContentCatalogListState();
}

class _ContentCatalogListState extends State<ContentCatalogList> {

  @override
  void initState() {
    super.initState();
    //final categorias = ref.read( productsProvider.notifier ).loadNextPage();
    
  }
  final List<Categories> categorias= [Categories(1,'Comida','manzana, naranja, pollo','_food.png'),
  Categories(2,'Medicina','Malaway EFG, Presar EFG ','_medicine.png'),
  Categories(3,'Hogar','mesa, silla','_home.png'),
    Categories(4,'Bebes','talco, pañales','_baby.png'),
    Categories(5,'Mascotas','Comida, juguetes','_pets.png'),
    Categories(6,'Heramientas','martillo, destornillador','combo_hogar.png')
  ];
    

  @override
  Widget build(BuildContext context) {
    return CategoryVerticalListView(categorias: categorias);
  }
}