class AddTenantProfile {
  final String tenatProfilePic;
  final String tenantName;
  final String tenantMobile;
  final String? tenantEmail;

  AddTenantProfile({
    required this.tenatProfilePic,
    required this.tenantName,
    required this.tenantMobile,
    this.tenantEmail,
  });
}
