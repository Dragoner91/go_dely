import 'package:flutter/material.dart';

class BottomAppBarCustom extends StatelessWidget {
  const BottomAppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 90,
      shape: const AutomaticNotchedShape(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)))),
      child: Row(
        children: [
          const Padding(padding: EdgeInsets.only(left: 5)),
          SingleChildScrollView(
            child: Column(children: [
              IconButton(
                icon: const Icon(Icons.discount_outlined),
                onPressed: () {},
              ),
              const Text("Offers")
            ]),
          ),
          const Padding(padding: EdgeInsets.only(left: 25)),
          SingleChildScrollView(
            child: Column(children: [
              IconButton(
                icon: const Icon(Icons.copy_outlined),
                onPressed: () {},
              ),
              const Text("Catalog")
            ]),
          ),
          const Padding(padding: EdgeInsets.only(left: 20)),
          CircleAvatar(
            backgroundColor: const Color(0xFF5D9558),
            radius: 34,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              TextButton(
                child: Container(
                  alignment: Alignment.center,
                  child: const Column(children: [
                    Icon(Icons.home_outlined, color: Colors.white),
                    Text("Home", style: TextStyle(color: Colors.white, fontSize: 12))
                  ]),
                ),
                onPressed: () {},
              ),
            ]),
          ),
          const Padding(padding: EdgeInsets.only(right: 20)),
          SingleChildScrollView(
            child: Column(children: [
              IconButton(
                icon: const Icon(Icons.task_outlined),
                onPressed: () {},
              ),
              const Text("Orders")
            ]),
          ),
          const Padding(padding: EdgeInsets.only(right: 25)),
          SingleChildScrollView(
            child: Column(children: [
              IconButton(
                icon: const Icon(Icons.person_outline_outlined),
                onPressed: () {},
              ),
              const Text("Profile")
            ]),
          ),
        ],
      ),
    );
  }
}
