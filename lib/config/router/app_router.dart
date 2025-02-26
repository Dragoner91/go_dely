import 'package:flutter/material.dart';
import 'package:go_dely/presentation/screens.dart';
import 'package:go_dely/presentation/screens/catalog/categories_display_screen.dart';
import 'package:go_router/go_router.dart';


// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/welcome',
  routes: [
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/welcome',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: const WelcomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: ProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/product',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 500),
          key: state.pageKey,
          child: const ProductDetailsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SizeTransition(
              sizeFactor: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
              ),
              axisAlignment: 0.0,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/combo',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 500),
          key: state.pageKey,
          child: const ComboDetailsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SizeTransition(
              sizeFactor: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                ),
              ),
              axisAlignment: 0.0,
              child: child,
            );
          },
        );
      },
    ),    
    GoRoute(
      path: '/cart',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: const CartScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),  
    GoRoute(
      path: '/checkout',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: const CheckoutScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ), 
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: const RegisterScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/categoryList',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: const Cataloglist(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ), 
    GoRoute(
      path: '/categoryView',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: const CategoriesDisplayScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),   


    GoRoute(
      path: '/orderHistory',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: const OrderHistoryScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),  
    GoRoute(
      path: '/orderDetails',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 400),
          key: state.pageKey,
          child: const OrderDetailsScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, -1.0); // Comienza fuera de la pantalla, arriba
            const end = Offset(0.0, 0.0); // Termina en su posición normal
            const curve = Curves.easeInOut;
    
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
    
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      },
    ),  
    GoRoute(
      path: '/couponsAvailable',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: const CouponsAvailableScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ), 

    GoRoute(
      path: '/map',
      pageBuilder: (context, state) {
        return  CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          key: state.pageKey,
          child: const AddressSelector(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity:
                  CurveTween(curve: Curves.easeInOutCirc).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);