

import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/infraestructure/models/product_db.dart';

class ProductMapper{

  static Product productToEntity(ProductDB productDB) => 
    Product(
      id: productDB.id, 
      name: productDB.name, 
      price: productDB.price, 
      description: productDB.description, 
      imageUrl: productDB.imageUrl.map((e) => e.toString()).toList(), 
      weight: productDB.weight, 
      currency: productDB.currency, 
      stock: productDB.stock, 
      categories: productDB.categories,
      discount: productDB.discount,
      measurement: productDB.measurement
    ); 
}