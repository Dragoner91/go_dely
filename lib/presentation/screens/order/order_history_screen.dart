import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/bottom_appbar_provider.dart';
import 'package:go_dely/aplication/providers/order/order_repository_provider.dart';
import 'package:go_dely/aplication/providers/order/order_selected_provider.dart';
import 'package:go_dely/domain/order/order.dart';
import 'package:go_dely/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';

class OrderHistoryScreen extends ConsumerStatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  ConsumerState<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends ConsumerState<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Orders"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.go("/home");
              ref.read(currentStateNavBar.notifier).update((state) => 2);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
      bottomNavigationBar: const BottomAppBarCustom(),
      body: const _Content(),
    );
  }
}

class _Content extends ConsumerStatefulWidget {

  const _Content({
    super.key,
  });

  @override
  ConsumerState<_Content> createState() => _ContentState();
}

class _ContentState extends ConsumerState<_Content> {


  Future<List<Order>> getOrders() async {
    final orders = await ref.read(orderRepositoryProvider).getOrders();
    return orders.unwrap();
  }

  @override
  Widget build(BuildContext context) {

    final orderSelected = ref.read(orderSelectedProvider.notifier).state;

    final controller = ValueNotifier(orderSelected);
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;
    final backgroundColor = theme.colorScheme.surfaceContainer;

    controller.addListener(() {
      ref.read(orderSelectedProvider.notifier).update((state) => controller.value);
    });
    

    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      color: const Color(0xFF5D9558),
      onRefresh: () async {
        setState(() {}); // Forzar la reconstrucción de la pantalla
        await getOrders(); // Esperar a que se obtengan las órdenes
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: AdvancedSegment(
                controller: controller, // AdvancedSegmentController
                segments: const { // Map<String, String>
                  'Active': 'Active',
                  'Past Orders': 'Past Orders',
                },
                activeStyle: const TextStyle( // TextStyle
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                inactiveStyle: TextStyle( // TextStyle
                  color: secondaryColor,
                ),
                backgroundColor: backgroundColor, // Color
                sliderColor: primaryColor, // Color
                sliderOffset: 2.0, // Double
                borderRadius: const BorderRadius.all(Radius.circular(8.0)), // BorderRadius
                itemPadding: const EdgeInsets.symmetric( // EdgeInsets
                  horizontal: 30,
                  vertical: 10,
                ),
                animationDuration: const Duration(milliseconds: 250), // Duration
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<List<Order>>(
                    future: getOrders(), 
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(child: CircularProgressIndicator()),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error loading orders ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(child: Text('No orders available')),
                          ],
                        );
                      } else {
                        final orders = snapshot.data!;
                        return Column(
                          children: orders.map((order) => _OrderContent(order: order)).toList(),
                        );
                      }
                    },
                  ),
            
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}


class _OrderContent extends StatelessWidget {

  final Order order;

  const _OrderContent({super.key, required this.order});

  Color getColor(String status) {
    switch (status) {
      case 'CREATED':
        return Colors.blue;
      case 'CANCELLED':
        return Colors.red;
      case 'DELIVERED':
        return Colors.green;
      case 'SHIPPED':
        return Colors.orange;
      case 'BEING PROCESSED':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.scaffoldBackgroundColor;
    final primaryColor = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: const Color.fromARGB(255, 186, 186, 186)),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        height: 220,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text(
                      "Fecha",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.keyboard_double_arrow_down_rounded),
                  ),
                  Expanded(
                    child: Text(
                      "${order.total} ${order.currency}",
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 5,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5),
                  child: Text("Order #${order.id}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                ),
                const Spacer()
              ],
            ),
            const Text("Items List"),
            const Spacer(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getColor(order.status)
                      , // Color basado en el estado de la orden
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5),
                  child: Text(" ${order.status}", style: const TextStyle(fontSize: 14),), // Mostrar el estatus de la orden
                ),
                const Spacer()
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribuye los botones uniformemente
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(vertical: 5), // Ajusta el padding vertical
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(Colors.yellow.shade800), // Cambia el color de fondo del botón
                          ),
                          child: const Text("Ask Refund", style: TextStyle(color: Colors.white)), // Cambia el color del texto
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(vertical: 5), // Ajusta el padding vertical
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(primaryColor), // Cambia el color de fondo del botón
                          ),
                          child: const Text("Reorder Items", style: TextStyle(color: Colors.white)), // Cambia el color del texto
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(vertical: 5), // Ajusta el padding vertical
                            ),
                            backgroundColor: WidgetStateProperty.all<Color>(Colors.redAccent.shade200), // Cambia el color de fondo del botón
                          ),
                          child: const Text("Report a Problem", style: TextStyle(color: Colors.white)), // Cambia el color del texto
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}