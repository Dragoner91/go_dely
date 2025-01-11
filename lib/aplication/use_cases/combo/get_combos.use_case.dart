import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/combo/i_combo_repository.dart';

class GetCombosUseCase extends IUseCase<GetCombosDto, List<Combo>> {
  final IComboRepository comboRepository;

  GetCombosUseCase(this.comboRepository);

  @override
  Future<Result<List<Combo>>> execute(GetCombosDto dto) async {
    return await comboRepository.getCombos(dto);
  }
}