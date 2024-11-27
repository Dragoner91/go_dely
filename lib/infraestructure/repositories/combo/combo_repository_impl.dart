


import 'package:go_dely/domain/datasources/combo_datasource.dart';
import 'package:go_dely/domain/entities/combo/combo.dart';
import 'package:go_dely/domain/repositories/combo_repository.dart';

class ComboRepositoryImpl extends ComboRepository {

  final ComboDatasource datasource;

  ComboRepositoryImpl({required this.datasource});

  @override
  Future<List<Combo>> getCombos({int page = 1}) {
    return datasource.getCombos(page: page);
  }
  
  @override
  Future<Combo> getComboById(String id) {
    return datasource.getComboById(id);
  }

  

}