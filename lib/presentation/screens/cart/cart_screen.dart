import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/config/helpers/human_formats.dart';
import 'package:go_dely/infraestructure/entities/cart/cart_items.dart';
import 'package:go_dely/presentation/providers/cart/cart_items_provider.dart';
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
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        drawer: FadeInUpBig(
          duration: const Duration(milliseconds: 400),
          child: CustomSideMenu(scaffoldkey: scaffoldkey),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(5),
          child: SizedBox(
              height: 165,
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
              )),
        ),
        body: _Content());
  }
}

class _CheckoutInfo extends ConsumerStatefulWidget {
  @override
  ConsumerState<_CheckoutInfo> createState() => _CheckoutInfoState();
}

class _CheckoutInfoState extends ConsumerState<_CheckoutInfo> {
  Future<double> calculateSubtotal() async {
    final items =
        await ref.read(cartItemsProvider.notifier).getAllItemsFromCart();
    double subtotal =
        items.fold(0, (sum, item) => sum + (item.price * item.quantity));
    return subtotal;
  }

  Future<double> calculateShipping() async {
    final items = await ref
        .read(cartItemsProvider.notifier)
        .getAllItemsFromCart(); //* Implementar el calculo del envio cuando se haga en el back
    double subtotal = items.fold(0, (sum, item) => sum + item.price);
    return subtotal;
  }

  Future<double> calculateDiscount() async {
    final items = await ref
        .read(cartItemsProvider.notifier)
        .getAllItemsFromCart(); //* Implementar descuento cuando se haga en el back
    double subtotal = items.fold(0, (sum, item) => sum + item.price);
    return subtotal;
  }

  Future<double> calculateTotal() async {
    double subtotal = await calculateSubtotal(); //* Acomodar cuando se haga lo demas
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {

    final cartItems = ref.watch(cartItemsProvider);

    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            const Text("Subtotal: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Spacer(),
            FutureBuilder(
              future: calculateSubtotal(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                } else {
                  return FadeIn(
                    duration: const Duration(milliseconds: 200),
                    child: Text('${HumanFormarts.numberCurrency(snapshot.data!)} USD',
                        style: const TextStyle(
                            fontSize:
                                16)),
                  ); //* Cambiar despues para que traiga el currency
                }
              },
            ),
            const SizedBox(
              width: 40,
            ),
          ],
        ),
        const Row(
          children: [
            SizedBox(
              width: 40,
            ),
            Text("Shipping: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Spacer(),
            Text("0 USD", style: TextStyle(fontSize: 16)),
            SizedBox(
              width: 40,
            ),
          ],
        ),
        const Row(
          children: [
            SizedBox(
              width: 40,
            ),
            Text(
              "Discount: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Spacer(),
            Text("0 USD", style: TextStyle(fontSize: 16, color: Colors.red)),
            SizedBox(
              width: 40,
            ),
          ],
        ),
        const Divider(
          height: 5,
        ),
        Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            const Text(
              "Total: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Spacer(),
            FutureBuilder(
              future: calculateTotal(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                } else {
                  return FadeIn(
                    duration: const Duration(milliseconds: 200),
                    child: Text('${HumanFormarts.numberCurrency(snapshot.data!)} USD',
                        style: const TextStyle(
                            fontSize:
                                16)),
                  ); //* Cambiar despues para que traiga el currency
                }
              },
            ),
            const SizedBox(
              width: 40,
            ),
          ],
        ),
      ],
    );
  }
}

class _CheckoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: FilledButton(
            style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xFF5D9558))),
            onPressed: () {
              context.push("/checkout");
            },
            child: const Text(
              "Proceed to checkout",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal),
            )),
      ),
    );
  }
}

class _Content extends ConsumerStatefulWidget {
  @override
  ConsumerState<_Content> createState() => _ContentState();
}

class _ContentState extends ConsumerState<_Content> {
  @override
  Widget build(BuildContext context) {
    final cartItemsFuture =
        ref.watch(cartItemsProvider.notifier).watchAllItemsFromCart();

    return SingleChildScrollView(
        child: Column(children: [
          FutureBuilder<Stream<List<CartItem>>>(
            future: cartItemsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(height: 150 ,child: Center(child: CircularProgressIndicator()));
              } else {
                final cartItemsStream = snapshot.data!;
                return StreamBuilder<List<CartItem>>(
                  stream: cartItemsStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(height: 150 ,child: Center(child: CircularProgressIndicator()));
                    } else {
                      final items = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return _Item(cartItem: items[index]);
                        },
                      );
                    }
                  },
                );
              }
            },
          )
        ]
      )
    );
  }
}

class _Item extends ConsumerStatefulWidget {
  final CartItem cartItem;

  const _Item({required this.cartItem});

  @override
  ConsumerState<_Item> createState() => _ItemState();
}

class _ItemState extends ConsumerState<_Item> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) async {
        // Lógica para eliminar el producto de la base de datos
        ref.read(cartItemsProvider.notifier).removeItemFromCart(widget.cartItem.isarId!.toInt());

        // Mostrar un mensaje de confirmación
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${widget.cartItem.name} eliminado')),
        );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black26, width: 1),
          ),
          child: SizedBox(
              height: 120,
              width: double.infinity,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: 80,
                      child: Image.network(
                        widget.cartItem.image,
                        fit: BoxFit.contain,
                        height: 150,
                        width: 150,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress != null) {
                            return const Center(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Padding(
                                  padding: EdgeInsets.all(45),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFF5D9558),
                                  ),
                                ),
                              ),
                            );
                          }
                          return FadeIn(child: child);
                        },
                      ),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 120),
                                child: Text(
                                  widget.cartItem.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  softWrap: true,
                                  overflow: TextOverflow
                                      .ellipsis, // Cambia esto a TextOverflow.visible si prefieres
                                  maxLines:
                                      4, // Ajusta el número de líneas según sea necesario
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${widget.cartItem.price} ${widget.cartItem.currency}",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    disabledColor: Colors.black26,
                                    color: const Color(0xFF5D9558),
                                    icon: const Icon(
                                      Icons.remove_circle_outline_outlined,
                                      size: 30,
                                    ),
                                    //* decrementar cantidad item
                                    onPressed: widget.cartItem.quantity == 1 
                                      ? null 
                                      : () async {
                                          await ref.read(cartItemsProvider.notifier).decrementItem(widget.cartItem.id);
                                        },
                                  ),
                                  Container(
                                      width: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                              width: 1,
                                              color: const Color(0xFF5D9558))),
                                      child: Text(
                                        widget.cartItem.quantity.toString(),
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_circle_outline_outlined,
                                      color: Color(0xFF5D9558),
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      //* aumentar cantidad item
                                      ref
                                          .read(cartItemsProvider.notifier)
                                          .incrementItem(widget.cartItem.id);
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
