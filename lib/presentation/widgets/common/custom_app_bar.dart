import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Calle Central', style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
                Icon(Icons.arrow_drop_down),
            ],),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications),),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
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

    final tabs = <Tab>[
      Tab(
        child: FilledButton(
          onPressed: () {}, 
          style: FilledButton.styleFrom(backgroundColor: const Color(0xFF5D9558)), 
          child: const Text('TODO')
        ),
      ),
      const Tab(child: Text('COMIDA'),),
      const Tab(child: Text('MEDICINA'),),
    ];

    final tabController = TabController(length: tabs.length, vsync: this);

    return Column(
      children: [
        const _SearchButton(),
        TabBar(
          labelColor: const Color(0xFF5D9558),
          indicatorColor: const Color(0xFF5D9558),
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          tabs: [
            ...tabs
        ], )
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
