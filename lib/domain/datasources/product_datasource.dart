import 'package:go_dely/domain/entities/product/product.dart';

abstract class ProductDatasource{

  Future<List<Product>> getProducts({int page = 1});

  Future<Product> getProductById(String id);
}