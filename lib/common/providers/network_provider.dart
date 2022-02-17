import 'package:dio/dio.dart';
import 'package:my_wallpaper/common/network/dio_wrapper.dart';
import 'package:my_wallpaper/common/network/models/response/photos_model.dart';
import 'package:my_wallpaper/common/providers/url_provider.dart';

class NetworkProvider {
  late final DioWrapper _networkService;
  late final UrlProvider _urlProvider;

  void init({
    required DioWrapper networkService,
    required UrlProvider urlProvider,
  }) {
    _networkService = networkService;
    _urlProvider = urlProvider;
  }

  ///[Photos]
  Future<PhotosModel> getPhotos() async {
    final response = await _networkService.sendRequest(
      baseUrl: _urlProvider.baseURL,
      url: 'curated?per_page=80',
      method: NetworkMethod.get,
    );

    return PhotosModel.fromJson(response.data);
  }

}
