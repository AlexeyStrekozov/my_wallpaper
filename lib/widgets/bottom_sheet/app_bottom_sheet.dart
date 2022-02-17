import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wallpaper/common/providers/theme_provider.dart';

import 'package:provider/provider.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    Key? key,
    this.initial,
    this.items = const [],
    this.onTap,
    this.title,
    this.icon,
    this.rows = const [],
  }) : super(key: key);

  final dynamic initial;
  final List items;
  final ValueChanged? onTap;
  final String? title;
  final String? icon;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    final _theme = context.read<ThemeProvider>().theme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              if (title != null)
                Expanded(
                  child: Text(
                    title!,
                    textAlign: TextAlign.start,
                    style: _theme.textStyles.medium16.copyWith(
                      color: _theme.colors.primaryDarkOrWhite,
                    ),
                  ),
                ),
              if (icon != null)
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    icon!,
                    color: _theme.colors.primaryDarkOrWhite,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      items[index].name ?? '',
                      style: _theme.textStyles.regular14.copyWith(
                        color: _theme.colors.primaryDarkOrWhite,
                      ),
                    ),
                  ),
                  trailing: SizedBox(
                    width: 20.0,
                    height: 20.0,
                    child: items[index].countryCode == initial
                        ? SvgPicture.asset('assets/icons/ic_select.svg')
                        : null,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    onTap?.call(items[index]);
                  },
                );
              },
              separatorBuilder: (context, _) {
                return Divider(
                  color: _theme.colors.borderDividers,
                  height: 30,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
