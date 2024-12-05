import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/aplication/providers/theme/theme_provider.dart';
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
import 'package:go_dely/infraestructure/repositories/theme/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';





class IoCContainer {
  static Future<void> init() async {
    final getIt = GetIt.instance;

    //*COMMONS
    final petitions = PetitionImpl();
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //*THEME
    final bool? theme = await asyncPrefs.getBool('isThemeDark');
    final container = ProviderContainer();
    container.read(currentThemeIsDark.notifier).update((state) => theme!);

    //*REPOSITORIES
    final productRepository = ProductRepositoryImpl(petition: petitions);
    getIt.registerSingleton<IProductRepository>(productRepository);
    final comboRepository = ComboRepositoryImpl(petition: petitions);
    getIt.registerSingleton<IComboRepository>(comboRepository);
    final cartRepository = CartItemRepository();
    getIt.registerSingleton<ICartRepository>(cartRepository);
    final authRepository = AuthRepositoryImpl(petition: petitions, asyncPrefs: asyncPrefs);
    getIt.registerSingleton<IAuthRepository>(authRepository);
    final themeRepository = ThemeRepository(prefs: prefs);
    getIt.registerSingleton<ThemeRepository>(themeRepository);

    //*USE CASES
    final getProductsUseCase = GetProductsUseCase(productRepository);
    
    final getProductByIdUseCase = GetProductByIdUseCase(productRepository);
    getIt.registerSingleton<GetProductByIdUseCase>(getProductByIdUseCase);
    
  }

  static Future<void> initThemes(WidgetRef ref) async{
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final bool? theme = await asyncPrefs.getBool('isThemeDark');
    ref.read(currentThemeIsDark.notifier).update((state) => theme!);
  }
}