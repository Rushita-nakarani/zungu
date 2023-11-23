class TenancyTenant {
  String mobile;
  int selectedRoom;
  String tenantName;
  String tenantEmail;
  String rentalAmount;
  String rentDueDate;
  String depositPaid;
  String depositScheme;
  String depositId;
  String tenancyStartDate;
  String tenancyEndDate;
  List<String> prefillImages;

  TenancyTenant({
    required this.mobile,
    required this.selectedRoom,
    required this.tenantName,
    required this.tenantEmail,
    required this.rentalAmount,
    required this.rentDueDate,
    required this.depositPaid,
    required this.depositScheme,
    required this.depositId,
    required this.tenancyStartDate,
    required this.tenancyEndDate,
    this.prefillImages = const [],
  });
}
