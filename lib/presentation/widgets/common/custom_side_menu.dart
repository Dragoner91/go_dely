import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/theme/theme_provider.dart';
import 'package:go_dely/config/menu_items.dart';
import 'package:go_dely/presentation/screens/auth/login_screen.dart';
import 'package:go_router/go_router.dart';

class CustomSideMenu extends ConsumerStatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldkey;
  const CustomSideMenu({super.key, required this.scaffoldkey});

  @override
  ConsumerState<CustomSideMenu> createState() => _CustomSideMenuState();
}

class _CustomSideMenuState extends ConsumerState<CustomSideMenu> {

  int navDrawerIndex = 1;

  @override
  Widget build(BuildContext context) {

    final themeWatch = ref.watch(currentThemeIsDark);
    final theme = ref.watch(currentThemeIsDark.notifier);


    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Stack(
        children: [
          NavigationDrawer(
            selectedIndex: navDrawerIndex,
            backgroundColor: const Color(0xff5D9558),
            indicatorColor: const Color.fromARGB(255, 113, 176, 107),
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(28, 5, 16, 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person_2_outlined, 
                      ),
                    ),
                    SizedBox(width: 16),
                    Text('User Info', style: TextStyle(color: Colors.white))
                  ],
                )
              ),
              ...appMenuItems
                .map(
                  (item) => NavigationDrawerDestination(
                  icon: Icon(item.icon, color: Colors.white,), 
                  label: Text(item.title, style: const TextStyle(color: Colors.white)),
                  ),
                ),
              const SizedBox(height: 280),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.go("/welcome");
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.logout_outlined, color: Colors.white,),
                            SizedBox(width: 16),
                            Text('Logout', style: TextStyle(color: Colors.white))
                          ],
                        ),
                      )
                      
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text('Version 1.0.0', style: TextStyle(color: Colors.white, fontSize: 10)),
                  const Text('2024 GoDely. All rights reserved.', style: TextStyle(color: Colors.white, fontSize: 10))
                ],
              )
            ],
            onDestinationSelected: (value) {
              setState(() {
                navDrawerIndex = value;
              });

              final menuItem = appMenuItems[value];
              /*
              context.push(menuItem.link);
              */
              //widget.scaffoldkey.currentState?.closeDrawer();

            },
          ),
          Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            onPressed: () {
              ref.read(currentThemeIsDark.notifier).update((state) => !state);
            },
            icon: FadeIn(
              delay: const Duration(milliseconds: 200),
              child: Icon(
                theme.state 
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined,
                size: 20, 
                color: Colors.white,),
            ),
          ),
        ),
        ]
      ),
    );
  }
}