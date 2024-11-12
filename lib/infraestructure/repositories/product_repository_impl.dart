

import 'package:go_dely/domain/datasources/product_datasource.dart';
import 'package:go_dely/domain/entities/product/product.dart';
import 'package:go_dely/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {

  final ProductDatasource datasource;

  ProductRepositoryImpl({required this.datasource});

  @override
  Future<List<Product>> getProducts({int page = 1}) {
    return datasource.getProducts(page: page);
  }

}