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

abstract class IDiscountRepository{

  Future<Result<List<Product>>> getDiscounts(GetProductsDto dto);

  Future<Result<Product>> getDiscountById(String id);

}