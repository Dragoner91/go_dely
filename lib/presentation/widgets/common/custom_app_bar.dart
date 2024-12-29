import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/cart/cart_items_provider.dart';
import 'package:go_dely/domain/cart/i_cart.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

class CustomAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {

  @override
  Size get preferredSize => const Size.fromHeight(100);

  const CustomAppBar({super.key});

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final shadowColor = theme.colorScheme.shadow;

    final cartItemsFuture = ref.watch(cartItemsProvider.notifier).watchAllItemsFromCart();

    return SizedBox(
      height: 700,
      width: double.infinity,
      child: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: shadowColor),
        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(124),
        title: IconButton(
          onPressed: () {
            
          },
          icon: const SizedBox(
          width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
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
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications, color: shadowColor,),),
          FutureBuilder<Stream<List<ICart>>>(
            future: cartItemsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return badges.Badge(
                  showBadge: true,
                  badgeContent: const Text('0', style: TextStyle(color: Colors.white)),
                  badgeAnimation: const badges.BadgeAnimation.slide(
                    animationDuration: Duration(milliseconds: 400),
                    colorChangeAnimationDuration: Duration(seconds: 1),
                    loopAnimation: false,
                    curve: Curves.easeInOut,
                    colorChangeAnimationCurve: Curves.easeInOut,
                  ),
                  position: badges.BadgePosition.topEnd(top: 0, end: 5),
                  child: IconButton(
                    onPressed: () {context.push("/cart");}, 
                    icon: Icon(Icons.shopping_cart, color: shadowColor,)
                  )
                );
              } else if (snapshot.hasData) {
                return StreamBuilder<List<ICart>>(
                  stream: snapshot.data,
                  builder: (context, streamSnapshot) {
                    if (streamSnapshot.connectionState == ConnectionState.waiting) {
                      return badges.Badge(
                        showBadge: true,
                        badgeContent: const Text('0', style: TextStyle(color: Colors.white)),
                        badgeAnimation: const badges.BadgeAnimation.slide(
                          animationDuration: Duration(milliseconds: 400),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          curve: Curves.easeInOut,
                          colorChangeAnimationCurve: Curves.easeInOut,
                        ),
                        position: badges.BadgePosition.topEnd(top: 0, end: 5),
                        child: IconButton(
                          onPressed: () {context.push("/cart");}, 
                          icon: Icon(Icons.shopping_cart, color: shadowColor,)
                        )
                      );
                    } else {
                      final cartItems = streamSnapshot.data ?? [];
                      return badges.Badge(
                        showBadge: cartItems.isEmpty ? false : true,
                        badgeContent: Text('${cartItems.length}', style: const TextStyle(color: Colors.white)),
                        badgeAnimation: const badges.BadgeAnimation.slide(
                          animationDuration: Duration(milliseconds: 400),
                          colorChangeAnimationDuration: Duration(seconds: 1),
                          loopAnimation: false,
                          curve: Curves.easeInOut,
                          colorChangeAnimationCurve: Curves.easeInOut,
                        ),
                        position: badges.BadgePosition.topEnd(top: 0, end: 5),
                        child: IconButton(
                          onPressed: () {context.push("/cart");}, 
                          icon: Icon(Icons.shopping_cart, color: shadowColor,)
                        )
                      );
                    }
                  },
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
        bottom: const _ColumnaWidgetsBottom(),
        
      ),
    );
  }
}

class _ColumnaWidgetsBottom extends StatefulWidget implements PreferredSizeWidget{
  const _ColumnaWidgetsBottom();

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<_ColumnaWidgetsBottom> createState() => _ColumnaWidgetsBottomState();
}

class _ColumnaWidgetsBottomState extends State<_ColumnaWidgetsBottom> with SingleTickerProviderStateMixin{
  
  @override
  Widget build(BuildContext context) {

    return const Column(
      children: [
        _SearchButton(),
        Divider()
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

    final theme = Theme.of(context);
    final secondaryColor = theme.colorScheme.secondary;
    final backgroundColor = theme.colorScheme.surfaceBright;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FilledButton(
        onPressed: () {
          showSearch(
            context: context, 
            delegate: CustomSearchDelegate()
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 0.6
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          children: [Icon(Icons.search, color: secondaryColor), const SizedBox(width: 7,), Text('Search for Products or Combos', style: TextStyle(color: secondaryColor),),],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate{

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        }, 
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    throw UnimplementedError();
  }

}
