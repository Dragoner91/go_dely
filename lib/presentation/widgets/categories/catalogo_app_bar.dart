import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/presentation/providers/categoria/category_provider.dart';
import 'package:go_router/go_router.dart';


class CatalogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CatalogoAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      width: double.infinity,
      child: AppBar(
        centerTitle: true,
        title: IconButton(
          onPressed: () {
            
          },
          icon: const SizedBox(
          width: 200,
            child: 
                Text('Todas las categorias', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
        
          ),
        ),
        actions: [
          
          IconButton(onPressed: () {context.push("/cart");}, icon: const Icon(Icons.shopping_cart))
        ],
        bottom: const _ColumnaWidgetsBottom(),
        
      ),
    );
  }
}

class _ColumnaWidgetsBottom extends ConsumerStatefulWidget implements PreferredSizeWidget{
  const _ColumnaWidgetsBottom();

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  ConsumerState<_ColumnaWidgetsBottom> createState() => _ColumnaWidgetsBottomState();
}

class _ColumnaWidgetsBottomState extends ConsumerState<_ColumnaWidgetsBottom> with SingleTickerProviderStateMixin{
  
  @override
  Widget build(BuildContext context) {

    

    return Row(
      children: [
        const _SearchButton(),
        Expanded(child: Container()),
        IconButton(onPressed: () {ref.read(CategoryProvider.notifier).update((estadoCatalogo) => true);}, icon: const Icon(Icons.list_alt)),
        IconButton(onPressed: () {ref.read(CategoryProvider.notifier).update((estadoCatalogo) => false);}, icon: const Icon(Icons.window))
      ],
    );
  }
}



class _SearchButton extends StatelessWidget implements PreferredSizeWidget{
  const _SearchButton();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);


  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Row(
        children: [Icon(Icons.search, color: Colors.grey,),SizedBox(width: 7,), Text('Busca Categoria o producto', style: TextStyle(color: Colors.grey),),],
      ),
    );
  }
}
