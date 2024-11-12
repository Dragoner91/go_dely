import 'package:flutter/material.dart';
import 'package:go_dely/config/menu_items.dart';

class CustomSideMenu extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldkey;
  const CustomSideMenu({super.key, required this.scaffoldkey});

  @override
  State<CustomSideMenu> createState() => _CustomSideMenuState();
}

class _CustomSideMenuState extends State<CustomSideMenu> {

  int navDrawerIndex = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.7,
      child: NavigationDrawer(
        selectedIndex: navDrawerIndex,
        backgroundColor: const Color(0xff5D9558),
        indicatorColor: const Color.fromARGB(255, 113, 176, 107),
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 0, 16, 10),
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
              label: Text(item.title, style: const TextStyle(color: Colors.white))
              ),
            ),
          const SizedBox(height: 280),
          const Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 70),
                  Icon(Icons.logout_outlined, color: Colors.white,),
                  SizedBox(width: 16),
                  Text('Logout', style: TextStyle(color: Colors.white))
                ],
              ),
              SizedBox(height: 15),
              Text('Version 1.0.0', style: TextStyle(color: Colors.white, fontSize: 10)),
              Text('2024 GoDely. All rights reserved.', style: TextStyle(color: Colors.white, fontSize: 10))
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
    );
  }
}