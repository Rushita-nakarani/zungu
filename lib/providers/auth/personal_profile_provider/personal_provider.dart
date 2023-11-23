import 'package:flutter/foundation.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/api/api_end_points.dart';
import 'package:zungu_mobile/api/api_middleware.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/auth/auth_model.dart';
import 'package:zungu_mobile/models/settings/business_profile/fetch_profile_model.dart';
import 'package:zungu_mobile/models/settings/personal_profile/user_profile_model.dart';

import '../../../models/settings/business_profile/business_profile_model.dart';
import '../../../models/settings/business_profile/bussiness_type_model.dart';
import '../../../models/settings/business_profile/trades_service_model.dart';
import '../../../models/settings/business_profile/view_edit_trades_document_model.dart';
import '../../../models/settings/personal_profile/contact_us_attribute_model.dart';

class PersonalProfileProvider extends ChangeNotifier {
  UserProfileModel? _fetchUser;

  List<BussinessProfileModel> _bussinessUserList = [];

  FetchProfileModel? fetchProfileModel;
  ViewEditTradesDocumentModel? viewEditTradesDocumentModel;

  BusinessTypeModel? businessTypeModel;
  MyLocation? myLocation;

  MyLocation? get getMyLocation => myLocation;

  set setMyLocation(MyLocation? myLocation) {
    this.myLocation = myLocation;
    notifyListeners();
  }

  TradesServiceModel? tradesServiceModel;

  List<BussinessData> _businessTypeList = [];

  List<TradesServiceModel> trdaeService = [];
  List<TradesService> _tradesserviceList = [];
  List<TradesService> tradesServiceNameList = [];

  List<TradesService> get tradesserviceList => _tradesserviceList;

  set tradesserviceList(List<TradesService> value) {
    _tradesserviceList = value;
    notifyListeners();
  }

  List<BussinessData> get businessTypeList => _businessTypeList;

  set businessTypeList(List<BussinessData> value) {
    _businessTypeList = value;
    notifyListeners();
  }

  FetchProfileModel? get getFetchProfileModel => fetchProfileModel;

  set setFetchProfileModel(FetchProfileModel? fetchProfileModel) {
    this.fetchProfileModel = fetchProfileModel;
    notifyListeners();
  }

  List<FetchProfileModel> _servicesList = [];

  List<ContactUsAttributeModel> _contactAttributeList = [];

  List<ContactUsAttributeModel> get contactAttributeList =>
      _contactAttributeList;

  set contactAttributeList(List<ContactUsAttributeModel> value) {
    _contactAttributeList = value;
    notifyListeners();
  }

  List<FetchProfileModel> get servicesList => _servicesList;

  set servicesList(List<FetchProfileModel> value) {
    _servicesList = value;
    notifyListeners();
  }

  BussinessProfileModel? bussinessProfileModel;
  List<BussinessProfileModel> get bussinessUserList => _bussinessUserList;

  set bussinessUserList(List<BussinessProfileModel> value) {
    _bussinessUserList = value;
    notifyListeners();
  }

  AuthModel? _authModel;

  AuthModel? get authModel => _authModel;

  set authModel(AuthModel? value) {
    _authModel = value;
    notifyListeners();
  }

  UserProfileModel? get fetchUser => _fetchUser;
  set fetchUser(UserProfileModel? value) {
    _fetchUser = value;
    notifyListeners();
  }

  List<ViewEditTradesDocumentModel> _viewEditTradesDocumentList = [];
  List<ViewEditTradesDocumentModel> get viewEditTradesDocumentList =>
      _viewEditTradesDocumentList;

  set viewEditTradesDocumentList(List<ViewEditTradesDocumentModel> value) =>
      _viewEditTradesDocumentList = value;

  void logout() {
    _authModel = null;
    _fetchUser = null;
  }

  Future<void> userUpdate(UserProfileModel? userProfileModel) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.userDataUpdate,
          requestType: HTTPRequestType.PUT,
          parameter: userProfileModel?.userUpdateJson(),
        ),
      );
      fetchUserDetails();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchUserDetails() async {
    final Map<String, dynamic> _parms = {"userId": authModel?.userId};
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.userFetch,
          requestType: HTTPRequestType.GET,
          parameter: _parms,
        ),
      );
      final List<UserProfileModel> _fetchUserList =
          userProfileModelFromJson(response);

      if (_fetchUserList.isNotEmpty) {
        fetchUser = _fetchUserList.first;
        fetchUser?.userId = authModel?.userId ?? "";
        authModel?.fullName = fetchUser?.fullName ?? "";
        authModel?.profileImg = fetchUser?.profileImg ?? "";
      }
    } catch (e) {
      rethrow;
    }
  }

// bussiness profile api...
  Future<void> businessUserDetail() async {
    final Map<String, dynamic> _parms = {"userId": authModel?.userId};
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.userFetchAll,
          requestType: HTTPRequestType.GET,
          parameter: _parms,
        ),
      );
      bussinessUserList = bussinessProfileModelFromJson(response);

      // print(bussinessUserList.map((e) => e.roleName));
    } catch (e) {
      rethrow;
    }
  }

//   edit Profile businesstype api..
  Future<void> businessTypeApi() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.bussinessFetch,
          requestType: HTTPRequestType.GET,
        ),
      );
      businessTypeModel = businessTypeModelFromJson(response);
      if (businessTypeModel != null) {
        businessTypeList = businessTypeModel?.data ?? [];
      }
    } catch (e) {
      rethrow;
    }
  }

  // landloard update Profile...
  Future<void> updatelandLoardProfile(
    FetchProfileModel? fetchProfileModel,
    String roleId, {
    bool isFromLandlord = false,
  }) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.bussinessUpdate,
          parameter: fetchProfileModel?.userUpdateJson(
            roleId,
            authModel?.userId ?? "",
          ),
        ),
      );
      businessTypeApi();
      fetchUserProfile(roleId, isFromLandlord: isFromLandlord);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchUserProfile(
    String roleId, {
    bool isFromLandlord = false,
  }) async {
    final Map<String, dynamic> _parms = {
      "roleId": roleId,
    };

    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.fetchUserProfile,
          parameter: _parms,
        ),
      );

      servicesList = fetchProfileListModelFromJson(response);

      if (servicesList.isNotEmpty) {
        fetchProfileModel = servicesList.first;
      }

      if (!isFromLandlord) {
        final String profileId = fetchProfileModel?.id ?? "";
        await fetchTradesOfferedService(profileId);
        await fetchTradesDocuments(profileId, roleId);
      }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
  // UtilityEndPoints

  Future<void> contactUsAtribute() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url:
              "${UtilityEndPoints.attributeList}?${StaticString.attributeType}=${StaticString.contact_Us}",
          requestType: HTTPRequestType.GET,
          parameter: {
            StaticString.attributeType: StaticString.contact_Us,
          },
        ),
      );
      contactAttributeList = contactUsAttributeModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addContactUsData(
    String? name,
    String? mobile,
    String? message,
    String? attributeType,
  ) async {
    final Map<String, dynamic> _parms = {
      "type": attributeType,
      // "63357ad50e7bcc001341c141",
      "name": name,
      "mobile": mobile,
      "message": message,
      "userId": fetchUser?.userId
      // SharedPreferencesHelper.instance.getUserInfo?.userId,
    };
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.contactUS,
          parameter: _parms,
        ),
      );

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // FetchTradesProfile...
  Future<void> fetchTradesOfferedService(String profileeId) async {
    try {
      Map<String, dynamic> _parms() => {"profileId": profileeId};
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.fetchTrdaesOffers,
          requestType: HTTPRequestType.GET,
          parameter: _parms(),
        ),
      );
      tradesServiceModel = tradesServiceModelFromJson(response);

      tradesserviceList = tradesServiceModel?.services ?? [];

      tradesServiceNameList = tradesserviceList
          .where((service) => service.child.any((e) => e.isToggle))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  // update Trades Profile...
  Future<void> updateTradesOfferedService(
    List<TradesService> tradesServiceModel,
    String roleId,
  ) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.updateTrdaesOffers,
          parameter: {
            "services": tradesServiceModel.map((e) => e.toJson()).toList()
          },
        ),
      );
      fetchTradesOfferedService(roleId);
    } catch (e) {
      rethrow;
    }
  }

  // update MyLocation...
  Future<void> updateMylocation({
    required FetchProfileModel? fetchProfileModel,
    required String roleId,
  }) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.bussinessUpdate,
          parameter: fetchProfileModel?.userUpdateJson(
            roleId,
            authModel?.userId ?? "",
          ),
        ),
      );
      fetchUserProfile(roleId);
    } catch (e) {
      rethrow;
    }
  }

  // FetchTradesProfile...
  Future<void> fetchTradesDocuments(String profileId, String roleId) async {
    try {
      Map<String, dynamic> _parms() => {
            "profileId": profileId,
            "roleId": roleId,
          };
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.fetchTrdeasDocument,
          parameter: _parms(),
        ),
      );
      viewEditTradesDocumentList =
          viewEditTradesDocumentModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // update trdaes documents...
  Future<void> updateTradesDocument({
    required List<ViewEditTradesDocumentModel> trdaesdocument,
    required String profileId,
    required String roleId,
  }) async {
    try {
      List<ViewEditTradesDocumentModel> _trdaesDocument = [];
      _trdaesDocument = trdaesdocument.where((element) {
        if (element.documentList.isEmpty &&
            element.deletedDocuments.isNotEmpty) {
          return true;
        }
        return element.documentList.isNotEmpty;
      }).toList();
      final Map<String, dynamic> _parms = {
        "profileId": profileId,
        "roleId": roleId,
        "tradeDocuments": _trdaesDocument
            .map(
              (e) => e.toUploadJson(),
            )
            .toList()
      };
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.updateTrdeasDocument,
          parameter: _parms,
        ),
      );
      await fetchUserProfile(roleId);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TradesService>> tradesServiceSearch(
    String name,
  ) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: AuthEndPoints.trdaesServiceSearch,
          parameter: {"name": name},
        ),
      );

      return tradesServiceListFromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
