


import 'package:go_dely/domain/combo/combo.dart';

abstract class IComboRepository{

  Future<List<Combo>> getCombos({int page = 1});

  Future<Combo> getComboById(String id);
}