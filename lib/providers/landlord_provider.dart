// ignore_for_file: avoid_setters_without_getters, unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:zungu_mobile/models/api_response_obj.dart';
import 'package:zungu_mobile/models/landloard/category_info_model.dart';
import 'package:zungu_mobile/models/landloard/draft_property_model.dart';
import 'package:zungu_mobile/models/landloard/financial_overview_model.dart';
import 'package:zungu_mobile/models/landloard/property_feature_model.dart';
import 'package:zungu_mobile/models/landloard/upsert_detail_model.dart';

import '../api/api_end_points.dart';
import '../api/api_middleware.dart';
import '../models/landloard/attribute_info_model.dart';
import '../models/landloard/my_property_list_model.dart';
import '../models/landloard/properties_static_data_model.dart';
import '../models/landloard/property_detail_model.dart';
import '../models/submit_property_detail_model.dart';

class LandlordProvider with ChangeNotifier {
  //-------------------------Variables--------------------------//

  //Properties static Data model
  PropertiesStaticDataModel? propertiesStaticDataModel;

  //Properties List and model
  PropertiesListModel? _propertiesListModel;
  List<PropertiesList> _myPropertyList = [];

  //Properties Detail List
  List<PropertiesDetailModel> _propertiesDetailList = [];

  // Attribte list
  List<PropertyFeatureModel> _propertFeatureModelList = [];

  // Attribte list
  List<AttributeInfoModel> _attributeLists = [];

  // Category info list
  List<CategoryInfoModel> _categoryInfoList = [];

  Color getBookMarkColor = Colors.white;

  //----------------------getter/setter methods--------------------//

  //Properties Details getter/setter
  List<PropertiesDetailModel> get getPropertiesDetailList =>
      _propertiesDetailList;
  set setPropertiesDetailList(
    List<PropertiesDetailModel> value,
  ) {
    _propertiesDetailList = value;
    notifyListeners();
  }

  //Property List getter/setter
  List<PropertiesList> get myPropertyList => _myPropertyList;
  set myPropertyList(List<PropertiesList> value) {
    _myPropertyList = value;
    notifyListeners();
  }

  //PropertiesList Model getter/setter
  PropertiesListModel? get propertiesListModel => _propertiesListModel;
  set propertiesListModel(PropertiesListModel? value) {
    _propertiesListModel = value;
    notifyListeners();
  }

  //Properties Static Data getter/setter
  PropertiesStaticDataModel? get getPropertiesStaticDataModel =>
      propertiesStaticDataModel;
  set setPropertiesStaticDataModel(
    PropertiesStaticDataModel? value,
  ) {
    propertiesStaticDataModel = value;
    notifyListeners();
  }

  //Category List getter/setter
  List<CategoryInfoModel> get getCategoryList => _categoryInfoList;
  set setCategoryInfoList(List<CategoryInfoModel> value) {
    _categoryInfoList = value;
    notifyListeners();
  }

  // AttributeList getter/setter
  List<AttributeInfoModel> get getAttributeList => _attributeLists;
  set setAttributeList(List<AttributeInfoModel> value) {
    _attributeLists = value;
    notifyListeners();
  }

  // Attribute Getter/setter
  List<PropertyFeatureModel> get getPropertyElementModel =>
      _propertFeatureModelList;

  set setPropertyElementModel(
    List<PropertyFeatureModel> value,
  ) {
    _propertFeatureModelList = value;
    notifyListeners();
  }

//Financial OverView Data Model
  FinancialOverViewModel? _financialOverViewModelData;

//FinancialOverView Getter/Setter
  FinancialOverViewModel? get getFinancialOverViewModel =>
      _financialOverViewModelData;

  set setFinancialOverViewModel(FinancialOverViewModel value) {
    _financialOverViewModelData = value;
    notifyListeners();
  }

  //-----------------------------Functions--------------------------------//

  // Fetch Category List api call
  Future<void> fetchCategoryList() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LandLordEndPoints.fetchCategory,
          requestType: HTTPRequestType.GET,
        ),
      );
      setCategoryInfoList = listOfCategoryInfoModelFromJson(response);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Property List api call
  Future<void> fetchProperty() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LandLordEndPoints.fetchProperty,
          requestType: HTTPRequestType.GET,
        ),
      );

      setPropertyElementModel = listOfPropertyFeatureModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Property Type By Type Id api call
  Future<void> fetchPropertyTypeByTypeId(String catId) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LandLordEndPoints.fetchPropertyTypeById + catId,
          requestType: HTTPRequestType.GET,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  // Property Detail Upsert api call
  Future<UpsetProfileModel> propertyDetailUpsert({
    SubmitPropertyDetailModel? submitPropertyDetailModel,
    String? id,
  }) async {
    try {
      if (submitPropertyDetailModel != null) {
        switch (submitPropertyDetailModel.rentalType.toLowerCase()) {
          case "house":
          case "flats":
          case "hmo":
            submitPropertyDetailModel.name =
                "${submitPropertyDetailModel.bedRoom} Bed ${submitPropertyDetailModel.propertyTypeName} ${submitPropertyDetailModel.rentalType}";
            break;
          case "shops":
          case "office":
          case "industry":
            submitPropertyDetailModel.name =
                "${submitPropertyDetailModel.floorSize} ft ${submitPropertyDetailModel.className} ${submitPropertyDetailModel.rentalType} to Let";
            break;
          default:
        }
      }

      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LandLordEndPoints.fetchPropertyDetailUpsert,
          parameter: submitPropertyDetailModel == null
              ? {}
              : submitPropertyDetailModel.toJson(id),
        ),
      );
      return upsetProfileModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  //Check Property Existence api call
  Future<bool> checkPropertyExistence(
    String addressLine1,
    String zipCode,
  ) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url:
              "${LandLordEndPoints.checkPropertyExistence}?addressLine1=$addressLine1&zipCode=$zipCode",
          requestType: HTTPRequestType.GET,
        ),
      );

      return defaultRespInfo(response).resultObj['propertyExist'] == true;
    } catch (e) {
      rethrow;
    }
  }

  // Add Property Api call
  Future<void> addProperty(String propertyDetailID) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LandLordEndPoints.addProperty,
          parameter: {
            "property_detail_id": propertyDetailID,
          },
        ),
      );
      fetchPropertiesStaticData();
    } catch (e) {
      rethrow;
    }
  }

  // fetch Attribute List api call
  Future<void> attributeList({String attribute = "ELECTRONIC"}) async {
    try {
      if (attribute.isEmpty) {
        return;
      }
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.GET,
          url: "${UtilityEndPoints.attributeList}?attributeType=$attribute",
        ),
      );

      setAttributeList = listOfAttributeInfoModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Draft Property api call
  Future<DraftPropertyModel> draftProperty() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.GET,
          url: LandLordEndPoints.fetchDraftProperty,
        ),
      );

      return draftPropertyModelFromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  // Delete Property api call
  Future<void> deleteProperty(String id) async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.DELETE,
          url: LandLordEndPoints.delteProperty + id,
          parameter: {},
        ),
      );

      notifyListeners();
      fetchPropertiesStaticData();
      fetchPropertiesListData(1);
    } catch (e) {
      rethrow;
    }
  }

  // Delete Draft Property api call
  Future<void> deleteDraftProperty() async {
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          requestType: HTTPRequestType.DELETE,
          url: LandLordEndPoints.fetchDraftProperty,
          parameter: {},
        ),
      );

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Properties Details data api call
  Future<void> fetchPropertiesDetailsData({String propertyId = ""}) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: "${LandLordEndPoints.fetchPropertyDetails}$propertyId",
          requestType: HTTPRequestType.GET,
        ),
      );

      setPropertiesDetailList = propertiesDetailModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Fetch Properties List data api call
  Future<void> fetchPropertiesListData(
    int page, {
    PropertyfilterModel? propertyfilterModel,
    List<String> categoryIdList = const [],
  }) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: "${LandLordEndPoints.fetchPropertyFilter}page=$page&size=10",
          parameter: propertyfilterModel == null
              ? {
                  "isDeleted": false,
                  if (categoryIdList.isNotEmpty) "category": categoryIdList,
                }
              : propertyfilterModel.toJson(),
        ),
      );

      propertiesListModel = propertiesListModelFromJson(response);
      if (page == 1) {
        myPropertyList = propertiesListModel?.propertyList ?? [];
      } else {
        myPropertyList.addAll(propertiesListModel?.propertyList ?? []);
      }

      notifyListeners();
    } on AppException catch (e) {
      throw e.getMessage;
    } catch (e) {
      rethrow;
    }
  }

  // Fetch My Properties Static data api call
  Future<void> fetchPropertiesStaticData() async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LandLordEndPoints.fetchStaticProperty,
          requestType: HTTPRequestType.GET,
        ),
      );

      setPropertiesStaticDataModel =
          propertiesStaticDataModelFromJson(response);

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  //Fetch Financial Overview Details
  Future<void> fetchFinancialOverviewData({
    String? financeId,
  }) async {
    try {
      final String response = await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: "${LandLordEndPoints.fetchFinanceById}$financeId",
          requestType: HTTPRequestType.GET,
          parameter: {},
        ),
      );
      setFinancialOverViewModel = financialOverViewModelFromJson(response);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  //Add Financials Details
  Future<void> addFinancials(
    String? propertyDetailId,
    DateTime? purchaseDate,
    int purchasePrice,
    int outstandingMortgage,
    int mortgagePayment,
    int mortgagePaymentDate,
  ) async {
    final Map<String, dynamic> _parms = {
      "purchaseDate": purchaseDate?.toIso8601String(),
      "purchasePrice": purchasePrice,
      "outstandingMortgage": outstandingMortgage,
      "mortgagePayment": mortgagePayment,
      "mortgagePaymentDay": mortgagePaymentDate,
      "propertyDetailId": propertyDetailId,
    };
    try {
      await ApiMiddleware.instance.callService(
        requestInfo: APIRequestInfo(
          url: LandLordEndPoints.addFinanceDetails,
          parameter: _parms,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
