

class ICart {
  final String id;
  final String name;
  final String description;
  final List<String> categories;
  final double price;
  final String currency;
  final String image; 
  final String type;
  final double discount;
  int quantity;

  ICart({
    required this.quantity, 
    required this.categories, 
    required this.currency, 
    required this.description, 
    required this.id, 
    required this.image, 
    required this.name, 
    required this.price,
    required this.type,
    required this.discount
  });

}
