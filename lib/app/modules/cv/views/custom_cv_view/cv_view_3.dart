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
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  for (var item in controller.checkboxList)
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.text),
                            if (item.checked.value)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter your CGPA';
                                      } else if (double.parse(value) > 5.00 &&
                                          controller.checkboxList
                                                  .indexOf(item) <
                                              2) {
                                        return 'Please Enter valid CGPA';
                                      } else if (double.parse(value) > 4.00 &&
                                          controller.checkboxList
                                                  .indexOf(item) >=
                                              2) {
                                        return 'Please Enter valid CGPA';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      item.value.value = value;
                                      controller.formKey.currentState!
                                          .validate();
                                    },
                                    decoration: InputDecoration(
                                        constraints: BoxConstraints(
                                            maxHeight: 60, minHeight: 60),
                                        hintText: 'Enter CGPA',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                                color: Colors.blue, width: 1))),
                                  ),
                                ),
                              ),
                            Checkbox(
                              value: item.checked.value,
                              onChanged: (value) {
                                item.checked.value = value!;
                                controller.check(item);
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              )),
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
                      if (controller.formKey.currentState!.validate()) {
                        if (controller.checkboxList
                            .any((element) => element.checked.value)) {
                          if (controller.textcontroler1.length < 0) {
                            controller.newindex();
                          }
                          controller.activeIndex.value++;
                        }
                      }
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
