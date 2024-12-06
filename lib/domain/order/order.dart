
class Order {
  final String id;
  final String address;
  final String paymentMethod;
  final String currency;
  final String status;
  final double total;
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>> combos;

  Order({
    required this.id,
    required this.address, 
    required this.combos,
    required this.currency,
    required this.paymentMethod,
    required this.products,
    required this.total,
    required this.status
    });
}