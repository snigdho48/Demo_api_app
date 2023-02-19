import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cv_controller.dart';
import 'cv_view_final.dart';

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
              itemCount: controller.textcontroler1.length,
              itemBuilder: (context, index) {
                return Experience_list(
                  controller: controller,
                  id: index,
                );
              })),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    controller.newindex();
                    controller.update();
                  },
                  child: Text('Add Experience')),
              ElevatedButton(
                  onPressed: () {
                    controller.removeindex();
                    controller.update();
                  },
                  child: Text('Remove Experience')),
            ],
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
                      Get.to(() => const Final_review());
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
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.amberAccent.shade200.withOpacity(0.2)),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Column(
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
                  controller: controller.textcontroler1[id],
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
                  controller: controller.textcontroler2[id],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Year of Experience',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide:
                              const BorderSide(color: Colors.blue, width: 1))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter your Experience';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
