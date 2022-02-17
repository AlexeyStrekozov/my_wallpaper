import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wallpaper/common/theme/src/main_theme.dart';

void snackBar({
  required BuildContext context,
  required MainTheme theme,
  required String title,
  bool error = true,
  Color backgroundColor = Colors.redAccent,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.all(12),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Row(
        children: [
          error
              ? Row(children: [
                  SvgPicture.asset('assets/icons/ic_error.svg'),
                  const SizedBox(width: 24)
                ])
              : const SizedBox.shrink(),
          Flexible(
            child: Text(
              title,
              style: theme.textStyles.medium14.copyWith(
                color: theme.colors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void snackBarSuccess({
  required BuildContext context,
  required MainTheme theme,
  required String title,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.all(12),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor ?? theme.colors.greenSuccess,
      padding: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Row(
        children: [
          SvgPicture.asset('assets/icons/ic_success_two.svg'),
          const SizedBox(width: 24),
          Flexible(
            child: Text(
              title,
              style: theme.textStyles.medium14.copyWith(
                color: theme.colors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
