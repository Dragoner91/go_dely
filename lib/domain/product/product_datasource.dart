import 'package:go_dely/domain/product/product.dart';

abstract class IProductDatasource{

  Future<List<Product>> getProducts({int page = 1});

  Future<Product> getProductById(String id);
}