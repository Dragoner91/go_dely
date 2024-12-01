import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/product/product.dart';

class GetProductsDto {
  final int page;
  final String? filter;
  final String? categoryId;
  final String? search;

  GetProductsDto({
    required this.page,
    this.filter,
    this.categoryId,
    this.search,
  });
}

abstract class IProductRepository{

  Future<Result<List<Product>>> getProducts(GetProductsDto dto);

  Future<Result<Product>> getProductById(String id);

}