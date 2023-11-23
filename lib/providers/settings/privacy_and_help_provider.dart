// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/api/api_middleware.dart';
import 'package:zungu_mobile/models/settings/business_profile/fetch_profile_model.dart';
import 'package:zungu_mobile/models/settings/contact_us.dart';
import 'package:zungu_mobile/models/settings/faq_data_model.dart';
import 'package:zungu_mobile/models/settings/video_tutorial_model.dart';

import '../../api/api_end_points.dart';

class PrivacyAndPolicyProvider extends ChangeNotifier {
  //-------------------------Variables--------------------------//

  // Contact us List
  List<ContactUsModel> _contactUsList = [];
 

  // Fetch Video Model and List
  FetchVideoModel? fetchVideoModel;
  List<FaqDataModel> _faqDataList = [];

  // Video Tutorial List
  List<VideoTutorials> _videoTutorialList = [];

  //----------------------getter/setter methods--------------------//

  // Contact us List getter/setter
  List<ContactUsModel> get contactUsList => _contactUsList;
  set contactUsList(List<ContactUsModel> value) {
    _contactUsList = value;
    notifyListeners();
  }

  // Faq Data List getter/setter
  List<FaqDataModel> get faqDataList => _faqDataList;
  set faqDataList(List<FaqDataModel> value) {
    _faqDataList = value;
    notifyListeners();
  }

  // Video Tutorial List getter/setter
  List<VideoTutorials> get videoTutorialList => _videoTutorialList;
  set videoTutorialList(List<VideoTutorials> value) {
    _videoTutorialList = value;
    notifyListeners();
  }

  //-----------------------------Functions------------------------------//

  // Add Contact us Data api call
  // Future<void> addContactUsData(
  //   String? name,
  //   String? mobile,
  //   String? message,
  // ) async {
  //   final Map<String, dynamic> _parms = {
  //     "type": "63357ad50e7bcc001341c141",
  //     "name": name,
  //     "mobile": mobile,
  //     "message": message,
  //     "userId": 
  //     // SharedPreferencesHelper.instance.getUserInfo?.userId,
  //   };
  //   try {
  //     final String response = await ApiMiddleware.instance.callService(
  //       requestInfo: APIRequestInfo(
  //         url: AuthEndPoints.contactUS,
  //         parameter: _parms,
  //       ),
  //     );
  //     contactUsList = contactUsModelFromJson(response);

  //     notifyListeners();
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  //  Fetch FaqData api call
  Future<void> fetchFaqData() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.fetchFAQ,
          requestType: HTTPRequestType.GET,
        ),
      );

      faqDataList = faqDataModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Video Tutorial api call
  Future<void> fetchVideoTutorial(int page) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: "${AuthEndPoints.fetchTutorial}page=$page&size=10",
          requestType: HTTPRequestType.GET,
        ),
      );
      fetchVideoModel = fetchVideoModelFromJson(response);
      if (page == 1) {
        videoTutorialList = fetchVideoModelFromJson(response).data;
      } else {
        videoTutorialList.addAll(fetchVideoModelFromJson(response).data);
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
