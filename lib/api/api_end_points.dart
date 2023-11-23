// API Setup...
class APISetup {
  static const String kGoogleApiKey = "AIzaSyDoy5mVDqz72t0zizbNPfeU_Wba_bhANaQ";

  static const String productionURL =
      "https://dev-api.zungu.co.uk/api/$apiVersion/";
  static const String staggingURL =
      "https://dev-api.zungu.co.uk/api/$apiVersion/";
  static const String apiVersion = "v1";
  static const String titleKey = 'title';
  static const String countKey = 'count';
  static const String pageKey = 'page';
  static const String sizeKey = 'size';
  static const String messageKey = 'message';
  static const String dataKey = 'data';
  static const String paginationSize = '&size=10';
}

// Auth...
class AuthEndPoints {
  static const String _auth = "auth/";
  static const String _otp = "${_auth}otp/";
  static const String _user = "${_auth}user/";
  static const String _admin = "admin/";
  static const String _authProfile = "${_auth}profile/";
  static const String _profile = "profile/";

  static const String loggedin = "${_user}login";
  static const String register = "${_user}register";
  static const String logout = "${_user}logout";
  static const String changePassword = "${_user}change/password";
  // static const String  userFetch = "${_user}fetch";
  static const String forgotPassword = "${_user}forgot/password";
  static const String reloadSession = "${_user}reload/session";
  static const String deleteAccount = "${_user}delete/account";
  static const String numberChange = "${_user}mobile/edit";
  static const String otpGenerate = "${_otp}generate";
  static const String otpVerify = "${_otp}verify";
  static const String fetchRole = "${_admin}role/fetch?source=MOBILE";
  static const String fetchFAQ = "${_admin}faq/fetch";
  static const String contactUS = "${_admin}support/message/add";
  static const String bussinessFetch = "${_admin}business/fetch";
  static const String bussinessUpdate = "${_profile}update";
  static const String subscriptionVerify = "${_profile}subscription/verify";
  static const String fetchTutorial = "${_admin}tutorial/fetch?";
  static const String fetchLegalDetail = "${_admin}legaldetail/fetch/";
  static const String startFreeTrial = "${_authProfile}free/trial";
  static const String userFetch = "${_profile}user/fetch";
  static const String userFetchAll = "${_profile}fetch/all";
  static const String userDataUpdate = "${_profile}user/update";
  static const String fetchUserProfile = "${_profile}fetch";
  static const String fetchUserSubscriptions = "${_profile}user/subscriptions";
  static const String switchProfie = "${_profile}switch";
  static const String fetchTrdaesOffers = "${_profile}fetch/tradeservice";
  static const String updateTrdaesOffers = "${_profile}update/tradeservice";
  static const String fetchTrdeasDocuments = "${_admin}tradedocumenttype/fetch";
  static const String fetchTrdeasDocument = "${_profile}fetch/tradedocument";
  static const String updateTrdeasDocument = "${_profile}update/tradedocument";
  static const String trdaesServiceSearch = "${_profile}profession/search";
}

class BusinessProfileEndPoints {
  static const String _admin = "admin/";

  static const String professionFetch = "${_admin}profession/fetch?";
}

// ignore: avoid_classes_with_only_static_members
class LandloardApiEndPoint {
  static const String _leases = "lease/";
  static const String createLeasesCountrySelectedApi =
      "${_leases}type/unique/country";
  static const String createLeaseType = "${_leases}type/";
  static const String createDetailsLeases = "${_leases}detail/create";
  static String generateLeaseAgreement(String id) =>
      "${_leases}agreement/$id/generate";
  static const String leaesRenew = "${_leases}manual/renew";
  static const String activeLeases = "${_leases}list/active";
  static const String updateLeaseUrl = "${_leases}update/url";
}

class ImmgUploadEndPoints {
  static const String _resource = "resource/";
  static const String config = "${_resource}config/upsert";
  static const String uploadDocument = "${_resource}upload/document";
}

// Dashboard...
class DashboardEndPoints {
  static const String _dashboard = "dashboard";
  static const String _property = "property/";

  static const String landlordDashboard = "$_dashboard/landlord";
  static const String tenantDashboard = "$_dashboard/tenant";
  static const String tradesmanDashboard = "$_dashboard/tradesperson";
  static const String fetchTenancy = "${_property}tenant/mytenancy/fetch";
}

class MyTenancyEndPoints {
  static const String deleteTeanncyProperty = "property/tenant/tenancy/";
}

class LandLordEndPoints {
  static const String _property = "property";
  static const String _tenant = "tenant";
  static const String _finance = "finance";

  static const String fetchCategory = "$_property/category/fetch";
  static const String fetchPropertyTypeById = "$_property/type/fetch/";
  static const String fetchPropertyDetailUpsert = "$_property/detail/upsert";
  static const String fetchDraftProperty = "$_property/draft";
  static const String delteProperty = "$_property/delete/";
  static const String addProperty = "$_property/add";
  static const String fetchProperty = "$_property/feature/fetch";
  static const String fetchPropertyList = "$_property/fetch/list";
  static const String propertyTenantAdd = "$_property/$_tenant/add";
  static const String propertyTenantEdit = "$_property/$_tenant/edit";
  static const String fetchStaticProperty = "$_property/fetch/statics";
  static const String fetchPropertyDetails = "$_property/details/";
  static const String fetchPropertyInfo = "$_property/fetch/info/";
  static const String fetchPropertyFilter = "$_property/filter?";
  static const String checkPropertyExistence = "$_property/check/existence";
  static const String fetchCurrentTenant =
      "$_property/$_tenant/current/tenants/fetch";
  static const String fetchTenantById = "$_property/$_tenant/fetch/";
  static const String propertyTenancy = "$_property/$_tenant/tenancy/";
  static const String addTenancy = "$_property/$_tenant/add/mytenancy";

  static const String fetchFinanceById = "$_finance/fetch/";
  static const String addFinanceDetails = "$_finance/upsert";
}

class ProfileEndPoints {
  static const String profileExist = "profile/exist";
}

class UtilityEndPoints {
  static const String attributeList = "utility/attribute/list";
}

class NotificationEndPoints {
  static const String _notification = "notification";

  static const String fetchNotification = "$_notification/list";
  static const String readNotification = "$_notification/read";
  static const String clearAllNotification = "$_notification/clearAll";
}

class LeaseEndPoints {
  static const String _lease = "lease";

  static const String leaseEsign = "$_lease/esign";
  static const String fetchESignedLeaseList = "$_lease/list/esigned";
  static const String deleteESignLease = "$_lease/esign/delete/";
  static const String leaseDetail = "$_lease/detail";
  static const String renewEsignLease = "$_lease/esigned/renew";
  static const String leaseFetchByStatus = "$_lease/fetch";
  static const String leaseEsigntenantAdd = "$_lease/esign/tenant/add";
  static const String leaseEsigntenantupdate = "$_lease/esign/tenant/update";
  static const String leaseSignGuarantor = "$_lease/sign/guarantor";
}
