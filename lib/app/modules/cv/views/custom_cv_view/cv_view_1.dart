import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controllers/cv_controller.dart';

class First_step extends GetView {
  const First_step({
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
            "Name :",
            style: TextStyle(fontSize: 23, color: Colors.green),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: controller.name.value,
            decoration: InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your name';
              }
              return null;
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Text(
            "Email :",
            style: TextStyle(fontSize: 23, color: Colors.green),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: controller.emailController.value,
            decoration: InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your email';
              }
              return null;
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Text(
            "Password :",
            style: TextStyle(fontSize: 23, color: Colors.green),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: IntlPhoneField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'BD',
              onChanged: (phone) {
                controller.phone.value.text = phone.completeNumber;
                print(phone.completeNumber);
              },
            )),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Previous'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.activeIndex.value++;
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Fill all the fields')));
                }
              },
              child: const Text('Next'),
            ),
          ]),
        ),
      ],
    );
  }
}
