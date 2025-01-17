
import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/category/category.dart';
import 'package:go_dely/domain/category/i_category_repository.dart';

class GetCategoriesUseCase extends IUseCase<GetCategoriesDto, List<Category>> {
  final ICategoryRepository categoryRepository;

  GetCategoriesUseCase(this.categoryRepository);

  @override
  Future<Result<List<Category>>> execute(GetCategoriesDto dto) async {
    return await categoryRepository.getCategories(dto);
  }
}