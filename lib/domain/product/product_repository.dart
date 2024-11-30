import 'package:go_dely/domain/product/product.dart';

class getProductsDto {
  
}

abstract class IProductRepository{

  Future<List<Product>> getProducts({int page = 1});

  Future<Product> getProductById(String id);

}