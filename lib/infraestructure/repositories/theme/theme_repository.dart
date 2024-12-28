import 'package:shared_preferences/shared_preferences.dart';

class ThemeRepository {

  final SharedPreferences prefs;

  ThemeRepository({required this.prefs});
  
  bool getCurrentTheme() {
    final bool? theme = prefs.getBool('isThemeDark');
    print(theme);
    return theme ?? false;
  }

  Future<void> changeTheme() async {
    final bool? theme = prefs.getBool('isThemeDark');
    final currentTheme = theme ?? false;
    prefs.setBool("isThemeDark", !currentTheme);
  }
}