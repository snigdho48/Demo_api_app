import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:demo_app/app/modules/cv/controllers/cv_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Third_step extends GetView {
  const Third_step({
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
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Text(
              "Education :",
              style: TextStyle(fontSize: 23, color: Colors.green),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: SimpleGroupedCheckbox<int>(
              controller: controller.education.value,
              itemsTitle: ["SSC", "HSC", "BSC", "MSC"],
              values: [1, 2, 4, 5],
              groupStyle: GroupStyle(
                  activeColor: Colors.red,
                  itemTitleStyle: TextStyle(fontSize: 13)),
              checkFirstElement: false,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 15),
            child: Text(
              "Last Institution Name :",
              style: TextStyle(fontSize: 23, color: Colors.green),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: controller.lastInstitutionName.value,
              decoration: InputDecoration(
                  hintText: 'Last Institution Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter your Last Institution Name';
                }
                return null;
              },
            ),
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
                      controller.activeIndex.value++;
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
