import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/domain/product/i_product_repository.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';
import 'package:go_dely/infraestructure/mappers/product_mapper.dart';
import 'package:go_dely/infraestructure/models/product_db.dart';

class ProductRepositoryImpl extends IProductRepository {
  final IPetition petition;
  final IAuthRepository auth;

  ProductRepositoryImpl({required this.petition, required this.auth});

  @override
  Future<Result<List<Product>>> getProducts(GetProductsDto dto) async {

    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    var queryParameters = {
      'perpage': '5',
      'page': dto.page.toString(),
      if (dto.filter != null) 'filter' : dto.filter.toString(),
      if (dto.categoryId != null) 'category' : dto.categoryId.toString(),
      if (dto.search != null) 'search' : dto.search.toString(),
    };

    var queryString = Uri(queryParameters: queryParameters).query;

    final result = await petition.makeRequest(
      urlPath: '/product/many?$queryString',
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

    @override
  Future<Result<Product>> getProductById(String id) async {

    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    final response = await petition.makeRequest(
      urlPath: '/product/one/$id',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        final Product product = ProductMapper.productToEntity(
          ProductDB.fromJson(data)
        );
        return product;
      },
    );
    return response;
  }

}