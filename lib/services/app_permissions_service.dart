import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import '../../utils/push_notification.dart';

class AppPermissionsService {
  AppPermissionsService._();

  // Check photos permission...
  static Future<bool> get isContactPermissionGranted async {
    _isPermissionGranted(await Permission.contacts.status);
    return _isPermissionGranted(
      await Permission.contacts.request(),
    );
  }

  // Check photos permission...
  static Future<bool> get isGalleryPermissionGranted async {
    _isPermissionGranted(
      Platform.isIOS
          ? await Permission.photos.status
          : await Permission.storage.status,
    );

    return _isPermissionGranted(
      Platform.isIOS
          ? await Permission.photos.request()
          : await Permission.storage.request(),
    );
  }

  // Check camera permission...
  static Future<bool> get checkCameraPermission async {
    _isPermissionGranted(await Permission.camera.status);
    return _isPermissionGranted(
      Platform.isIOS
          ? await Permission.camera.request()
          : await Permission.storage.request(),
    );
  }

  static Future<bool> get checkNotificationPermission async {
    return PushNotification.instance.getNotificationPermission();
  }

  // Check location permission
  static Future<bool> get getLocationPermission async {
    bool isGranted = _isPermissionGranted(await Permission.location.status);
    if (!isGranted) {
      isGranted = _isPermissionGranted(
        await Permission.location.request(),
      );
    }
    return isGranted;
  }

  static bool _isPermissionGranted(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.limited:
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }
}
