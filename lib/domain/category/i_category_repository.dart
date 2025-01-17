


import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/category/category.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/product/product.dart';

abstract class ICategoryRepository{

  Future<Result<List<Category>>> getCategories(GetCategoriesDto dto);

  Future<Result<Category>> getCategoryById(GetCategoryByIdDto dto);

  Future<Result<List<Combo>>> getCombosFromCategory(GetCategoryByIdDto dto);
  
  Future<Result<List<Product>>> getProductsFromCategory(GetCategoryByIdDto dto);

}