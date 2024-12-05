import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/aplication/providers/theme/theme_provider.dart';
import 'package:go_dely/config/DI/ioc_container.dart';
import 'package:go_dely/config/theme/custom_theme.dart';
import 'config/router/app_router.dart';

Future<void> main() async{
  await dotenv.load(fileName: '.env');
  await IoCContainer.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final currentTheme = ref.watch(currentThemeIsDark);
    ThemeData theme = currentTheme ? AppTheme.getDarkTheme() : AppTheme.getTheme();


    //*hacer que se traiga el token del repositorio de auth con getit

    return MaterialApp.router(
      title: 'GoDely',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: theme
    );
  }
}
