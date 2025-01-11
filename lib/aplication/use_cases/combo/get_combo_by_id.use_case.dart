import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/combo/combo.dart';
import 'package:go_dely/domain/combo/i_combo_repository.dart';

class GetComboByIdDto {
  final String id;

  GetComboByIdDto(this.id,);
}

class GetCombosByIdUseCase extends IUseCase<GetComboByIdDto, Combo> {
  final IComboRepository comboRepository;

  GetCombosByIdUseCase(this.comboRepository);

  @override
  Future<Result<Combo>> execute(GetComboByIdDto dto) async {
    return await comboRepository.getComboById(dto.id);
  }
}