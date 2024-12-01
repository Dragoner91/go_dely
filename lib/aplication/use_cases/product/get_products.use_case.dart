import 'package:go_dely/core/result.dart';
import 'package:go_dely/core/use_case.dart';
import 'package:go_dely/domain/product/product.dart';
import 'package:go_dely/domain/product/i_product_repository.dart';

class GetProductsUseCase extends IUseCase<GetProductsDto, List<Product>> {
  final IProductRepository productRepository;

  GetProductsUseCase(this.productRepository);

  @override
  Future<Result<List<Product>>> execute(GetProductsDto dto) async {
    return await productRepository.getProducts(dto);
  }
}