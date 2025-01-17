import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/aplication/providers/backend_provider.dart';
import 'package:go_dely/aplication/providers/bottom_appbar_provider.dart';
import 'package:go_dely/aplication/providers/order/current_order_provider.dart';
import 'package:go_dely/aplication/providers/order/order_repository_provider.dart';
import 'package:go_dely/aplication/providers/order/order_selected_provider.dart';
import 'package:go_dely/aplication/use_cases/order/get_orders.use_case.dart';
import 'package:go_dely/domain/order/i_order_repository.dart';
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

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final bottomAppBarColor = theme.colorScheme.surfaceContainer;

    return Scaffold(
      appBar: AppBar(
          title: const Text("Orders"),
          centerTitle: true,
          backgroundColor: primaryColor.withAlpha(124),
          leading: IconButton(
            onPressed: () {
              context.go("/home");
              ref.read(currentStateNavBar.notifier).update((state) => 2);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
      bottomNavigationBar: const BottomAppBarCustom(),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor.withAlpha(124), bottomAppBarColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const _Content()
        ),
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

  List<Order> _ordersActive = [];
  List<Order> _ordersPast = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final orderDto = GetOrdersDto(perPage: 15, page: 1, backSelected: ref.read(currentBackendProvider.notifier).state);
    final orders = await GetIt.instance.get<GetOrdersUseCase>().execute(orderDto);
    if(orders.isError){
      return;
    }
    setState(() {
      _ordersActive = orders.unwrap().where((order) => ((order.status == 'CREATED') | (order.status == 'BEING PROCESSED') | (order.status == 'SHIPPED'))).toList();
      _ordersPast = orders.unwrap().where((order) => ((order.status == 'CANCELLED') | (order.status == 'DELIVERED'))).toList();
    });
  }

  Future<List<Order>> getOrders() async {
    final ordersDto = GetOrdersDto(perPage: 15, page: 1, backSelected: ref.read(currentBackendProvider.notifier).state);
    final orders = await ref.read(orderRepositoryProvider).getOrders(ordersDto);
    final selected = ref.read(orderSelectedProvider.notifier).state;
    final List<Order> ordersSelected;
    if(orders.isError){
      return [];
    }
    if(selected == "Active Orders"){
      ordersSelected = orders.unwrap().where((order) => ((order.status == 'CREATED') | (order.status == 'BEING PROCESSED') | (order.status == 'SHIPPED'))).toList();
    } else {
      ordersSelected = orders.unwrap().where((order) => ((order.status == 'CANCELLED') | (order.status == 'DELIVERED'))).toList();
    }
    return ordersSelected;
  }

  Future<String> getActiveQuantity() async {
    return _ordersActive.length.toString();
  }

  Future<String> getPastQuantity() async {
    return _ordersPast.length.toString();
  }

  Future<List<String>> getOrderQuantities() async {

  return [await getActiveQuantity(), await getPastQuantity()];
}

  Future<List<String>> getQuantities() async {
    final activeQuantity = await getActiveQuantity();
    final pastQuantity = await getPastQuantity();
    return [activeQuantity, pastQuantity];
  }

  void refreshState() {
    setState(() {
      _loadOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderSelected = ref.read(orderSelectedProvider.notifier).state;

    final controller = ValueNotifier(orderSelected);
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;
    final backgroundColor = theme.colorScheme.surfaceContainer;
    final shadowColor = theme.colorScheme.shadow;

    controller.addListener(() {
      ref.read(orderSelectedProvider.notifier).update((state) => controller.value);
      setState(() {});
    });

    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      color: const Color(0xFF5D9558),
      onRefresh: () async {
        setState(() {}); // Forzar la reconstrucción de la pantalla
        await getOrders();
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              child: FutureBuilder<List<String>>(
                future: getQuantities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  } else if (snapshot.hasError) {
                    return const SizedBox();
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const SizedBox();
                  } else {
                    final quantities = snapshot.data!;
                    final activeQuantity = quantities[0];
                    final pastQuantity = quantities[1];
                    return AdvancedSegment(
                      controller: controller, // AdvancedSegmentController
                      segments: { // Map<String, String>
                        'Active Orders': 'Active ($activeQuantity)',
                        'Past Orders': 'Past Orders ($pastQuantity)',
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
                      animationDuration: const Duration(seconds: 2), // Duration
                    );
                  }
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                FutureBuilder<List<Order>>(
                  future: getOrders(), // Llama a la función que obtiene las órdenes
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: MediaQuery.of(context).size.height*0.3,),
                                  const SizedBox(
                                    width: 80.0, // Ancho deseado
                                    height: 80.0, // Alto deseado
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              ),
                            );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error loading orders: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height*0.25,),
                            Icon(Icons.list_alt, size: 100, color: shadowColor),
                            const SizedBox(height: 20),
                            Text(
                              'No Orders Available',
                              style: TextStyle(fontSize: 24, color: shadowColor),
                            ),
                          ],
                        ),
                      );
                    } else {
                      final orders = snapshot.data!;
                      return Column(
                        children: orders.map((order) => _OrderContent(order: order, onRefresh: refreshState)).toList(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _OrderContent extends ConsumerStatefulWidget {

  final VoidCallback onRefresh;
  final Order order;

  const _OrderContent({required this.order, required this.onRefresh});

  @override
  ConsumerState<_OrderContent> createState() => _OrderContentState();
}

class _OrderContentState extends ConsumerState<_OrderContent> {
  Color getColor(String status) {
    switch (status) {
      case 'CREATED':
        return Colors.blue;
      case 'CANCELLED':
        return Colors.red;
      case 'DELIVERED':
        return Colors.green;
      case 'SHIPPED':
        return Colors.yellow;
      case 'BEING PROCESSED':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String getOrderItemsText() {
    return widget.order.items.map((item) => '${item.name} (x${item.quantity})').join(', \n');
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
        height: 200 + (widget.order.items.length * 20.0),
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
                      ref.read(currentOrderId.notifier).update((state) => widget.order.uuid,);
                      context.push("/orderDetails");
                    },
                    icon: const Icon(Icons.keyboard_double_arrow_down_rounded),
                  ),
                  Expanded(
                    child: Text(
                      "${widget.order.total} ${widget.order.currency}",
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
                  child: Text("Order #${widget.order.id}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                ),
                const Spacer()
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Expanded(
                    child: Text(
                      getOrderItemsText(),
                      style: const TextStyle(fontSize: 12),
                      softWrap: true,
                      maxLines: widget.order.items.length,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5),
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getColor(widget.order.status)
                      , // Color basado en el estado de la orden
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5),
                  child: Text(" ${widget.order.status}", style: const TextStyle(fontSize: 14),), // Mostrar el estatus de la orden
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
                      ['DELIVERED'].contains(widget.order.status)
                      ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
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
                      )
                      : const SizedBox(),
                      ['CANCELLED', 'DELIVERED'].contains(widget.order.status)
                      ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
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
                      )
                      : const SizedBox(),
                      ['CANCELLED', 'DELIVERED'].contains(widget.order.status)
                      ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
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
                      )
                      : const SizedBox(),
                      ['CREATED', 'BEING PROCESSED'].contains(widget.order.status)
                      ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: FilledButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.warning_rounded, color: Colors.yellowAccent.shade400),
                                        const Text("  WARNING  "),
                                        Icon(Icons.warning_rounded, color: Colors.yellowAccent.shade400),
                                      ],
                                    ),
                                    content: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Do you want to cancel this order?"),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text("NO"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      const SizedBox(width: 100),
                                      TextButton(
                                        child: const Text("YES", style: TextStyle(color: Colors.red),),
                                        onPressed: () async {
                                          final changeStatusDto = ChangeStatusDto(id: widget.order.uuid, status: 'CANCELLED');
                                          await ref.read(orderRepositoryProvider).changeStatus(changeStatusDto);
                                          print("cambio");
                                          widget.onRefresh();
                                          Navigator.of(context).pop(); // Close the error dialog
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              padding: WidgetStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(vertical: 5), // Ajusta el padding vertical
                              ),
                              backgroundColor: WidgetStateProperty.all<Color>(Colors.redAccent.shade400), // Cambia el color de fondo del botón
                            ),
                            child: const Text("Cancel Order", style: TextStyle(color: Colors.white)), // Cambia el color del texto
                          ),
                        ),
                      )
                      : const SizedBox(),
                      ['BEING PROCESSED', 'SHIPPED'].contains(widget.order.status)
                      ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
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
                              backgroundColor: WidgetStateProperty.all<Color>(Colors.teal), // Cambia el color de fondo del botón
                            ),
                            child: const Text("Track Order", style: TextStyle(color: Colors.white)), // Cambia el color del texto
                          ),
                        ),
                      )
                      : const SizedBox(),
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