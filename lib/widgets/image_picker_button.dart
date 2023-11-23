import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import '../services/image_picker_service.dart';
import '../services/video_picker_service.dart';

class ImagePickerButton extends StatelessWidget {
  const ImagePickerButton({
    Key? key,
    required this.child,
    required this.onImageSelected,
    this.onRemovePhoto,
    this.multipicker = false,
  }) : super(key: key);
  final void Function(List<String>) onImageSelected;
  final void Function()? onRemovePhoto;

  final Widget child;
  final bool multipicker;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: child,
      onTap: () {
        ImagePickerService(
          onRemovePhoto: onRemovePhoto,
          pickedImg: (imgPath) {
            if (imgPath == null) return;
            onImageSelected(imgPath);
          },
        ).openImagePikcer(
          multipicker: multipicker,
          context: context,
          iosImagePicker: Platform.isIOS,
        );
      },
    );
  }
}

class VideoPickerButton extends StatelessWidget {
  const VideoPickerButton({
    Key? key,
    required this.child,
    required this.onVideoSelected,
    this.onRemoveVideo,
  }) : super(key: key);
  final void Function(String) onVideoSelected;
  final void Function()? onRemoveVideo;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: child,
      onTap: () {
        VideoPickerService(
          onRemoveVideo: onRemoveVideo,
          pickedVideo: (imgPath) {
            if (imgPath == null) return;
            onVideoSelected(imgPath);
          },
        ).openVideoPicker(
          context: context,
          iosImagePicker: Platform.isIOS,
        );
      },
    );
  }
}
