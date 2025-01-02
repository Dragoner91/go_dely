import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/bottom_appbar_provider.dart';
import 'package:go_dely/aplication/providers/products/current_product_provider.dart';
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

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;
    final bottomAppBarColor = theme.colorScheme.surfaceContainer;

    return BottomAppBar(
      height: 90,
      shape: const AutomaticNotchedShape(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)))),
      child: Row(
        children: [
          Column(children: [
            IconButton(
              icon: const Icon(Icons.discount_outlined),
              onPressed: () { 
                ref.read(currentStateNavBar.notifier).update((state) => 0);
                ref.read(currentProduct.notifier).update((state) => [] );
              },
              color: currentState == 0 ? currentColor : secondaryColor,
            ),
            Text("Offers", style: TextStyle(color: currentState == 0 ? primaryColor : secondaryColor,),)
          ]),
          const Padding(padding: EdgeInsets.only(left: 15)),
          Column(children: [
            IconButton(
              icon: const Icon(Icons.copy_outlined),
              onPressed: () { 
                ref.read(currentStateNavBar.notifier).update((state) => 1);
                ref.read(currentProduct.notifier).update((state) => [] );
                context.go("/categoryList");
              },
              color: currentState == 1 ? primaryColor : secondaryColor,
            ),
            Text("Categories", style: TextStyle(color: currentState == 1 ? primaryColor : secondaryColor,),)
          ]),
          const Spacer(),
          //const Padding(padding: EdgeInsets.only(left: 20)),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                border: Border.all(
                  color: currentState == 2 ? primaryColor : secondaryColor,
                  width: 2
                )
            ),
            child: CircleAvatar(
              backgroundColor: currentState == 2 ? primaryColor : bottomAppBarColor,
              radius: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                TextButton(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Icon(Icons.home_outlined, color: currentState == 2 ? Colors.white : secondaryColor,),
                      Text("Home", style: TextStyle(color: currentState == 2 ? Colors.white : secondaryColor, fontSize: 12))
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
          const Spacer(),
          //const Padding(padding: EdgeInsets.only(right: 20)),
          Column(children: [
            IconButton(
              icon: const Icon(Icons.task_outlined),
              onPressed: () { 
                ref.read(currentStateNavBar.notifier).update((state) => 3);
                ref.read(currentProduct.notifier).update((state) => [] );
                context.go("/orderHistory");
              },
              color: currentState == 3 ? primaryColor : secondaryColor,
            ),
            Text("Orders", style: TextStyle(color: currentState == 3 ? primaryColor : secondaryColor,),)
          ]),
          const Spacer(),
          // const Padding(padding: EdgeInsets.only(right: 25)),
          Column(children: [
            IconButton(
              icon: const Icon(Icons.person_outline_outlined),
              onPressed: () { 
                context.go("/profile");
                ref.read(currentStateNavBar.notifier).update((state) => 4);
                ref.read(currentProduct.notifier).update((state) => [] );
              },
              color: currentState == 4 ? primaryColor : secondaryColor,
            ),
            Text("Profile", style: TextStyle(color: currentState == 4 ? primaryColor : secondaryColor,),)
          ]),
          const Padding(padding: EdgeInsets.only(right: 5)),
        ],
      ),
    );
  }
}
