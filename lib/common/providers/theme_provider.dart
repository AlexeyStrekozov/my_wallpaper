import 'package:flutter/widgets.dart';
import 'package:my_wallpaper/common/constants.dart';
import 'package:my_wallpaper/common/theme/src/main_theme.dart';
import 'package:my_wallpaper/common/theme/theme.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late final SharedPreferences _preferences;
  late MainTheme _theme;
  late ThemeType _themeType;

  double statusBarHeight = 0;

  final Map<ThemeType, MainTheme> _themesMap = {
    ThemeType.light: LightTheme(),
    ThemeType.dark: DarkTheme(),
  };

  MainTheme get theme => _theme;

  ThemeType get themeType => _themeType;

  void init({
    required ThemeType defaultThemeType,
    required SharedPreferences preferences,
  }) {
    _preferences = preferences;

    final themeType = _preferences.getString(Constants.sharedThemeType);

    if (themeType == ThemeType.light.toString()) {
      _themeType = ThemeType.light;
    } else if (themeType == ThemeType.dark.toString()) {
      _themeType = ThemeType.dark;
    } else {
      _themeType = defaultThemeType;
    }

    _theme = _themesMap[_themeType] ?? LightTheme();
  }

  Future<void> changeTheme(ThemeType themeType) async {
    if (themeType != _themeType) {
      _themeType = themeType;

      await _preferences.setString(
        Constants.sharedThemeType,
        themeType.toString(),
      );

      _theme = _themesMap[themeType] ?? LightTheme();

      notifyListeners();
    }
  }
}
