
import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/category/category.dart';
import 'package:go_dely/domain/category/i_category_repository.dart';

class GetCategoryByIdUseCase extends IUseCase<GetCategoryByIdDto, Category> {
  final ICategoryRepository categoryRepository;

  GetCategoryByIdUseCase(this.categoryRepository);

  @override
  Future<Result<Category>> execute(GetCategoryByIdDto dto) async {
    return await categoryRepository.getCategoryById(dto);
  }
}