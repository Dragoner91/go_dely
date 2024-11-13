import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_dely/presentation/widgets/categories/category_icon_listview.dart';
import 'package:go_dely/presentation/widgets/widgets.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/entities/categories/categories.dart';

class Catalogicons extends StatefulWidget {
  const Catalogicons({super.key});

  @override
  State<Catalogicons> createState() => _CatalogiconsState();
}

class _CatalogiconsState extends State<Catalogicons> {
  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();
    

    return FadeIn(
      child: Scaffold(
          key: scaffoldkey,
          appBar: const CatalogoAppBar(),
          drawer: FadeInUpBig(duration: const Duration(milliseconds: 400),child: CustomSideMenu(scaffoldkey: scaffoldkey),),
          bottomNavigationBar: const BottomAppBarCustom(),          
          body: ContentCatalogoIcons(),
          ),
    );
  }
}

class ContentCatalogoIcons extends StatefulWidget {
  const ContentCatalogoIcons({super.key});

  @override
  State<ContentCatalogoIcons> createState() => _ContentCatalogoIconsState();
}

final List<Categories> categorias= [Categories(1,'Comida','manzana, naranja, pollo','_food.png'),
  Categories(2,'Medicina','Malaway EFG, Presar EFG ','_medicine.png'),
  Categories(3,'Hogar','mesa, silla','_home.png'),
  Categories(4,'Bebes','talco, pañales','_baby.png'),
  Categories(5,'Mascotas','Comida, juguetes','_pets.png'),
  Categories(6,'Heramientas','martillo, destornillador','combo_hogar.png')
];

class _ContentCatalogoIconsState extends State<ContentCatalogoIcons> {
  @override
  Widget build(BuildContext context) {
    return CategoryIconListview(categories: categorias);
  }
}