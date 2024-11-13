import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CatalogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CatalogoAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(150);

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
                  fontSize: 26,
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

class _ColumnaWidgetsBottom extends StatefulWidget implements PreferredSizeWidget{
  const _ColumnaWidgetsBottom();

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  State<_ColumnaWidgetsBottom> createState() => _ColumnaWidgetsBottomState();
}

class _ColumnaWidgetsBottomState extends State<_ColumnaWidgetsBottom> with SingleTickerProviderStateMixin{
  
  @override
  Widget build(BuildContext context) {

    

    return Row(
      children: [
        const _SearchButton(),
        IconButton(onPressed: () {context.push("/catalogoList");}, icon: const Icon(Icons.list_alt)),
        IconButton(onPressed: () {context.push("/catalogoIcon");}, icon: const Icon(Icons.window))
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
