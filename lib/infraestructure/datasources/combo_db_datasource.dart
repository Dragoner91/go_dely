import 'package:dio/dio.dart';
import 'package:go_dely/config/constants/enviroment.dart';
import 'package:go_dely/domain/datasources/combo_datasource.dart';
import 'package:go_dely/domain/entities/product/combo.dart';
import 'package:go_dely/infraestructure/mappers/combo_mapper.dart';
import 'package:go_dely/infraestructure/models/combo_db.dart';

class ComboDBDatasource extends ComboDatasource{

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.verdeAPI,
      queryParameters: {
        
      }
    )
  );

  @override
  Future<List<Combo>> getCombos({int page = 1}) async{

    final response = await dio.get('/combos',
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

}