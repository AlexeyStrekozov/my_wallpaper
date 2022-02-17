import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_wallpaper/common/constants.dart';
import 'package:my_wallpaper/features/app_restart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UrlProviderException implements Exception {
  final String e;

  UrlProviderException(this.e);

  @override
  String toString() => e;
}

enum UrlType { production, develop }

class UrlProvider {
  final Map<UrlType, _ServerModel> _availableServers = {
    UrlType.production: _ServerModel(
      baseURL: 'https://api.pexels.com/v1/',
    ),
    UrlType.develop: _ServerModel(
      baseURL: 'https://api.pexels.com/v1/',
    ),
  };

  late final SharedPreferences _preferences;

  late UrlType _type;

  late _ServerModel _model;

  UrlType get type => _type;

  String get baseURL => _model.baseURL;

  void init({required SharedPreferences preferences}) {
    _preferences = preferences;

    final type = _preferences.getString(Constants.urlTypeKey);

    _type = _getTypeFromString(type);

    _model = _getModelOrThrow(_type);

    _logServer(_type);
  }

  Future<void> changeServer({
    required BuildContext context,
    required UrlType type,
  }) async {
    _type = type;

    _model = _getModelOrThrow(_type);

    await _preferences.setString(Constants.urlTypeKey, _type.toString());

    AppRestart.restartApp(context);
  }

  _ServerModel _getModelOrThrow(UrlType type) {
    if (_availableServers.containsKey(type)) {
      return _availableServers[type]!;
    } else {
      throw UrlProviderException(
        'Available servers does not contains this key',
      );
    }
  }

  UrlType _getTypeFromString(String? type) {
    if (type == UrlType.production.toString()) {
      return UrlType.production;
    } else if (type == UrlType.develop.toString()) {
      return UrlType.develop;
    } else {
      return UrlType.production;
    }
  }

  void _logServer(UrlType type) {
    switch (type) {
      case UrlType.production:
        log('🟢 PRODUCTION');
        break;

      case UrlType.develop:
        log('🟡 DEVELOP');
        break;
    }
  }
}

class _ServerModel {
  final String baseURL;
  _ServerModel({
    required this.baseURL,
  });
}
