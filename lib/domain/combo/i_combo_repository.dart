import 'package:go_dely/core/result.dart';
import 'package:go_dely/domain/combo/combo.dart';

class GetCombosDto {
  final int page;
  final String? filter;
  final String? categoryId;
  final String? search;

  GetCombosDto({
    required this.page,
    this.filter,
    this.categoryId,
    this.search,
  });
}


abstract class IComboRepository{

  Future<Result<List<Combo>>> getCombos(GetCombosDto dto);

  Future<Result<Combo>> getComboById(String id);
}