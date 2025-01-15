abstract class ProductAbstract {
  
  final String id;
  final String name;
  final String description;
  final List<String> categories;
  final double price;
  final String currency; 
  final String discount; 




  ProductAbstract({
    required this.id, 
    required this.name, 
    required this.price, 
    required this.description, 
    required this.categories, 
    required this.currency,
    required this.discount
    });
  
}