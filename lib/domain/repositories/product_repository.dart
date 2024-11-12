


import 'package:go_dely/domain/entities/product/product.dart';

abstract class ProductRepository{

  Future<List<Product>> getProducts({int page = 1});


}