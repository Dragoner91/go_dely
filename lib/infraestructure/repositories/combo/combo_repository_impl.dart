import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/combo/i_combo_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/i_petition.dart';
import 'package:go_dely/infraestructure/mappers/combo_mapper.dart';
import 'package:go_dely/infraestructure/models/combo_db.dart';

class ComboRepositoryImpl extends IComboRepository {
  final IPetition petition;

  ComboRepositoryImpl({required this.petition});

  @override
  Future<Result<List<Combo>>> getCombos(GetCombosDto dto) async {
    
    var queryParameters = {
      'perpage': '5',
      'page': dto.page.toString(),
      if (dto.filter != null) 'filter' : dto.filter.toString(),
      if (dto.categoryId != null) 'category' : dto.categoryId.toString(),
      if (dto.search != null) 'search' : dto.search.toString(),
    };

    var queryString = Uri(queryParameters: queryParameters).query;

    final result = await petition.makeRequest(
      urlPath: '/combos/many?$queryString',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Combo> combos = [];
        for (var combo in data) {
          combos.add(
            ComboMapper.comboToEntity(
              ComboDB.fromJson(combo)
            )
          );
        }
        return combos;
      },
    );
    return result;
  }
  
  @override
  Future<Result<Combo>> getComboById(String id) async {
    final response = await petition.makeRequest(
      urlPath: '/combos/$id',
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