import 'package:shared_preferences/shared_preferences.dart';

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
