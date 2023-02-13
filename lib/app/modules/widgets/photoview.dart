import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

late PhotoViewScaleStateController scaleStateController;

void showCustomDialog({String? title, required String url}) {
  scaleStateController = PhotoViewScaleStateController();

  final context = Get.context;
  final text = title ?? '';
  final image = url;
  late ImageProvider imageprovider;
  image.contains('http')
      ? imageprovider = CachedNetworkImageProvider(image)
      : imageprovider = AssetImage(image);
  showGeneralDialog(
    barrierColor: Color(0x00ffffff),
    context: context!,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Scaffold(
        appBar: AppBar(
          title: Text(text),
          elevation: 0,
          backgroundColor: Colors.black54.withOpacity(0.5),
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios,
              )),
        ),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PhotoView(
              scaleStateController: scaleStateController,
              imageProvider: imageprovider,
              loadingBuilder: (context, progress) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: progress == null
                        ? null
                        : progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!,
                  ),
                ),
              ),
              backgroundDecoration: BoxDecoration(
                color: Colors.black54.withOpacity(0.5),
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
