enum UserRole { LANDLORD, TENANT, TRADESPERSON, None }

enum TenantStatus { CURRENT, ENDED, PREVIOUS, None }

enum BussinessType { soleTrader, ltdCompany, partenerShip }

enum PropertyType { House, Flats, HMO, Shops, Office, Industry, None }

enum CurrentTenantsFilter { RESIDENTIAL, COMMERCIAL, HMO }

enum TenantReviewFilter { ALL, AWAITINGAPPROVAL, APPROVED, REJECTED }

enum SubscriptionType {Tradesperson, Property}

enum StatusType {
  pending,
  approved,
  rejected,
  underReview,
  uploadDoc,
  reUploadDoc,
}

enum InvoiceDateType {
  dateCompleted,
  paidDate,
  dateInvoiced,
  dueDate,
}

enum HtmlViewType { TC, DC, CP, PP }

enum EsignLeasesAction {
  
  ADD_NEW_TENANT,
  UPDATE_LEASE_DETAILS,
  DIFF_TENANT_EXIST,
  NONE,
}

class ESignType {
  static const String landlord = "LANDLORD_ESIGN";
  static const String tenant = "TENANT_ESIGN";
}
