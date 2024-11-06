import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_dely/presentation/widgets/widgets.dart';

class HomeProvisional extends StatelessWidget {
  const HomeProvisional({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldkey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: scaffoldkey,
        appBar: AppBar(),
        drawer: FadeInUpBig(duration: const Duration(milliseconds: 400),child: CustomSideMenu(scaffoldkey: scaffoldkey),),
        bottomNavigationBar: const BottomAppBarCustom()
        );
  }
}