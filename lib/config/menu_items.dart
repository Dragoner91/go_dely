import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subTitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subTitle,
      required this.link,
      required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(
    title: 'Home',
    subTitle: 'Home view',
    link: '/home',
    icon: Icons.house_outlined
  ),
  MenuItem(
    title: 'Profile',
    subTitle: 'Configure your profile',
    link: '/profile',
    icon: Icons.person_2_outlined
  ),
  MenuItem(
    title: 'Orders',
    subTitle: 'View active and previous orders',
    link: '/orders',
    icon: Icons.task_outlined
  ),
  
  
];
