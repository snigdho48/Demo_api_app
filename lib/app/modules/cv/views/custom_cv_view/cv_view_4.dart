import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cv_controller.dart';

class Fourth_step extends GetView {
  const Fourth_step({
    super.key,
    required this.controller,
  });

  final CvController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Center(
              child: Text(
                "Professional Summary :",
                style: TextStyle(fontSize: 23, color: Colors.green),
              ),
            ),
          ),
          Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.index.value,
              itemBuilder: (context, index) {
                return Experience_list(
                  controller: controller,
                  id: index,
                );
              })),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  controller.newindex();
                  controller.update();
                },
                child: Text('Add Experience')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.activeIndex.value--;
                    },
                    child: const Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed('/profile');
                      controller.activeIndex.value = 0;
                    },
                    child: const Text('Next'),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

class Experience_list extends StatelessWidget {
  const Experience_list({
    super.key,
    required this.controller,
    required this.id,
  });

  final CvController controller;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text(
            "Institution Name :",
            style: TextStyle(fontSize: 23, color: Colors.green),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: controller.experience[0],
            decoration: InputDecoration(
                hintText: 'Professional Summary',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Professional Summary';
              }
              return null;
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Text(
            "Year of Experience",
            style: TextStyle(fontSize: 23, color: Colors.green),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            controller: controller.experience[1],
            decoration: InputDecoration(
                hintText: 'Skills',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide:
                        const BorderSide(color: Colors.blue, width: 1))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Skills';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
