import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:my_wallpaper/common/providers/theme_provider.dart';
import 'package:my_wallpaper/screens/home/src/bloc/home_bloc.dart';
import 'package:my_wallpaper/widgets/modal_larger_image/modal_larger_Image.dart';
import 'package:provider/provider.dart';

part 'src/page.dart';
part 'src/view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_HomeViewModel>(
      create: (_) => _HomeViewModel()..init(),
      child: const _HomePage(),
    );
  }
}

MaterialPageRoute homeRoute() {
  return MaterialPageRoute(builder: (_) => const HomeScreen());
}
