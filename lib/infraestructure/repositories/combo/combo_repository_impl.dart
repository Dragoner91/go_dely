import 'package:go_dely/domain/combo/combo_datasource.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/combo/combo_repository.dart';

class ComboRepositoryImpl extends IComboRepository {

  final IComboDatasource datasource;

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