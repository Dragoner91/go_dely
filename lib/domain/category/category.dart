import 'package:go_dely/domain/combo/i_combo_repository.dart';
import 'package:go_dely/domain/product/i_product_repository.dart';

class Category{

  final String id;
  final String name;
  final String imageUrl;

 Category({required this.id, required this.imageUrl, required this.name});

  @override
  String toString() {
    return name;
  }
}

class GetCategoryByIdDto {
  
  final String id;
  final GetCombosDto? combosDto;
  final GetProductsDto? productsDto;

  GetCategoryByIdDto({required this.id, this.combosDto, this.productsDto});

}

class GetCategoriesDto {
  
}

