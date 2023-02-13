import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../modules/Imagedashboard/image_model_model.dart';

List<ImageModel> imodel = [];
var loadingvalue = false.obs;

Future<List<ImageModel>> getImageModel() async {
  loadingvalue(false);
  EasyLoading.show(status: 'loading...');
  final response = await Dio().get('https://picsum.photos/v2/list');
  print('started');
  try {
    if (response.statusCode == 200) {
      imodel.clear();
      response.data.forEach((element) {
        imodel.add(ImageModel.fromJson(element as Map<String, dynamic>));
      });
      loadingvalue(true);
      EasyLoading.dismiss();
      print('success');
      return imodel;
    } else {
      loadingvalue(true);
      EasyLoading.dismiss();
      throw Exception('Failed to load ImageModel');
    }
  } on Exception catch (e) {
    EasyLoading.dismiss();
    return imodel;
    // TODO
  }
}

// Future<ImageModel> getSingleImageModel({required int id}) async {
//   final response = await Dio().get('https://picsum.photos/id/$id/5000/3333');
//   try {
//     if (response.statusCode == 200) {
//       return ImageModel.fromJson(response.data);
//     } else {
//       throw Exception('Failed to load ImageModel');
//     }
//   } on Exception catch (e) {
//     return ImageModel();
//     // TODO
//   }
// }
