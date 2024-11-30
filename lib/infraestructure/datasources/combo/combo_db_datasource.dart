import 'package:dio/dio.dart';
import 'package:go_dely/config/constants/enviroment.dart';
import 'package:go_dely/domain/combo/combo_datasource.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/infraestructure/mappers/combo_mapper.dart';
import 'package:go_dely/infraestructure/models/combo_db.dart';

class ComboDBDatasource extends IComboDatasource{

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.verdeAPI,
      queryParameters: {
        
      }
    )
  );

  @override
  Future<List<Combo>> getCombos({int page = 1}) async{

    final response = await dio.get('/combos?perpage=5&page=$page',
      queryParameters: {
        //'page': page
      }
    );
    
    final List<Combo> combos = List<Combo>.from(
      response.data.map(
          (combosJson) => ComboMapper.comboToEntity(
            ComboDB.fromJson(combosJson)
          )
        )
      );

    return combos;
    
  }


   @override
  Future<Combo> getComboById(String id) async {
    final response = await dio.get('/combos/$id',
      queryParameters: {
        
      }
    );

    final Combo combo = ComboMapper.comboToEntity(
      ComboDB.fromJson(response.data)
    );

    
    return combo;
  }

}