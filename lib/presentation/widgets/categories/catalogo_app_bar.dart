import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/categoria/category_provider.dart';
import 'package:go_router/go_router.dart';


class CatalogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CatalogoAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      width: double.infinity,
      child: AppBar(
        centerTitle: true,
        title: const Text(
          'Todas las categorias',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
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
  Size get preferredSize => const Size.fromHeight(20);

  @override
  ConsumerState<_ColumnaWidgetsBottom> createState() => _ColumnaWidgetsBottomState();
}

class _ColumnaWidgetsBottomState extends ConsumerState<_ColumnaWidgetsBottom> with SingleTickerProviderStateMixin{
  
  @override
  Widget build(BuildContext context) {

    final estadoCatalogo = ref.watch(CategoryProvider);

    return Row(
      children: [
        Expanded(child: Container()),
        IconButton(onPressed: () {ref.read(CategoryProvider.notifier).update((estadoCatalogo) => true);}, icon: Icon(Icons.list_alt, color: estadoCatalogo == true ? const Color(0xFF5D9558) : Colors.black45,)),
        IconButton(onPressed: () {ref.read(CategoryProvider.notifier).update((estadoCatalogo) => false);}, icon: Icon(Icons.window, color: estadoCatalogo == true ? Colors.black45 : const Color(0xFF5D9558),))
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
