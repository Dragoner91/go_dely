import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/categoria/category_provider.dart';
import 'package:go_dely/presentation/widgets/categories/category_vertical_listview.dart';
import 'package:go_dely/presentation/widgets/categories/category_icon_listview.dart';
import 'package:go_dely/presentation/widgets/widgets.dart';
import 'package:go_dely/domain/category/category.dart';





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
          body: const ContentCatalogList(),
          ),
    );
  }
}

class ContentCatalogList extends ConsumerStatefulWidget {
  const ContentCatalogList({super.key});

  @override
  ConsumerState<ContentCatalogList> createState() => _ContentCatalogListState();
  
}

class _ContentCatalogListState extends ConsumerState<ContentCatalogList> {

  @override
  void initState() {
    super.initState();
    //final categorias = ref.read( productsProvider.notifier ).loadNextPage();
    
  }


  final List<Category> categorias= [
    
  ];
    
  @override
  Widget build(BuildContext context) {
    final currentState = ref.watch(CategoryProvider);

    if (currentState == true){
    return CategoryVerticalListView(categorias: categorias);
    }
    else {
      return CategoryIconListview(categories: categorias);
    }
    
    
  }
}