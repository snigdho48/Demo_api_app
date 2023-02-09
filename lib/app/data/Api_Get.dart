import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../modules/home/model_model.dart';

const String API_URL = 'https://jsonplaceholder.typicode.com/todos';
List<Model> lmodel = [];
var value = false.obs;

Future<List<Model>> getModel() async {
  value(false);
  EasyLoading.show(status: 'loading...');

  print(API_URL);
  try {
    final response = await Dio().get(API_URL);
    Model model = Model();
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        model = Model.fromJson(element as Map<String, dynamic>);
        lmodel.add(model);
      });
    }
    value(true);
    EasyLoading.dismiss();
    return lmodel;
  } catch (e) {
    print(e);
    EasyLoading.dismiss();
    return [];
  }
}

Future<Model> getSingleModel({required String id}) async {
  value(false);
  EasyLoading.show(status: 'loading...');

  try {
    final response = await Dio().get('$API_URL/$id');
    Model model = Model();
    if (response.statusCode == 200) {
      model = Model.fromJson(response.data);
      print(model.title);
      EasyLoading.dismiss();
      return model;
    }
    EasyLoading.dismiss();
    value(true);
    return Model();
  } catch (e) {
    EasyLoading.dismiss();
    print(e);
    return Model();
  }
}
