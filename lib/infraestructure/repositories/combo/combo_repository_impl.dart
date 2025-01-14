import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/combo/i_combo_repository.dart';
import 'package:go_dely/domain/product/i_product_repository.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';
import 'package:go_dely/infraestructure/mappers/combo_mapper.dart';
import 'package:go_dely/infraestructure/models/combo_db.dart';

class ComboRepositoryImpl extends IComboRepository {
  final IPetition petition;
  final IAuthRepository auth;
  final IProductRepository productRepository;

  ComboRepositoryImpl({required this.petition, required this.auth, required this.productRepository});

  @override
  Future<Result<List<Combo>>> getCombos(GetCombosDto dto) async {
    final tokenResult = await auth.getToken();
    if (tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    var queryParameters = {
      'perpage': '5',
      'page': dto.page.toString(),
      if (dto.filter != null) 'filter': dto.filter.toString(),
      if (dto.categoryId != null) 'category': dto.categoryId.toString(),
      if (dto.search != null) 'search': dto.search.toString(),
    };

    var queryString = Uri(queryParameters: queryParameters).query;

    final result = await petition.makeRequest(
      urlPath: '/bundle/many?$queryString',
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
  Future<Result<Combo>> getComboById(String id) async {

    final tokenResult = await auth.getToken();
    if(tokenResult.isError) return throw tokenResult.error;

    petition.updateHeaders(headerKey: "Authorization", headerValue: "Bearer ${tokenResult.unwrap()}");

    final response = await petition.makeRequest(
      urlPath: '/bundle/one/$id',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        final Combo combo = ComboMapper.comboToEntity(
          ComboDB.fromJson(data)
        );
        return combo;
      },
    );
    return response;
  }

  

}