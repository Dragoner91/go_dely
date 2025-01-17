import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/aplication/providers/notifications/notifications_provider.dart';
import 'package:go_dely/aplication/providers/theme/theme_provider.dart';
import 'package:go_dely/aplication/services/i_notification_handler.dart';
import 'package:go_dely/aplication/use_cases/auth/login.use_case.dart';
import 'package:go_dely/aplication/use_cases/auth/register.use_case.dart';
import 'package:go_dely/aplication/use_cases/category/get_category_by_id.use_case.dart';
import 'package:go_dely/aplication/use_cases/combo/get_combo_by_id.use_case.dart';
import 'package:go_dely/aplication/use_cases/combo/get_combos.use_case.dart';
import 'package:go_dely/aplication/use_cases/discount/get_discount_by_id.use_case.dart';
import 'package:go_dely/aplication/use_cases/order/check_order_current_location.use_case.dart';
import 'package:go_dely/aplication/use_cases/order/create_order.use_case.dart';
import 'package:go_dely/aplication/use_cases/order/get_order_by_id.use_case.dart';
import 'package:go_dely/aplication/use_cases/order/get_orders.use_case.dart';
import 'package:go_dely/aplication/use_cases/product/get_product_by_id.use_case.dart';
import 'package:go_dely/aplication/use_cases/product/get_products.use_case.dart';
import 'package:go_dely/domain/cart/i_cart_repository.dart';
import 'package:go_dely/domain/category/i_category_repository.dart';
import 'package:go_dely/domain/combo/i_combo_repository.dart';
import 'package:go_dely/domain/discount/i_discount_repository.dart';
import 'package:go_dely/domain/order/i_order_repository.dart';
import 'package:go_dely/domain/paymentMethod/i_payment_method_repository.dart';
import 'package:go_dely/domain/product/i_product_repository.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/firebase_options.dart';
import 'package:go_dely/infraestructure/datasources/petitions/petition_impl.dart';
import 'package:go_dely/infraestructure/repositories/auth/auth_repository_impl.dart';
import 'package:go_dely/infraestructure/repositories/cart/cart_item_repository.dart';
import 'package:go_dely/infraestructure/repositories/category/category_repository_impl.dart';
import 'package:go_dely/infraestructure/repositories/combo/combo_repository_impl.dart';
import 'package:go_dely/infraestructure/repositories/discount/discount_repository_impl.dart';
import 'package:go_dely/infraestructure/repositories/order/order_repository_impl.dart';
import 'package:go_dely/infraestructure/repositories/paymentMethod/payment_method_repository_impl.dart';
import 'package:go_dely/infraestructure/repositories/product/product_repository_impl.dart';
import 'package:go_dely/infraestructure/repositories/search/search_repository.dart';
import 'package:go_dely/infraestructure/repositories/theme/theme_repository.dart';
import 'package:go_dely/infraestructure/services/firebase/firebase_handler.dart';
import 'package:go_dely/infraestructure/services/notifications/notification_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';





class IoCContainer {
  static Future<void> init(ProviderContainer providerContainer) async {
    final getIt = GetIt.instance;

    //*COMMONS
    final petitions = PetitionImpl(providerContainer: providerContainer);
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final notificationHandler = NotificationHandler();
    getIt.registerSingleton<INotificationHandler>(notificationHandler);
    final notifications = NotificationsProvider(notificationHandler);
    notifications.init();

    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print ('TOKEN: ${await firebaseMessaging.getToken()}');






    //*REPOSITORIES
    final authRepository = AuthRepositoryImpl(petition: petitions, asyncPrefs: asyncPrefs);
    getIt.registerSingleton<IAuthRepository>(authRepository);
    final productRepository = ProductRepositoryImpl(petition: petitions, auth: authRepository);
    getIt.registerSingleton<IProductRepository>(productRepository);
    final comboRepository = ComboRepositoryImpl(petition: petitions, auth: authRepository, productRepository: productRepository);
    getIt.registerSingleton<IComboRepository>(comboRepository);
    final discountRepository = DiscountRepositoryImpl(auth: authRepository, petition: petitions);
    getIt.registerSingleton<IDiscountRepository>(discountRepository);
    final cartRepository = CartItemRepository(auth: authRepository, discountRepo: discountRepository);
    getIt.registerSingleton<ICartRepository>(cartRepository);
    final themeRepository = ThemeRepository(prefs: prefs);
    getIt.registerSingleton<ThemeRepository>(themeRepository);
    final orderRepository = OrderRepositoryImpl(petition: petitions, auth: authRepository, comboRepository: comboRepository, productRepository: productRepository);
    getIt.registerSingleton<IOrderRepository>(orderRepository);
    final paymentMethodRepository = PaymentMethodRepositoryImpl(petition: petitions);
    getIt.registerSingleton<IPaymentMethodRepository>(paymentMethodRepository);
    final searchRepository = SearchRepository(petition: petitions, auth: authRepository);
    getIt.registerSingleton<SearchRepository>(searchRepository);
    final categoryRepository = CategoryRepositoryImpl(petition: petitions, auth: authRepository);
    getIt.registerSingleton<ICategoryRepository>(categoryRepository);

    //*USE CASES
    final getProductsUseCase = GetProductsUseCase(productRepository);
    getIt.registerSingleton<GetProductsUseCase>(getProductsUseCase);
    final getProductByIdUseCase = GetProductByIdUseCase(productRepository);
    getIt.registerSingleton<GetProductByIdUseCase>(getProductByIdUseCase);
    final getCombosUseCase = GetCombosUseCase(comboRepository);
    getIt.registerSingleton<GetCombosUseCase>(getCombosUseCase);
    final getCombosByIdUseCase = GetCombosByIdUseCase(comboRepository);
    getIt.registerSingleton<GetCombosByIdUseCase>(getCombosByIdUseCase);
    final getOrdersUseCase = GetOrdersUseCase(orderRepository);
    getIt.registerSingleton<GetOrdersUseCase>(getOrdersUseCase);
    final getOrderByIdUseCase = GetOrderByIdUseCase(orderRepository);
    getIt.registerSingleton<GetOrderByIdUseCase>(getOrderByIdUseCase);
    final createOrderUseCase = CreateOrderUseCase(orderRepository);
    getIt.registerSingleton<CreateOrderUseCase>(createOrderUseCase);
    final checkOrderCurrentLocationUseCase = CheckOrderCurrentLocationUseCase(orderRepository);
    getIt.registerSingleton<CheckOrderCurrentLocationUseCase>(checkOrderCurrentLocationUseCase);
    final loginUseCase = LoginUseCase(authRepository);
    getIt.registerSingleton<LoginUseCase>(loginUseCase);
    final registerUseCase = RegisterUseCase(authRepository);
    getIt.registerSingleton<RegisterUseCase>(registerUseCase);
    final getCategoryByIdUseCase = GetCategoryByIdUseCase(categoryRepository);
    getIt.registerSingleton<GetCategoryByIdUseCase>(getCategoryByIdUseCase);
    final getDiscountByIdUseCase = GetDiscountByIdUseCase(discountRepository);
    getIt.registerSingleton<GetDiscountByIdUseCase>(getDiscountByIdUseCase);
    
  }

  static Future<void> initThemes(WidgetRef ref) async{
    final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
    final bool? theme = await asyncPrefs.getBool('isThemeDark');
    ref.read(currentThemeIsDark.notifier).update((state) => theme ?? false);
  }
}