import 'package:get/get.dart';

import '../image_model_model.dart';

class ImageModelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return ImageModel.fromJson(map);
      if (map is List) {
        return map.map((item) => ImageModel.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<ImageModel?> getImageModel(int id) async {
    final response = await get('imagemodel/$id');
    return response.body;
  }

  Future<Response<ImageModel>> postImageModel(ImageModel imagemodel) async =>
      await post('imagemodel', imagemodel);
  Future<Response> deleteImageModel(int id) async =>
      await delete('imagemodel/$id');
}
