import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/domain/product/product_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';
import 'package:go_dely/infraestructure/mappers/product_mapper.dart';
import 'package:go_dely/infraestructure/models/product_db.dart';

class ProductRepositoryImpl extends IProductRepository {
 final IPetition petition;

  ProductRepositoryImpl({required this.petition});


  @override
  Future<Result<List<Product>>> getProducts(GetProductsDto dto) async {

    var queryParameters = {
      'perpage': '5',
      'page': dto.page.toString(),
      if (dto.filter != null) 'filter' : dto.filter.toString(),
      if (dto.categoryId != null) 'category' : dto.categoryId.toString(),
      if (dto.search != null) 'search' : dto.search.toString(),
    };

    var queryString = Uri(queryParameters: queryParameters).query;

    final result = await petition.makeRequest(
      urlPath: '/products?$queryString',
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
    final response = await petition.makeRequest(
      urlPath: '/products/$id',
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