import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallpaper/common/network/dio_wrapper.dart';
import 'package:my_wallpaper/common/providers/error_provider.dart';
import 'package:my_wallpaper/common/providers/network_provider.dart';
import 'package:my_wallpaper/common/providers/theme_provider.dart';
import 'package:my_wallpaper/common/providers/url_provider.dart';

import 'package:provider/provider.dart';

class Dependencies extends StatelessWidget {
  final Widget child;

  const Dependencies({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        RepositoryProvider<ErrorProvider>(
          create: (_) => ErrorProvider(),
        ),
        RepositoryProvider<DioWrapper>(
          create: (_) => DioWrapper(),
        ),
        RepositoryProvider<NetworkProvider>(
          create: (_) => NetworkProvider(),
        ),
        RepositoryProvider<UrlProvider>(
          create: (_) => UrlProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
   
        // ChangeNotifierProvider<FileDownloaderProvider>(
        //   create: (_) => FileDownloaderProvider(),
        // ),
      ],
      child: child,
    );
  }
}
