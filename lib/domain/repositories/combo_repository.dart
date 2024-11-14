


import 'package:go_dely/domain/entities/product/combo.dart';

abstract class ComboRepository{

  Future<List<Combo>> getCombos({int page = 1});


}