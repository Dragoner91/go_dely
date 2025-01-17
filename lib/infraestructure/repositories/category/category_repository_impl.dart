

import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/category/category.dart';
import 'package:go_dely/domain/category/i_category_repository.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';
import 'package:go_dely/infraestructure/mappers/category_mapper.dart';
import 'package:go_dely/infraestructure/mappers/combo_mapper.dart';
import 'package:go_dely/infraestructure/mappers/product_mapper.dart';
import 'package:go_dely/infraestructure/models/category_db.dart';
import 'package:go_dely/infraestructure/models/combo_db.dart';
import 'package:go_dely/infraestructure/models/product_db.dart';

class CategoryRepositoryImpl implements ICategoryRepository {
  final IPetition petition;
  final IAuthRepository auth;

  CategoryRepositoryImpl({required this.petition, required this.auth});

  @override
  Future<Result<Category>> getCategoryById(GetCategoryByIdDto dto) async {
    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    final result = await petition.makeRequest(
      urlPath: '/category/one/${dto.id}',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        final Category category = CategoryMapper.categoryToEntity(
          CategoryDB.fromJson(data)
        );
        return category;
      },
    );
    return result;
  }

  @override
  Future<Result<List<Category>>> getCategories(GetCategoriesDto dto) async {
    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    final result = await petition.makeRequest(
      urlPath: '/category/many',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Category> categories = [];
        for (var item in data) {
          categories.add(
            CategoryMapper.categoryToEntity(
              CategoryDB.fromJson(item)
            )
          );
        }
        return categories;
      },
    );
    return result;
  }

  @override
  Future<Result<List<Combo>>> getCombosFromCategory(GetCategoryByIdDto dto) async {
    final tokenResult = await auth.getToken();
    if (tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    var queryParameters = {
      'perpage': '5',
      'page': dto.combosDto!.page.toString(),
    };

    var queryString = Uri(queryParameters: queryParameters).query;

    final result = await petition.makeRequest(
      urlPath: '/bundle/category/${dto.id}?$queryString',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Combo> combos = [];
        for (var combo in data) {
          var comboDB = ComboDB.fromJson(combo);
          combos.add(ComboMapper.comboToEntity(comboDB));
        }
        return combos;
      },
    );
    return result;
  }

  @override
  Future<Result<List<Product>>> getProductsFromCategory(GetCategoryByIdDto dto) async {
    final tokenResult = await auth.getToken();
    if (tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");    

    var queryParameters = {
      'perpage': '5',
      'page': dto.productsDto!.page.toString(),
    };

    var queryString = Uri(queryParameters: queryParameters).query;

    final result = await petition.makeRequest(
      urlPath: '/product/category/${dto.id}?$queryString',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Product> products = [];
        for (var product in data) {
          products.add(
            ProductMapper.productToEntity(
              ProductDB.fromJson(product)
            )
          );
        }
        return products;
      },
    );
    return result;
  }

}