import 'package:go_dely/domain/entities/combo/combo.dart';

abstract class ComboDatasource{

  Future<List<Combo>> getCombos({int page = 1});

  Future<Combo> getComboById(String id);
}