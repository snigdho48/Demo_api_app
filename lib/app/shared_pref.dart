import 'dart:convert';
import 'dart:io';

import 'package:cached_memory_image/cached_memory_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveNoti({required List list}) async {
  final pref = await SharedPreferences.getInstance();
  final encode =
      List.generate(list.length, (index) => jsonEncode(list[index].toString()));
  await pref.setStringList('encode', encode);
}

Future<void> savePayload({required List list}) async {
  final pref = await SharedPreferences.getInstance();
  final encode =
      List.generate(list.length, (index) => jsonEncode(list[index].toString()));
  await pref.setStringList('payload', encode);
}

Future<List> getPayload() async {
  final pref = await SharedPreferences.getInstance();
  final store = pref.getStringList('payload') ?? [];
  List decoded =
      List.generate(store.length, (index) => jsonDecode(store[index]));
  print('find payload, $decoded');
  savePayload(list: []);
  return decoded;
}

Future<List> getNoti() async {
  final pref = await SharedPreferences.getInstance();
  final store = pref.getStringList('encode') ?? [];
  List decoded =
      List.generate(store.length, (index) => jsonDecode(store[index]));
  print(decoded);
  return decoded;
}

Future<void> setstatus({required bool isLogin}) async {
  final pref = await SharedPreferences.getInstance();
  await pref.setBool('isLogin', isLogin);
}

Future<bool> getstatus() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getBool('isLogin') ?? false;
}

Future<void> setemail({required String email}) async {
  final pref = await SharedPreferences.getInstance();
  await pref.setString('email', email);
}

Future<String> getemail() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('email') ?? '';
}

Future<void> removeemail() async {
  final pref = await SharedPreferences.getInstance();
  await pref.remove('email');
}

Future<void> setpass({required String pass}) async {
  final pref = await SharedPreferences.getInstance();
  await pref.setString('pass', pass);
}

Future<String> getpass() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('pass') ?? '';
}

Future<void> removepass() async {
  final pref = await SharedPreferences.getInstance();
  await pref.remove('pass');
}

Future<void> setname({required String name}) async {
  final pref = await SharedPreferences.getInstance();
  await pref.setString('name', name);
}

Future<String> getname() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('name') ?? '';
}

Future<void> removename() async {
  final pref = await SharedPreferences.getInstance();
  await pref.remove('name');
}

Future<void> saveImage({required String image}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final base64ImageString = convertIntoBase64(File(image));
  prefs.setString("image", base64ImageString);
}

Future<CachedMemoryImage?> getImage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String image = prefs.getString("image") ?? '';
  try {
    print('success');
    return CachedMemoryImage(
      uniqueKey: 'app://image/1',
      base64: image,
    );
  } catch (e) {
    return null;
  }
}

String convertIntoBase64(var file) {
  var imageBytes = file.writeAsBytes;
  String base64File = base64Encode(imageBytes);
  return base64File;
}

Future<void> removeImage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove("image");
}
