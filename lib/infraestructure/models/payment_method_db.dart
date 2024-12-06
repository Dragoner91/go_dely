class PaymentMethodDB {
  final String id;
  final String name;

  PaymentMethodDB({
    required this.id,
    required this.name,
  });

  factory PaymentMethodDB.fromJson(Map<String, dynamic> json) => PaymentMethodDB(
    id: json['id'],
    name: json['name'],
  );

}