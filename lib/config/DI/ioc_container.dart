import 'package:get_it/get_it.dart';
import 'package:go_dely/aplication/use_cases/product/get_product_by_id.use_case.dart';
import 'package:go_dely/aplication/use_cases/product/get_products.use_case.dart';
import 'package:go_dely/domain/cart/i_cart_repository.dart';
import 'package:go_dely/domain/combo/i_combo_repository.dart';
import 'package:go_dely/domain/product/i_product_repository.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/datasources/petitions/petition_impl.dart';
import 'package:go_dely/infraestructure/repositories/auth/auth_repository_impl.dart';
import 'package:go_dely/infraestructure/repositories/cart/cart_item_repository.dart';
import 'package:go_dely/infraestructure/repositories/combo/combo_repository_impl.dart';
import 'package:go_dely/infraestructure/repositories/product/product_repository_impl.dart';





class IoCContainer {
  static Future<void> init() async {
    final getIt = GetIt.instance;

    //*COMMONS
    final petitions = PetitionImpl();


    //*REPOSITORIES
    final productRepository = ProductRepositoryImpl(petition: petitions);
    getIt.registerSingleton<IProductRepository>(productRepository);
    final comboRepository = ComboRepositoryImpl(petition: petitions);
    getIt.registerSingleton<IComboRepository>(comboRepository);
    final cartRepository = CartItemRepository();
    getIt.registerSingleton<ICartRepository>(cartRepository);
    final authRepository = AuthRepositoryImpl(petition: petitions);
    getIt.registerSingleton<IAuthRepository>(authRepository);

    //*USE CASES
    final getProductsUseCase = GetProductsUseCase(productRepository);
    
    final getProductByIdUseCase = GetProductByIdUseCase(productRepository);
    getIt.registerSingleton<GetProductByIdUseCase>(getProductByIdUseCase);
    
  }
}