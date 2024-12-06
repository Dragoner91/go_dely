import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_dely/aplication/providers/theme/theme_provider.dart';
import 'package:go_dely/config/DI/ioc_container.dart';
import 'package:go_dely/config/theme/custom_theme.dart';
import 'package:go_dely/domain/users/i_auth_repository.dart';
import 'package:go_dely/infraestructure/repositories/theme/theme_repository.dart';
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
  
  @override
  void initState() {
    super.initState();
    initStateTheme(ref);
  }

  Future<void> initStateTheme(WidgetRef ref) async{
    await IoCContainer.initThemes(ref);
  }

  @override
  Widget build(BuildContext context) {

    ref.watch(currentThemeIsDark);
    final currentTheme = GetIt.instance.get<ThemeRepository>().getCurrentTheme();
    ThemeData theme = currentTheme == true ? AppTheme.getDarkTheme() : AppTheme.getTheme();

    return MaterialApp.router(
      title: 'GoDely',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: theme
    );
  }
}
