import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../modules/home/model_model.dart';

const String API_URL = 'https://jsonplaceholder.typicode.com/todos';
List<Model> lmodel = [];
var value = false.obs;

Future<List<Model>> getModel() async {
  print(API_URL);
  try {
    final response = await Dio().get(API_URL);
    Model model = Model();
    if (response.statusCode == 200) {
      response.data.forEach((element) {
        model = Model.fromJson(element as Map<String, dynamic>);
        print(element.toString());
        print('done');
        lmodel.add(model);
        print(lmodel.length);
      });
    }
    value(true);
    return lmodel;
  } catch (e) {
    print('ERRROOORRRRRR');
    print(e);
    return [];
  }
}
