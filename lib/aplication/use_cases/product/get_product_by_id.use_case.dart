
import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/domain/product/i_product_repository.dart';

class GetProductByIdDto {
  final String id;

  GetProductByIdDto(this.id,);
}

class GetProductByIdUseCase extends IUseCase<GetProductByIdDto, Product> {
  final IProductRepository productRepository;

  GetProductByIdUseCase(this.productRepository);

  @override
  Future<Result<Product>> execute(GetProductByIdDto dto) async {
    return await productRepository.getProductById(dto.id);
  }

}

