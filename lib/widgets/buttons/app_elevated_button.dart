import 'package:flutter/material.dart';
import 'package:my_wallpaper/common/providers/theme_provider.dart';
import 'package:my_wallpaper/common/theme/src/main_theme.dart';
import 'package:provider/provider.dart';

class AppElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AppElevatedButton({
    Key? key,
    this.onPressed,
    this.isLoading = false,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = context.watch<ThemeProvider>();
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          (_theme.themeType == ThemeType.dark && onPressed == null)
              ? _theme.theme.colors.grayScaleWhiteOrBlack
              : null,
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 16,vertical: 10)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      onPressed: !isLoading ? onPressed : null,
      child: !isLoading
          ? FittedBox(
              child: Text(
                title,
                style: _theme.theme.textStyles.medium16.copyWith(
                  color: onPressed == null
                      ? _theme.theme.colors.grayScaleGray
                      : null,
                ),
              ),
            )
          : CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(_theme.theme.colors.whiteColor),
            ),
    );
  }
}
