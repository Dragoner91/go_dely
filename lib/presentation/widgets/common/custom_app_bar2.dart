import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar2({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      width: double.infinity,
      child: AppBar(
        centerTitle: true,
        title: Text('My Profile', style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios), // Icono personalizado
          onPressed: () {

          },
        ),
        //actions: [
          //IconButton(onPressed: () {}, icon: const Icon(Icons.notifications),),
          //IconButton(onPressed: () {context.push("/cart");}, icon: const Icon(Icons.shopping_cart))
        //],


      ),
    );
  }
}



