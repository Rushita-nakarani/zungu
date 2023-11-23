import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'cust_image.dart';

class CustFileImage extends StatelessWidget {
  final String dirPath;
  CustFileImage({Key? key, required this.dirPath}) : super(key: key);

  // final YoutubeController _youtubeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: VideoThumbnail.thumbnailData(
        video: dirPath,
        imageFormat: ImageFormat.JPEG,
        quality: 20,
      ),
      builder: (ctx, imageData) {
        Widget child = const CustImage();
        if (imageData.hasData && imageData.data != null) {
          child = InkWell(
            onTap: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                imageData.data!,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else if (imageData.hasError) {
          child = const CustImage();
        } else {
          child = const Center(
            child: CircularProgressIndicator(
              color: Color(0xffF54768),
            ),
          );
        }
        return child;
      },
    );
  }
}
