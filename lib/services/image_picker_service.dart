import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';

import '../../widgets/custom_alert.dart';
import '../../widgets/custom_text.dart';
import '../utils/custom_extension.dart';
import 'app_permissions_service.dart';

class ImagePickerService {
  ImagePickerService({
    required this.pickedImg,
    this.onRemovePhoto,
    this.isDocumentsFile = false,
  });
//-------------------------------------------------------------------- Variable ----------------------------------------------------------------------------------//

  final ImagePicker _picker = ImagePicker();
  void Function(List<String>?) pickedImg;
  void Function()? onRemovePhoto;
  final bool isDocumentsFile;

  Future<String> _pickImage(ImageSource source) async {
    // Pick an image...
    final XFile? _image =
        await _picker.pickImage(source: source, imageQuality: 50);
    return _image?.path ?? "";
  }

  Future<String> pickVideo(ImageSource source) async {
    // Pick an image...
    final XFile? _video = await _picker.pickVideo(source: source);
    return _video?.path ?? "";
  }

  /// Pick multiple image...
  Future<List<String>> _pickMultipleImage() async {
    // Pick an image...
    final List<XFile> _images = await _picker.pickMultiImage(imageQuality: 50);
    return (_images.isEmpty)
        ? []
        : _images.map<String>((img) => img.path).toList();
  }

  // Open image picker ...
  Future<void> openImagePikcer({
    required bool multipicker,
    required BuildContext context,
    required bool iosImagePicker,
  }) async {
    return iosImagePicker
        // Image picker android
        ? _buildImagePickerForIOS(context, multipicker)
        // Image picker ios
        : _buildImagePickerForAndroid(context, multipicker);
  }

  //-------------------------------------------------------------------- Image Picker For Android----------------------------------------------------------------------------------//

  Future<void> _buildImagePickerForAndroid(
    BuildContext context,
    bool multipicker,
  ) async {
    showDialog<List<String>?>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                txtTitle: "Select Image Options",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (isDocumentsFile)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            try {
                              Navigator.of(ctx).pop();
                              if (await _isCameraAndGalleryPermissionAllowed(
                                context,
                                ImageSource.gallery,
                              )) {
                                final FilePickerResult? _selectedImg =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf', 'doc'],
                                );

                                // final List<String> _croppedFile = [];

                                // for (final String imgPath in _selectedImg) {
                                //   // Send image for cropping...
                                //   _croppedFile.add(
                                //     await _compressImage(
                                //       (await getCroppedImage(imgPath))?.path ??
                                //           imgPath,
                                //     ),
                                //   );
                                // }
                                final List<String> _docs = _selectedImg?.files
                                        .map((e) => e.path ?? "")
                                        .toList() ??
                                    [];
                                _docs.removeWhere(
                                  (imgPath) => imgPath.isEmpty,
                                );
                                pickedImg(_docs);
                              }
                            } catch (e) {
                              if (kDebugMode) {
                                print(e.toString());
                              }
                              rethrow;
                            }
                          },
                          icon: Icon(
                            Icons.upload_file_outlined,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        CustomText(
                          txtTitle: StaticString.documents,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ...ImageSource.values
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
                                    final List<String> _selectedImg =
                                        multipicker
                                            ? await _pickMultipleImage()
                                            : [await _pickImage(source)];

                                    _selectedImg.removeWhere(
                                      (imgPath) => imgPath.isEmpty,
                                    );

                                    final List<String> _croppedFile = [];

                                    for (final String imgPath in _selectedImg) {
                                      // Send image for cropping...
                                      _croppedFile.add(
                                        await _compressImage(
                                          (await getCroppedImage(imgPath))
                                                  ?.path ??
                                              imgPath,
                                        ),
                                      );
                                    }

                                    pickedImg(_croppedFile);
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

//-------------------------------------------------------------------- Image Picker For IOS ----------------------------------------------------------------------------------//

  Future<void> _buildImagePickerForIOS(
    BuildContext context,
    bool multipicker,
  ) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: <Widget>[
          // Upload document button...
          if (isDocumentsFile)
            _buildCupertinoActionSheetAction(
              context: context,
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  if (await _isCameraAndGalleryPermissionAllowed(
                    context,
                    ImageSource.gallery,
                  )) {
                    final FilePickerResult? _selectedImg =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf', 'doc'],
                    );

                    // final List<String> _croppedFile = [];

                    // for (final String imgPath in _selectedImg) {
                    //   // Send image for cropping...
                    //   _croppedFile.add(
                    //     await _compressImage(
                    //       (await getCroppedImage(imgPath))?.path ?? imgPath,
                    //     ),
                    //   );
                    // }
                    final List<String> _docs =
                        _selectedImg?.files.map((e) => e.path ?? "").toList() ??
                            [];
                    _docs.removeWhere(
                      (imgPath) => imgPath.isEmpty,
                    );
                    pickedImg(_docs);
                  }
                } catch (e) {
                  if (kDebugMode) {
                    print(e.toString());
                  }
                  rethrow;
                }
              },
              buttonText: StaticString.uploadDocuments,
            )
          else
            Container(),

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
                  final List<String> _selectedImg = multipicker
                      ? await _pickMultipleImage()
                      : [
                          await _pickImage(ImageSource.gallery),
                        ];

                  _selectedImg.removeWhere(
                    (imgPath) => imgPath.isEmpty,
                  );

                  final List<String> _croppedFile = [];

                  for (final String imgPath in _selectedImg) {
                    // Send image for cropping...
                    _croppedFile.add(
                      await _compressImage(
                        (await getCroppedImage(imgPath))?.path ?? imgPath,
                      ),
                    );
                  }

                  pickedImg(_croppedFile);
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
                  final List<String> _selectedImg = [
                    await _pickImage(ImageSource.camera)
                  ];

                  _selectedImg.removeWhere(
                    (imgPath) => imgPath.isEmpty,
                  );

                  final List<String> _croppedFile = [];

                  for (final String imgPath in _selectedImg) {
                    // Send image for cropping...
                    _croppedFile.add(
                      await _compressImage(
                        (await getCroppedImage(imgPath))?.path ?? imgPath,
                      ),
                    );
                  }

                  pickedImg(_croppedFile);
                }
              } catch (e) {
                print(e.toString());
                rethrow;
              }
            },
            buttonText: StaticString.takeAPhoto,
          ),
          // Remove photo button...
          if (onRemovePhoto == null)
            const SizedBox()
          else
            _buildCupertinoActionSheetAction(
              context: context,
              buttonText: StaticString.removePhoto,
              onPressed: onRemovePhoto!,
            )
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

  static int get utcEpochTime => DateTime.now().toUtc().millisecondsSinceEpoch;

  // Compress image...
  static Future<String> _compressImage(String img) async {
    if (img.isEmpty) return "";
    if (!img.isImage) return img;
    // print("Before COmpress:${getTotalImageSize([img])}");
    // final Directory tempDir = await getTemporaryDirectory();
    // print("Original Img Path:$img");
    // final String targetPath = "${tempDir.path}/$utcEpochTime.png";
    // final File? compressedFile = await FlutterImageCompress.compressAndGetFile(
    //   img,
    //   targetPath,
    //   format: CompressFormat.png,
    // );
    // print("Compress path: ${compressedFile?.path}");
    // print("After COmpress:${getTotalImageSize([compressedFile?.path ?? img])}");
    // return compressedFile?.path ?? img;
    return img;
  }

  // Get total image size...
  static double getTotalImageSize(List<String> imagesPath) {
    if (imagesPath.isEmpty) {
      return 0.0;
    } else {
      final List<double> totalImageSizes = imagesPath
          .map<double>(
            (img) => double.tryParse(File(img).getFileSizeInMb) ?? 0.0,
          )
          .toList();
      return totalImageSizes.isEmpty
          ? 0.0
          : totalImageSizes.reduce((a, b) => a + b);
    }
  }

  Future<CroppedFile?> getCroppedImage(String sourceImgPath) async {
    return ImageCropper().cropImage(
      sourcePath: sourceImgPath,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              // CropAspectRatioPreset.ratio3x2,
              // CropAspectRatioPreset.original,
              // CropAspectRatioPreset.ratio4x3,
              // CropAspectRatioPreset.ratio16x9
            ]
          : [
              // CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              // CropAspectRatioPreset.ratio3x2,
              // CropAspectRatioPreset.ratio4x3,
              // CropAspectRatioPreset.ratio5x3,
              // CropAspectRatioPreset.ratio5x4,
              // CropAspectRatioPreset.ratio7x5,
              // CropAspectRatioPreset.ratio16x9
            ],
      cropStyle: CropStyle.circle,
      compressQuality: 50,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        )
      ],
    );
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
        title: "Permission Denied",
        // signleBttnOnly: false,
        singleBtnTitle: "Settings",
        // rigthBttnTitle: "Cancel",
        onRightAction: () {
          openAppSettings();
        },
      );
    }

    return _isGranted;
  }
//-------------------------------------------------------------------- Button Action----------------------------------------------------------------------------------//

//   // Pick from library
//   void pickFromlibraryButtonAction() {
//     Get.back();
//   }

// // Take a photo Action
//   void takeAPhotoButtonAction({required BuildContext context}) {
//     Get.back();
//   }

// // Cancle story action...
//   void _cancleButtonAction() {
//     Get.back();
//   }
}
