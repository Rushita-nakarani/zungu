import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/api/api_end_points.dart';
import 'package:zungu_mobile/api/api_middleware.dart';
import 'package:zungu_mobile/models/api_response_obj.dart';

class ImgUploadService {
  ImgUploadService._();

  static ImgUploadService instance = ImgUploadService._();

  Future<List<String>> uploadProfilePicture({
    required List<String> images,
    String key = "profileId",
    ProfileUploadType profileUploadType = ProfileUploadType.PROFILE_PICTURES,
    required String? id,
  }) async {
    try {
      if (images.isEmpty) {
        return [];
      }
      String _key = key;
      if (profileUploadType == ProfileUploadType.TRADESMAN_DOCUMENT) {
        _key = "userId";
      }
      final Map<String, dynamic> _uploadParms = {
        "type": profileUploadType.name,
        _key: id
      };

      // API request...
      final APIRequestInfo _uploadRequestInfo = APIRequestInfo(
        url: ImmgUploadEndPoints.uploadDocument,
        parameter: _uploadParms,
        docList: [
          UploadDocument(docKey: "upload", docPathList: images),
        ],
      );

      // Call api...
      final String response = await ApiMiddleware.instance
          .callService(requestInfo: _uploadRequestInfo);
      return List<String>.from(
        defaultRespInfo(response).resultObj['urls'].map((x) => x),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> uploadPropertyPictures({
    required List<String> images,
    String key = "propertyId",
    required String? id,
    UploadType uploadType = UploadType.PROPERTYPICTURES,
  }) async {
    try {
      if (images.isEmpty) {
        return images;
      }
      final Map<String, dynamic> _uploadParms = {
        "type": _uploadType(uploadType),
        key: id
      };

      // API request...
      final APIRequestInfo _uploadRequestInfo = APIRequestInfo(
        url: ImmgUploadEndPoints.uploadDocument,
        parameter: _uploadParms,
        docList: [
          UploadDocument(docKey: "upload", docPathList: images),
        ],
      );

      // Call api...
      final String response = await ApiMiddleware.instance
          .callService(requestInfo: _uploadRequestInfo);
      return List<String>.from(
        defaultRespInfo(response).resultObj['urls'].map((x) => x),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> uploadTenanciesPictures({
    required List<String> images,
    String key = "profileId",
    required String? value,
  }) async {
    try {
      if (images.isEmpty) {
        return images;
      }
      final Map<String, dynamic> _uploadParms = {
        "type": "OWN_TENANCY_PICTURE",
        key: value
      };

      // API request...
      final APIRequestInfo _uploadRequestInfo = APIRequestInfo(
        url: ImmgUploadEndPoints.uploadDocument,
        parameter: _uploadParms,
        docList: [
          UploadDocument(docKey: "upload", docPathList: images),
        ],
      );

      // Call api...
      final String response = await ApiMiddleware.instance
          .callService(requestInfo: _uploadRequestInfo);
      return List<String>.from(
        defaultRespInfo(response).resultObj['urls'].map((x) => x),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> upload({
  //   required BucketType bucketType,
  //   UploadType uploadType = UploadType.PROFILEPIC,
  //   bool isImages = true,
  //   required String path,
  //   required Map<String, dynamic> pathKeyID,
  //   bool isDeleted = false,
  //   bool versioning = false,
  //   required List<String> images,
  // }) async {
  //   try {
  //     // // Parms...
  //     // final Map<String, dynamic> _parms = {
  //     //   "configuration": {
  //     //     "type": _uploadType(uploadType),
  //     //     "bucket": _bucketName(bucketType),
  //     //     "path": path,
  //     //     "versioning": versioning,
  //     //     "multi": isImages ? 20 : 6,
  //     //     "isDeleted": isDeleted,
  //     //     "allowedMimeType": [
  //     //       "image/svg+xml",
  //     //       'image/png',
  //     //       'image/jpg',
  //     //       'image/jpeg',
  //     //       'application/msword',
  //     //       'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  //     //       'application/ms-doc',
  //     //       'application/doc',
  //     //       'application/vnd.ms-excel',
  //     //       'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
  //     //       'application/vnd.ms-powerpoint',
  //     //       'application/vnd.openxmlformats-officedocument.presentationml.presentation',
  //     //       'application/application/vnd.openxmlformats-officedocument.presentationml.slideshow'
  //     //     ]
  //     //   }
  //     // };

  //     // // API request...
  //     // final APIRequestInfo _requestInfo =
  //     //     APIRequestInfo(url: ImmgUploadEndPoints.config, parameter: _parms);

  //     // // Call api...
  //     // await ApiMiddleware.instance.callService(requestInfo: _requestInfo);
  //     // Parms...
  //     final Map<String, dynamic> _uploadParms = {
  //       "type": _uploadType(uploadType),
  //     };
  //     _uploadParms.addAll(pathKeyID);
  //     // API request...
  //     final APIRequestInfo _uploadRequestInfo = APIRequestInfo(
  //       url: ImmgUploadEndPoints.uploadDocument,
  //       parameter: _uploadParms,
  //       docList: [
  //         UploadDocument(docKey: "upload", docPathList: images),
  //       ],
  //     );

  //     // Call api...
  //     await ApiMiddleware.instance.callService(requestInfo: _uploadRequestInfo);
  //   } catch (e) {
  //     rethrow;
  //   }
}

//   String _bucketName(BucketType bucketType) {
//     String _bucket = "dev-zungu";
//     switch (bucketType) {
//       case BucketType.devZunguProperty:
//         _bucket = "dev-zungu-property";
//         break;
//       case BucketType.devZunguProfile:
//         _bucket = "dev-zungu-profile";
//         break;
//       case BucketType.devZungu:
//         _bucket = "dev-zungu";
//         break;
//     }
//     return _bucket;
//   }

String _uploadType(UploadType bucketType) {
  String _bucket = "IMAGES";
  switch (bucketType) {
    case UploadType.PROPERTYPICTURES:
      _bucket = "PROPERTY_PICTURES";
      break;
    case UploadType.PROPERTYVIDEO:
      _bucket = "PROPERTY_VIDEOS";
      break;
    case UploadType.PROFILEPIC:
      _bucket = "PROFILE_PICTURES";
      break;
    case UploadType.PROPERTYDOCS:
      _bucket = "PROPERTY_DOCS";
      break;
    case UploadType.PROPERTY_LEASAES:
       _bucket = "PROPERTY_LEASAES";
      break;
  }
  return _bucket;
}
// }

enum BucketType { devZunguProperty, devZunguProfile, devZungu }

enum UploadType { PROPERTYPICTURES, PROPERTYVIDEO, PROFILEPIC, PROPERTYDOCS, PROPERTY_LEASAES }

enum ProfileUploadType { PROFILE_PICTURES, TRADESMAN_DOCUMENT }
