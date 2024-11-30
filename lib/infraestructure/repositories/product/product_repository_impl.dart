

import 'package:go_dely/domain/product/product_datasource.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/domain/product/product_repository.dart';

class ProductRepositoryImpl extends IProductRepository {

  final IProductDatasource datasource;

  ProductRepositoryImpl({required this.datasource});

  @override
  Future<List<Product>> getProducts({int page = 1}) {
    return datasource.getProducts(page: page);
  }

  @override
  Future<Product> getProductById(String id) {
    return datasource.getProductById(id);
  }

}