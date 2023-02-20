import 'package:get/get_rx/src/rx_types/rx_types.dart';

class CheckboxItem {
  final String text;
  final RxBool checked;
  final RxBool valid;
  final RxString value;

  CheckboxItem(
      {required this.text,
      bool checked = false,
      String value = '',
      bool valid = false})
      : checked = checked.obs,
        value = value.obs,
        valid = valid.obs;
}
