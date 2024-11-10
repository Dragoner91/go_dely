import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_dely/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
          title: const Text("Cart"),
          centerTitle: true,
          leading: IconButton(onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      drawer: FadeInUpBig(duration: const Duration(milliseconds: 400),child: CustomSideMenu(scaffoldkey: scaffoldkey),),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(5),
        child: SizedBox(
            height: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                _CheckoutInfo(),
                _CheckoutButton(),
              ],
            )
          ),
      ),
      body: _Content()
    );
  }
}

class _CheckoutInfo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            SizedBox(width: 40,),
            Text("Subtotal: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Spacer(),
            Text("\$200", style: TextStyle(fontSize: 16)),
            SizedBox(width: 40,),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 40,),
            Text("Shipping: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Spacer(),
            Text("\$20", style: TextStyle(fontSize: 16)),
            SizedBox(width: 40,),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 40,),
            Text("Discount: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            Spacer(),
            Text("\$20", style: TextStyle(fontSize: 16, color: Colors.red)),
            SizedBox(width: 40,),
          ],
        ),
        Row(
          children: [
            SizedBox(width: 40,),
            Text("Total: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            Spacer(),
            Text("\$200", style: TextStyle(fontSize: 16)),
            SizedBox(width: 40,),
          ],
        ),
      ],
    );
  }
}


class _CheckoutButton extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
          height: 50,
          width: double.infinity,
          child: FilledButton(
            style: ButtonStyle(backgroundColor: WidgetStateProperty.all(const Color(0xFF5D9558))),
            onPressed: () { context.push("/checkout"); },
            child: const Text("Proceed to checkout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal), )
          ),
        ),
    );
  }
}

class _Content extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          _Item(),
          _Item(),
          _Item(),
          _Item(),
          _Item(),
          _Item(),
          _Item(),
          _Item(),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: SizedBox(
          height: 120,
          width: double.infinity,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: SizedBox(
                  width: 80,
                  child: Placeholder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 100,
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Text("Product Name", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Product Description", style: TextStyle(fontWeight: FontWeight.w500),),
                          Text("Product Weight", style: TextStyle(fontWeight: FontWeight.w500),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('10\$', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                          Row(
                            children: [
                              IconButton(icon: const Icon(Icons.remove_circle_outline_outlined, color: Color(0xFF5D9558), size: 30,), onPressed: () {
                                
                              },),
                              Container(
                                width: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(shape: BoxShape.rectangle, border: Border.all(width: 1, color: const Color(0xFF5D9558))),
                                child: const Text('1', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
                              ),
                              IconButton(icon: const Icon(Icons.add_circle_outline_outlined, color: Color(0xFF5D9558), size: 30,), onPressed: () {
                                
                              },)
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
















