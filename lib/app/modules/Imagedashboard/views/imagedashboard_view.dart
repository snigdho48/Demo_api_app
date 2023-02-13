import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/Image_api_get.dart';
import '../../helper_functions.dart';
import '../../widgets/photoview.dart';
import '../controllers/imagedashboard_controller.dart';

class ImagedashboardView extends GetView<ImagedashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      bottomNavigationBar: Navigation(),
      floatingActionButton: navaction(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(() {
        if (loadingvalue.value == false &&
            controller.connected.value.type.value == true) {
          getImageModel();
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (controller.connected.value.type.value == false)
                GetSnackBar(
                  title: 'No Internet Connection',
                  message: 'Please check your internet connection',
                ),
              for (var i = 0; i < imodel.length; i++)
                InkWell(
                    onTap: () {
                      showCustomDialog(
                        url: imodel[i].downloadUrl!,
                        title: imodel[i].author!,
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: Get.width < 768 ? Get.width * 0.45 : 300,
                            width: Get.width < 768 ? Get.width * 0.45 : 300,
                            child: CachedNetworkImage(
                              imageUrl: imodel[i].downloadUrl!,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Positioned(
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.center,
                              width: Get.width < 768 ? Get.width * 0.45 : 300,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.redAccent.withOpacity(0.5)
                                    : Colors.grey.withOpacity(0.5),
                              ),
                              child: Text(
                                imodel[i].author!,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
            ],
          ),
        );
      }),
    );
  }
}
