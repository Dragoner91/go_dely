import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/presentation/providers/bottom_appbar_provider.dart';
import 'package:go_dely/presentation/providers/products/current_product_provider.dart';
import 'package:go_router/go_router.dart';

class BottomAppBarCustom extends ConsumerStatefulWidget {
  const BottomAppBarCustom({super.key});

  @override
  BottomAppBarCustomState createState() => BottomAppBarCustomState();
  
  
}

class BottomAppBarCustomState extends ConsumerState<BottomAppBarCustom> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final currentState = ref.watch(currentStateNavBar);
    const Color currentColor = Color(0xFF5D9558);
    const Color colorOptions = Colors.black45;

    return BottomAppBar(
      height: 90,
      shape: const AutomaticNotchedShape(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)))),
      child: Row(
        children: [
          const Padding(padding: EdgeInsets.only(left: 5)),
          Column(children: [
            IconButton(
              icon: const Icon(Icons.discount_outlined),
              onPressed: () { 
                ref.read(currentStateNavBar.notifier).update((state) => 0);
                ref.read(currentProduct.notifier).update((state) => [] );
              },
              color: currentState == 0 ? currentColor : colorOptions,
            ),
            Text("Offers", style: TextStyle(color: currentState == 0 ? currentColor : colorOptions,),)
          ]),
          const Padding(padding: EdgeInsets.only(left: 25)),
          Column(children: [
            IconButton(
              icon: const Icon(Icons.copy_outlined),
              onPressed: () { 
                ref.read(currentStateNavBar.notifier).update((state) => 1);
                ref.read(currentProduct.notifier).update((state) => [] );
              },
              color: currentState == 1 ? currentColor : colorOptions,
            ),
            Text("Catalog", style: TextStyle(color: currentState == 1 ? currentColor : colorOptions,),)
          ]),
          const Padding(padding: EdgeInsets.only(left: 20)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                border: Border.all(
                  color: currentColor,
                  width: 2
                )
            ),
            child: CircleAvatar(
              backgroundColor: currentState == 2 ? currentColor : const Color(0xFFf3ecf4),
              radius: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                TextButton(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Icon(Icons.home_outlined, color: currentState == 2 ? Colors.white : currentColor,),
                      Text("Home", style: TextStyle(color: currentState == 2 ? Colors.white : currentColor, fontSize: 12))
                    ]),
                  ),
                  onPressed: () { 
                    ref.read(currentStateNavBar.notifier).update((state) => 2);
                    ref.read(currentProduct.notifier).update((state) => [] );
                    context.go("/home");
                  },
                ),
              ]),
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 24)),
          Column(children: [
            IconButton(
              icon: const Icon(Icons.task_outlined),
              onPressed: () { 
                ref.read(currentStateNavBar.notifier).update((state) => 3);
                ref.read(currentProduct.notifier).update((state) => [] );
              },
              color: currentState == 3 ? currentColor : colorOptions,
            ),
            Text("Orders", style: TextStyle(color: currentState == 3 ? currentColor : colorOptions,),)
          ]),
          const Padding(padding: EdgeInsets.only(right: 25)),
          Column(children: [
            IconButton(
              icon: const Icon(Icons.person_outline_outlined),
              onPressed: () { 
                ref.read(currentStateNavBar.notifier).update((state) => 4);
                ref.read(currentProduct.notifier).update((state) => [] );
              },
              color: currentState == 4 ? currentColor : colorOptions,
            ),
            Text("Profile", style: TextStyle(color: currentState == 4 ? currentColor : colorOptions,),)
          ]),
        ],
      ),
    );
  }
}
