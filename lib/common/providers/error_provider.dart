import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:SudCor/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_wallpaper/common/providers/theme_provider.dart';
import 'package:my_wallpaper/widgets/buttons/app_elevated_button.dart';
import 'package:provider/provider.dart';

class ErrorProvider {
  Future<void> handleError({
    required BuildContext context,
    required Object error,
  }) async {
    if (error is DioError) {
      if (error.message.contains('SocketException: Failed host lookup:')) {
        _logException(message: error.message);

        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          fullscreenDialog: true,
          builder: (dialogContext) {
            return _InternetConnectionError(
              callback: () {},
            );
          },
        ));
      } else {
        final response = DtoErrorResponse.fromJson(error.response?.data ?? {});

        final statusCode = error.response?.statusCode ?? 0;

        _logDioError(statusCode: statusCode, response: response);

        final message = response.data?.data.isNotEmpty ?? false
            ? ("S.current.haveEmail")
            : (response.message.isEmpty ? error.toString() : response.message);

        await _showScaffoldSnackBar(context: context, message: message);
      }
    } else if (error is Exception) {
      _logException(message: error.toString());

      await _showScaffoldSnackBar(
        context: context,
        message: error.toString(),
      );
    } else {
      _logException(message: error.toString());
      await _showScaffoldSnackBar(
        context: context,
        message: error.toString(),
      );
    }
  }

  Future<void> _showScaffoldSnackBar({
    required BuildContext context,
    required String message,
  }) async {
    final theme = context.read<ThemeProvider>().theme;
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(12),
        behavior: SnackBarBehavior.floating,
        backgroundColor: theme.colors.redError,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Row(
          children: [
            SvgPicture.asset('assets/icons/ic_error.svg'),
            const SizedBox(width: 24),
            Flexible(
              child: Text(
                message,
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

  void _logException({required String message}) =>
      log('❌Message: $message', name: '❌Exception');

  void _logDioError({
    required int statusCode,
    required DtoErrorResponse response,
  }) =>
      log('❌Status: $statusCode\n❌Message: ${response.message}',
          name: 'DioError');
}

class DtoErrorResponse {
  final String message;
  final DtoErrorData? data;

  DtoErrorResponse({
    required this.message,
    required this.data,
  });

  factory DtoErrorResponse.fromJson(Map<String, dynamic> json) {
    return DtoErrorResponse(
      message: json['message'] ?? '',
      data: json['data'] == null
          ? null
          : DtoErrorData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class DtoErrorData {
  final String data;

  DtoErrorData({required this.data});

  factory DtoErrorData.fromJson(Map<String, dynamic> json) {
    return DtoErrorData(
      data: json['email'] ?? "",
    );
  }
}

class _InternetConnectionError extends StatelessWidget {
  final VoidCallback callback;

  const _InternetConnectionError({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = context.read<ThemeProvider>().theme;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          color: _theme.colors.background,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Image.asset('assets/images/no_wifi.png'),
              const SizedBox(height: 12),
              Text(
                "S.of(context).noWifi",
                textAlign: TextAlign.center,
                style: _theme.textStyles.medium16.copyWith(
                  color: _theme.colors.primaryDarkOrWhite,
                ),
              ),
              const SizedBox(height: 36),
              AppElevatedButton(
                title: "S.of(context).update",
                onPressed: callback,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
