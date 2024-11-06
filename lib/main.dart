import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_dely/presentation/screens/common/bottom_app_bar.dart';
import 'package:go_dely/presentation/screens/common/custom_side_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final scaffoldkey = GlobalKey<ScaffoldState>();

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        key: scaffoldkey,
        appBar: AppBar(),
        drawer: FadeInUpBig(child: CustomSideMenu(scaffoldkey: scaffoldkey)),
        bottomNavigationBar: BottomAppBarCustom()
        ),
    );
  }
}
