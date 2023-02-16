import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:radio_group_v2/radio_group_v2.dart';

import '../../../widgets/map.dart';
import '../../controllers/cv_controller.dart';

class Second_step extends GetView {
  const Second_step({
    super.key,
    required this.controller,
  });

  final CvController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Text(
            "Gender :",
            style: TextStyle(fontSize: 23, color: Colors.green),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
          child: RadioGroup(
            controller: controller.gender.value,
            values: ["Male", "Female", "Other"],
            indexOfDefault: 0,
            orientation: RadioGroupOrientation.Vertical,
            decoration: RadioGroupDecoration(
              spacing: 10.0,
              labelStyle: TextStyle(
                color: Colors.blue,
              ),
              activeColor: Colors.amber,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Text(
            "Address :",
            style: TextStyle(fontSize: 23, color: Colors.green),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Stack(children: [
              TextFormField(
                controller: controller.address.value,
                decoration: InputDecoration(
                    hintText: 'Address',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter your Address';
                  }
                  return null;
                },
              ),
              Positioned(
                right: 10,
                child: IconButton(
                  onPressed: () async {
                    await showMapInputDialog(
                        context: context,
                        title: 'Select Location',
                        onSubmit: (value, map) {
                          value = value.split(map['city'])[0];
                          EasyLoading.show(status: 'Please wait');
                          controller.address.value.text = value;
                          EasyLoading.dismiss();
                        });
                  },
                  icon: const Icon(Icons.location_on),
                ),
              ),
            ])),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ElevatedButton(
              onPressed: () {
                controller.activeIndex.value--;
              },
              child: const Text('Previous'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.activeIndex.value++;
              },
              child: const Text('Next'),
            ),
          ]),
        ),
      ],
    );
  }
}
