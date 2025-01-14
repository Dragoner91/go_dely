


import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/category/category.dart';

abstract class ICategoryRepository{

  Future<Result<List<Category>>> getProducts(GetCategoriesDto dto);

  Future<Result<Category>> getCategoryById(GetCategoryByIdDto dto);

}