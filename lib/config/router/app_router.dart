import 'package:go_dely/presentation/screens.dart';
import 'package:go_router/go_router.dart';


// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/welcome',
  routes: [
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/product',
      builder: (context, state) => const ProductDetailsScreen(),
    ),
    GoRoute(
      path: '/combo',
      builder: (context, state) => const ComboDetailsScreen(),
    ),    
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),  
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ), 
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),   
  ],
);