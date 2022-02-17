import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_wallpaper/common/providers/theme_provider.dart';
import 'package:my_wallpaper/widgets/buttons/app_elevated_button.dart';
import 'package:provider/provider.dart';
// import 'package:SudCor/generated/l10n.dart';

Future<T?> showAppDialog<T>(
  BuildContext context, {
  String? title,
  String? body,
  String? icon,
  String? firstTextButton,
  String? secondTextButton,
  Widget Function(BuildContext context)? actions,
  bool barrierDismissible = true,
  bool showCancel = true,
  required VoidCallback onConfirm,
   VoidCallback? onCancel,
}) =>
    showDialog<T?>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => _Dialog(
        icon: icon,
        title: title,
        body: body,
        onConfirm: onConfirm,
        onCancel: onCancel,
        firstTextButton: firstTextButton,
        secondTextButton: secondTextButton,
      ),
    );

class _Dialog extends StatefulWidget {
  final String? icon;
  final String? title;
  final String? body;
  final String? firstTextButton;
  final String? secondTextButton;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const _Dialog({
    Key? key,
    this.icon,
    this.title,
    this.body,
    this.firstTextButton,
    this.secondTextButton,
    this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _theme = context.watch<ThemeProvider>().theme;

    return Dialog(
      backgroundColor: _theme.colors.appBackground,
      insetPadding: const EdgeInsets.all(20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Builder(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20.0,
                    20.0,
                    20.0,
                    0.0,
                  ),
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _theme.colors.borderDividers,
                      borderRadius: BorderRadius.circular(56),
                    ),
                    child: SvgPicture.asset(
                      widget.icon!,
                      width: 28,
                      height: 28,
                    ),
                  ),
                ),
              const SizedBox(height: 20.0),
              if (widget.title != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20.0,
                    20.0,
                    20.0,
                    0.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title!,
                          textAlign: TextAlign.center,
                          style: _theme.textStyles.semiBold24.copyWith(
                            color: _theme.colors.primaryDarkOrWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20.0),
              if (widget.body != null)
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    20.0,
                    0.0,
                    20.0,
                    20.0,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.body!,
                          textAlign: TextAlign.center,
                          style: _theme.textStyles.regular14.copyWith(
                            color: _theme.colors.grayScaleGray,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 8.0,
                        ),
                        child: AppElevatedButton(
                          title: "S.of(context).cancel",
                          onPressed: () {
                            widget.onCancel?.call();
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 16.0,
                        ),
                        child: AppElevatedButton(
                          isLoading: isLoading,
                          title: "S.of(context).send",
                          onPressed: () {
                            if (!isLoading) {
                              widget.onConfirm.call();
                              setState(() => isLoading = !isLoading);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
