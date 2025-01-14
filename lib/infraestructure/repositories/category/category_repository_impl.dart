

import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/category/category.dart';
import 'package:go_dely/domain/category/i_category_repository.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';
import 'package:go_dely/infraestructure/mappers/category_mapper.dart';
import 'package:go_dely/infraestructure/models/category_db.dart';

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
  Future<Result<List<Category>>> getProducts(GetCategoriesDto dto) async {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

}