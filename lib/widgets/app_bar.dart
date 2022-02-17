import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wallpaper/common/providers/theme_provider.dart';
import 'package:my_wallpaper/common/theme/src/main_theme.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final bool implyLeading;
  final bool centerTitle;
  final Color? colorIcon;
  final void Function()? onPressed;

  const AppBarWidget({
    Key? key,
    this.title,
    this.onPressed,
    this.colorIcon,
    this.centerTitle = true,
    this.implyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = context.watch<ThemeProvider>();
    final Brightness brightnessLight =
        Platform.isAndroid ? Brightness.dark : Brightness.light;
    final Brightness brightnessdark =
        Platform.isAndroid ? Brightness.light : Brightness.dark;

    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: _theme.themeType == ThemeType.light
            ? _theme.theme.colors.grayScaleGray.withOpacity(0.4)
            : Colors.transparent,
        statusBarIconBrightness: _theme.themeType == ThemeType.light
            ? brightnessLight
            : brightnessdark,
        statusBarBrightness: _theme.themeType == ThemeType.light
            ? brightnessLight
            : brightnessdark,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: centerTitle,
      title: title,
      automaticallyImplyLeading: false,
      leading: implyLeading
          ? IconButton(
              splashRadius: 24,
              icon: SvgPicture.asset(
                'assets/icons/ic_arrow_left.svg',
                color: colorIcon,
              ),
              onPressed: onPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
