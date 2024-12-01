import 'package:get_it/get_it.dart';
import 'package:go_dely/aplication/use_cases/product/get_product_by_id.use_case.dart';
import 'package:go_dely/aplication/use_cases/product/get_products.use_case.dart';
import 'package:go_dely/infraestructure/datasources/petitions/petition_impl.dart';
import 'package:go_dely/infraestructure/repositories/combo/combo_repository_impl.dart';
import 'package:go_dely/infraestructure/repositories/product/product_repository_impl.dart';





class IoCContainer {
  static Future<void> init() async {
    final getIt = GetIt.instance;

    //*COMMONS
    final petitions = PetitionImpl();

    //*REPOSITORIES
    final productRepository = ProductRepositoryImpl(petition: petitions);
    getIt.registerSingleton<ProductRepositoryImpl>(productRepository);
    // final comboRepository = ComboRepositoryImpl(petition: petition);

    //*USE CASES
    final getProductsUseCase = GetProductsUseCase(productRepository);
    final getProductByIdUseCase = GetProductByIdUseCase(productRepository);

    getIt.registerSingleton<GetProductByIdUseCase>(getProductByIdUseCase);
    
  }
}