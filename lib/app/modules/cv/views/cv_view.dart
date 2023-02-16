import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:demo_app/app/modules/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/stepper.dart';
import '../controllers/cv_controller.dart';
import 'custom_cv_view/cv_view_1.dart';
import 'custom_cv_view/cv_view_2.dart';
import 'custom_cv_view/cv_view_3.dart';
import 'custom_cv_view/cv_view_4.dart';

class CvView extends GetView<CvController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      bottomNavigationBar: Navigation(),
      floatingActionButton: navaction(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          if (controller.connected.value.type.value == false)
            GetSnackBar(
              title: 'No Internet Connection',
              message: 'Please check your internet connection',
            ),
          Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Obx(() => AnotherStepper(
                    stepperList: stepperData,
                    stepperDirection: Axis.horizontal,
                    gap: 20,
                    iconWidth: 40,
                    iconHeight: 40,
                    activeBarColor: Colors.green,
                    inActiveBarColor: Colors.grey,
                    activeIndex: controller.activeIndex.value,
                    barThickness: 8,
                  ))),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                      key: controller.formKey,
                      child: Obx(() {
                        switch (controller.activeIndex.value) {
                          case 0:
                            return First_step(controller: controller);
                            break;
                          case 1:
                            return Second_step(
                              controller: controller,
                            );
                            break;
                          case 2:
                            return Third_step(
                              controller: controller,
                            );
                            break;
                          case 3:
                            return Fourth_step(
                              controller: controller,
                            );
                            break;
                          default:
                            return First_step(
                              controller: controller,
                            );
                        }
                      })),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
