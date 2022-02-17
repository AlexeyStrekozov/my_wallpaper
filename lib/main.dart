
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallpaper/common/network/dio_wrapper.dart';
import 'package:my_wallpaper/common/providers/network_provider.dart';
import 'package:my_wallpaper/common/providers/url_provider.dart';
import 'package:my_wallpaper/common/theme/src/main_theme.dart';
import 'package:my_wallpaper/features/app_restart.dart';
import 'package:my_wallpaper/features/bloc/main_bloc_bloc.dart';
import 'package:my_wallpaper/features/dependencies.dart';
import 'package:my_wallpaper/features/initializer.dart';
import 'package:my_wallpaper/features/top_level_blocs.dart';
import 'package:my_wallpaper/screens/home/feature.dart';
import 'package:my_wallpaper/widgets/default_circular_progress_indicator.dart';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/providers/theme_provider.dart';


void main() {
  Stream<int> _initialization(BuildContext context) async* {
    const total = 100;

    yield 0;

    final _sharedPreferences = await SharedPreferences.getInstance();




    context.read<ThemeProvider>().init(
          defaultThemeType: ThemeType.dark,
          preferences: _sharedPreferences,
        );
    final docDir = await getApplicationDocumentsDirectory();

    context.read<UrlProvider>().init(
          preferences: _sharedPreferences,
        );

    yield (total ~/ 3);

    await context.read<DioWrapper>().init(
          networkProvider: context.read<NetworkProvider>(),
        );

    context.read<NetworkProvider>().init(
          networkService: context.read<DioWrapper>(),
          urlProvider: context.read<UrlProvider>(),
        );
    yield (total ~/ 2);


    yield (total ~/ 1.5);

    yield total;

    await Future.delayed(const Duration(milliseconds: 100));
  }

  runApp(
    AppRestart(
      child: Dependencies(
        child: TopLevelBlocs(
          child: DependenciesInitializer(
            initializer: _initialization,
            splashBuilder: (_, int percent) => _InitializationSplash(
              percent: percent,
            ),
            errorBuilder: (_, Object error) => _InitializationError(
              error: error,
            ),
            child: const Application(),
          ),
        ),
      ),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = context.watch<ThemeProvider>().theme;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'SudCor',
      theme: ThemeData(
        backgroundColor: _theme.colors.appBackground,
        scaffoldBackgroundColor: _theme.colors.appBackground,
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<MainBlocBloc, MainBlocState>(
        builder: (context, state) {
          if (state is LoadingMainBlocState) {
            return const _InitializationSplash();
          } else if (state is ApplicationMainBlocState) {
            return const HomeScreen();
          } else {
            return const _InitializationSplash();
          }
        },
      ),
    );
  }
}

class _InitializationSplash extends StatelessWidget {
  final int? percent;

  const _InitializationSplash({Key? key, this.percent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              const DefaultCircularProgressIndicators(color: Color(0xFF90D0F7)),
              const SizedBox(height: 30),
              if (percent != null)
                Text(
                  '$percent %',
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InitializationError extends StatelessWidget {
  final Object? error;

  const _InitializationError({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  error.toString(),
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
