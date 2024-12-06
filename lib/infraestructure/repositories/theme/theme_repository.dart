import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {

  final SharedPreferences prefs;

  ThemeRepository({required this.prefs});
  
  bool getCurrentTheme() {
    final bool? theme = prefs.getBool('isThemeDark') ?? false;
    return theme!;
  }

  Future<void> changeTheme() async {
    final bool? theme = prefs.getBool('isThemeDark');
    prefs.setBool("isThemeDark", !theme!);
  }
}