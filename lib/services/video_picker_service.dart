import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';

import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import 'app_permissions_service.dart';

class VideoPickerService {
  VideoPickerService({
    required this.pickedVideo,
    this.onRemoveVideo,
  });
//-------------------------------------------------------------------- Variable ----------------------------------------------------------------------------------//

  final ImagePicker _picker = ImagePicker();
  void Function(String?) pickedVideo;
  void Function()? onRemoveVideo;

  Future<String> _pickVideo(ImageSource source) async {
    // Pick an image...
    final XFile? _video = await _picker.pickVideo(source: source);
    return _video?.path ?? "";
  }

  // Open image picker ...
  Future<void> openVideoPicker({
    required BuildContext context,
    required bool iosImagePicker,
  }) async {
    return iosImagePicker
        // Video picker android
        ? _buildVideoPickerForIOS(context)
        // Video picker ios
        : _buildVideoPickerForAndroid(context);
  }

  //-------------------------------------------------------------------- Image Picker For Android----------------------------------------------------------------------------------//

  Future<void> _buildVideoPickerForAndroid(
    BuildContext context,
  ) async {
    showDialog<List<String>?>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              txtTitle: StaticString.selectVideoOptions,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ImageSource.values
                  .map(
                    // Buttons...
                    (source) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            try {
                              Navigator.of(ctx).pop();
                              if (await _isCameraAndGalleryPermissionAllowed(
                                context,
                                source,
                              )) {
                                final String _selectedVideo =
                                    await _pickVideo(source);

                                pickedVideo(_selectedVideo);
                              }
                            } catch (e) {
                              print(e);
                              rethrow;
                            }
                          },
                          icon: Icon(
                            _getSouceImage(source),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        CustomText(
                          txtTitle: toBeginningOfSentenceCase(
                            describeEnum(source),
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

//-------------------------------------------------------------------- Image Picker For IOS ----------------------------------------------------------------------------------//

  Future<void> _buildVideoPickerForIOS(
    BuildContext context,
  ) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: <Widget>[
          // Pick from library button...
          _buildCupertinoActionSheetAction(
            context: context,
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                if (await _isCameraAndGalleryPermissionAllowed(
                  context,
                  ImageSource.gallery,
                )) {
                  final String _selectedVideo =
                      await _pickVideo(ImageSource.gallery);

                  pickedVideo(_selectedVideo);
                }
              } catch (e) {
                print(e.toString());
                rethrow;
              }
            },
            buttonText: StaticString.pickfromLibrary,
          ),
          // Take a photo button...
          _buildCupertinoActionSheetAction(
            context: context,
            onPressed: () async {
              try {
                Navigator.of(context).pop();
                if (await _isCameraAndGalleryPermissionAllowed(
                  context,
                  ImageSource.camera,
                )) {
                  final String _selectedVideo =
                      await _pickVideo(ImageSource.camera);

                  pickedVideo(_selectedVideo);
                }
              } catch (e) {
                print(e.toString());
                rethrow;
              }
            },
            buttonText: StaticString.takeAPhoto,
          ),
        ],
        // Cancle button...
        cancelButton: _buildCupertinoActionSheetAction(
          context: context,
          onPressed: () {
            Navigator.of(context).pop();
          },
          buttonText: StaticString.cancel,
        ),
      ),
    );
  }
//-------------------------------------------------------------------- Helper Widgets ----------------------------------------------------------------------------------//

  // Cupertino Action Sheet Action
  Widget _buildCupertinoActionSheetAction({
    required BuildContext context,
    required String buttonText,
    required void Function() onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
        color: ColorConstants.custLightGreyF1F1F1,
      ),
      child: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: onPressed,
        child: CustomText(
          txtTitle: buttonText,
          style:
              Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 17.0),
        ),
      ),
    );
  }
//-------------------------------------------------------------------- Helper Function----------------------------------------------------------------------------------//

  // Get source icon image...
  static IconData _getSouceImage(ImageSource source) {
    switch (source) {
      case ImageSource.camera:
        return Icons.camera_alt_outlined;

      case ImageSource.gallery:
        return Icons.photo_outlined;
    }
  }

  // Check camera and gallery permission...
  Future<bool> _isCameraAndGalleryPermissionAllowed(
    context,
    ImageSource source,
  ) async {
    bool _isGranted = false;
    String _sourceName = "";
    String _media = "";
    String _suffixMsg = "";
    switch (source) {
      case ImageSource.camera:
        _isGranted = await AppPermissionsService.checkCameraPermission;
        _sourceName = Platform.isIOS ? "Camera" : "Storage";
        _media = Platform.isIOS ? "capture" : "store";
        _suffixMsg =
            " to set your profile picture"; // Add one white space at starting of message.
        break;
      case ImageSource.gallery:
        _isGranted = await AppPermissionsService.isGalleryPermissionGranted;
        _sourceName = Platform.isIOS ? "Photos" : "Storage";
        _media = "access";
        _suffixMsg =
            " to set your profile picture"; // Add one white space at starting of message.
        break;
    }

    // "Go to Settings - $_sourceName and grant permission to $_media photo$_suffixMsg.",
    if (!_isGranted) {
      showAlert(
        context: context,
        message:
            "Go to Settings - $_sourceName and grant permission to $_media photo$_suffixMsg.",
        title: "Permission denied",
        signleBttnOnly: false,
        leftBttnTitle: "Settings",
        rigthBttnTitle: "Cancel",
        onLeftAction: () {
          openAppSettings();
        },
      );
    }

    return _isGranted;
  }
}
