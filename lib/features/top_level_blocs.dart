import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallpaper/common/providers/network_provider.dart';
import 'package:my_wallpaper/features/bloc/main_bloc_bloc.dart';
import 'package:my_wallpaper/screens/home/src/bloc/home_bloc.dart';
import 'package:provider/provider.dart';

class TopLevelBlocs extends StatelessWidget {
  final Widget child;

  const TopLevelBlocs({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBlocBloc>(
          create: (context) => MainBlocBloc(
            initialState: LoadingMainBlocState(),
          )..add(InitialMainBlocEvent()),
        ),
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(
            initialState: LoadingHomeState(isLoading: true),
            networkProvider: context.read<NetworkProvider>(),
          )..add(InitialHomeEvent()),
        ),
      ],
      child: child,
    );
  }
}
