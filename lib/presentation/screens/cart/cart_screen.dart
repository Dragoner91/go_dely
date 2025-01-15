import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/aplication/use_cases/discount/get_discount_by_id.use_case.dart';
import 'package:go_dely/config/helpers/human_formats.dart';
import 'package:go_dely/domain/cart/i_cart.dart';
import 'package:go_dely/domain/discount/discount.dart';
import 'package:go_dely/infraestructure/entities/cart/cart_items.dart';
import 'package:go_dely/aplication/providers/cart/cart_items_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {

  String couponCode = "";
  final MobileScannerController controller = MobileScannerController();
  bool isCameraOpen = false;
  
  @override
  void initState() {
    super.initState();
  }

  Future<void> _scanQRCode() async {

    controller.start();
    bool isBarcodeDetected = false;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: 300,
          height: 300,
          child: MobileScanner(
            controller: controller,
            onDetect: (BarcodeCapture capture) async {
              if (isBarcodeDetected) return;

              final List<Barcode> barcodes = capture.barcodes;
              final barcode = barcodes.first;

              if (barcode.rawValue != null) {
                setState(() {
                  couponCode = barcode.rawValue!;
                  print(couponCode);
                  isBarcodeDetected = true;
                });

                await controller.stop();
                if (mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final bottomAppBarColor = theme.colorScheme.surfaceContainer;

    return Scaffold(
        key: scaffoldkey,
        appBar: AppBar(
          title: const Text("Cart"),
          centerTitle: true,
          backgroundColor: primaryColor.withAlpha(124),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        floatingActionButton: CircleAvatar(
          radius: 25, // Ajusta el tamaño del botón
          backgroundColor: primaryColor,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _scanQRCode,
              borderRadius: BorderRadius.circular(20),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.discount, color: Colors.white, size: 18,),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: bottomAppBarColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
                height: 185,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    _CheckoutInfo(),
                    const SizedBox(
                      height: 15,
                    ),
                    _CheckoutButton(),
                  ],
                )),
          ),
        ),
        body: Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor.withAlpha(124), bottomAppBarColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
            child: _Content()
          )
        )
      );
  }
}

class _CheckoutInfo extends ConsumerStatefulWidget {
  @override
  ConsumerState<_CheckoutInfo> createState() => _CheckoutInfoState();
}

class _CheckoutInfoState extends ConsumerState<_CheckoutInfo> {
  Future<double> calculateSubtotal() async {
    final items = await ref.read(cartItemsProvider.notifier).getAllItemsFromCart();
    double subtotal = items.fold(0, (sum, item) => sum + item.price * item.quantity);
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
    final items = await ref.read(cartItemsProvider.notifier).getAllItemsFromCart();
    var total = 0.0;
    for (var item in items) {
      final getDiscountByIdUseCase = GetIt.instance.get<GetDiscountByIdUseCase>();
      if (item.discount != "No Discount") {
        final discountResult = await getDiscountByIdUseCase.execute(GetDiscountByIdDto(item.discount));
        final double discount = discountResult.unwrap().percentage;
        total += item.price * item.quantity * (1 - discount);
      }
    }
    return total;
  }

  Future<double> calculateTotal() async {
    final double subtotal = await calculateSubtotal();
    final double discount = await calculateDiscount();
    return subtotal - discount;
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
        Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            const Text(
              "Discount: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Spacer(),
            FutureBuilder(
              future: calculateDiscount(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                } else {
                  return FadeIn(
                    duration: const Duration(milliseconds: 200),
                    child: Text('${HumanFormarts.numberCurrency(snapshot.data!)} USD',
                        style: const TextStyle(fontSize: 16, color: Colors.red)),
                  ); //* Cambiar despues para que traiga el currency
                }
              },
            ),
            const SizedBox(
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

class _CheckoutButton extends ConsumerStatefulWidget {
  @override
  ConsumerState<_CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends ConsumerState<_CheckoutButton> {
  Future<int> getQuantity() async {
    final items = await ref.read(cartItemsProvider.notifier).getAllItemsFromCart();
    return items.length;
  }

  @override
  Widget build(BuildContext context) {

    final cartItems = ref.watch(cartItemsProvider);

    final theme = Theme.of(context);
    final scrimColor = theme.colorScheme.scrim;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: FutureBuilder<int>(
          future: getQuantity(),
          builder: (context, snapshot) {
            final isButtonEnabled = snapshot.hasData && snapshot.data! > 0;
            return FilledButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey.shade600; // Color for disabled state
                }
                return const Color(0xFF5D9558); // Default color
              },
            ),
              ),
              onPressed: isButtonEnabled ? () {
                context.push("/checkout");
              } : null,
              child: const Text(
                "Proceed to checkout",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  color: Colors.white
                ),
              ),
            );
          },
        ),
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

    final theme = Theme.of(context);
    final shadowColor = theme.colorScheme.shadow;

    return FutureBuilder<Stream<List<ICart>>>(
      future: cartItemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(height: 150 ,child: Center(child: CircularProgressIndicator()));
        } else {
          final cartItemsStream = snapshot.data!;
          return StreamBuilder<List<ICart>>(
            stream: cartItemsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(height: 150 ,child: Center(child: CircularProgressIndicator()));
              } else {
                final items = snapshot.data!;
                
                if (items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart, size: 100, color: shadowColor),
                        const SizedBox(height: 20),
                        Text(
                          'No items in the cart',
                          style: TextStyle(fontSize: 24, color: shadowColor),
                        ),
                      ],
                    ),
                  );
                }
    
    
    
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return _Item(cartItem: items[index] as CartItem);
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }
      },
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

    final backgroundColor = Theme.of(context).colorScheme.surfaceBright;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Dismissible(
        key: Key(widget.cartItem.id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) async {
          // Lógica para eliminar el producto de la base de datos
          ref.read(cartItemsProvider.notifier).removeItemFromCart(widget.cartItem.isarId!.toInt());
      
          // Mostrar un mensaje de confirmación
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${widget.cartItem.name} Eliminated')),
          );
        },
        background: Container(
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
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
