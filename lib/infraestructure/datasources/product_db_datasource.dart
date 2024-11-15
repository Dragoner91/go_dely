import 'package:dio/dio.dart';
import 'package:go_dely/config/constants/enviroment.dart';
import 'package:go_dely/domain/datasources/product_datasource.dart';
import 'package:go_dely/domain/entities/product/product.dart';
import 'package:go_dely/infraestructure/mappers/product_mapper.dart';
import 'package:go_dely/infraestructure/models/product_db.dart';

class ProductDBDatasource extends ProductDatasource{

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.verdeAPI,
      queryParameters: {
        
      }
    )
  );

  @override
  Future<List<Product>> getProducts({int page = 1}) async{

    final response = await dio.get('/products?limit=5&offset=$page',
      queryParameters: {
        //'page': page
      }
    );

    final List<Product> products = List<Product>.from(
      response.data.map(
          (productsJson) => ProductMapper.productToEntity(
            ProductDB.fromJson(productsJson)
          )
        )
      );

    return products;
    
  }

  @override
  Future<Product> getProductById(String id) async {
    final response = await dio.get('/product/$id',
      queryParameters: {
        
      }
    );

    final Product product = 
      response.data.map(
          (productsJson) => ProductMapper.productToEntity(
            ProductDB.fromJson(productsJson)
          )
        );

    return product;
  }


}