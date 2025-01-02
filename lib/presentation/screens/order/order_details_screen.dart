import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/order/current_order_provider.dart';
import 'package:go_dely/aplication/providers/order/order_repository_provider.dart';
import 'package:go_dely/domain/cart/i_cart.dart';
import 'package:go_dely/domain/order/order.dart';
import 'package:go_router/go_router.dart';

class OrderDetailsScreen extends ConsumerStatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  ConsumerState<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {

  Future<Order> fetchOrder() async {
    await Future.delayed(const Duration(milliseconds: 700));
    final orderId = ref.read(currentOrderId.notifier).state;
    final order = await ref.read(orderRepositoryProvider).getOrderById(orderId);
    return order.unwrap();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final bottomAppBarColor = theme.colorScheme.surfaceContainer;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Summary"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor.withAlpha(124), bottomAppBarColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        child: FutureBuilder<Order>(
          future: fetchOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      strokeWidth: 4, 
                      color: Color(0xFF5D9558),
                    ),
                  )
                );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No order found'));
            } else {
              final order = snapshot.data!;
              return RefreshIndicator(
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                color: const Color(0xFF5D9558),
                onRefresh: () async {
                  setState(() {}); // Forzar la reconstrucción de la pantalla
                  await fetchOrder();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      OrderInfo(order: order),
                      ItemsInfo(order: order),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class OrderInfo extends StatelessWidget {

  final Order order;

  const OrderInfo({super.key, required this.order});

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

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final backgroundColor = theme.scaffoldBackgroundColor;
    final primaryColor = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: const Color.fromARGB(255, 186, 186, 186)),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Text("Order #", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                ), //*esperar nuevo id de orden
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5),
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getColor(order.status)
                      , // Color basado en el estado de la orden
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 10, right: 10),
                  child: Text(" ${order.status}", style: TextStyle(fontSize: 14, color: getColor(order.status)),), // Mostrar el estatus de la orden
                ),
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Delivery today at 3:00 pm", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),),
                )
              ],
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 5),
                  child: Text("Payment Method", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ), 
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(order.paymentMethod, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w100),),
                ) 
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemsInfo extends StatelessWidget {

  final Order order;

  const ItemsInfo({super.key, required this.order});


  double subtotal() {
    return 0;
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final backgroundColor = theme.scaffoldBackgroundColor;
    final primaryColor = theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: const Color.fromARGB(255, 186, 186, 186)),
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Items", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ),
                const Spacer(),
                IconButton(
                  iconSize: 18,
                  onPressed: () {
                    
                  }, 
                  icon: const Icon(Icons.edit))
              ],
            ),


            SizedBox(
              height: order.items.length * 80.0, // Ajusta la altura según el número de ítems
              child: ListView.builder(
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  final item = order.items[index];
                  return ItemsDetails(item: item);
                },
              ),
            ),


            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text("Subtotal:"),
                  const Spacer(),
                  Text("${subtotal().toString()} USD")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Text("Delivery Fee:"),
                  const Spacer(),
                  Text("${subtotal().toString()} USD")
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
              child: Row(
                children: [
                  const Text("TOTAL:"),
                  const Spacer(),
                  Text("${subtotal().toString()} USD")
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}

class ItemsDetails extends StatelessWidget {
  final ICart item;

  const ItemsDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Image.network(
              item.image,
              fit: BoxFit.contain,
              height: 50,
              width: 50,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://media.istockphoto.com/id/1396814518/vector/image-coming-soon-no-photo-no-thumbnail-image-available-vector-illustration.jpg?s=612x612&w=0&k=20&c=hnh2OZgQGhf0b46-J2z7aHbIWwq8HNlSDaNp2wn_iko=',
                  fit: BoxFit.contain,
                  height: 50,
                  width: 50,
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Text(
                        "${item.name}  (x${item.quantity})",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "${item.price} USD",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  item.description,
                  style: const TextStyle(fontSize: 8),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}