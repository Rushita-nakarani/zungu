// import 'package:flutter/material.dart';

// import '../widgets/guarantor.dart';
// import '../widgets/guarantor_form.dart';
// import '../widgets/tenant.dart';
// import '../widgets/tenant_form.dart';

// class FormHideProvider with ChangeNotifier {
//   final List<GuarantorForm> _guarantorUsers = [];
//   final List<TenantForm> _users = [];
//   List<TenantForm> get users => users;
//   List<GuarantorForm> get guarantorUsers => _guarantorUsers;
//   List<TenantForm> tenantForms = List.empty(growable: true);

//   bool? tenantExpansion = false;
//   bool? guarantorExpansion = false;
//   bool? propertyExpansion = false;
//   bool? landlordBankExpansion = false;
//   bool? billButtonExpansion = false;
//   TextEditingController tenantNameController = TextEditingController();
//   TextEditingController tenantMobileController = TextEditingController();
//   TextEditingController tenantaddressController = TextEditingController();

//   TextEditingController guarantorNameController = TextEditingController();
//   TextEditingController guarantorMobileController = TextEditingController();
//   TextEditingController guarantoraddressController = TextEditingController();

//   void isTenantExpand(bool value) {
//     tenantExpansion = value;

//     final Tenants _tenant = Tenants();
//     tenantForms.add(
//       TenantForm(
//         tenantAddressController: tenantaddressController,
//         tenantMobileNumberController: tenantMobileController,
//         tenantNameController: tenantNameController,
//         tenant: _tenant,
//         onDelete: () {
//           onDeleteTenantForm(_tenant);
//         },
//         index: tenantForms.length,
//       ),
//     );
//     print(_tenant.id);
//     notifyListeners();
//   }

//   void isguarantorExpand(bool value) {
//     guarantorExpansion = value;
//     final _guarantorUser = Guarantor();
//     _guarantorUsers.add(
//       GuarantorForm(
//         guarantorAddressController: guarantoraddressController,
//         guarantorMobileNumberController: guarantorMobileController,
//         guarantorNameController: guarantorNameController,
//         guarantorUser: _guarantorUser,
//         onDelete: () => onDeleteGuarantorForm(_guarantorUser),
//         index: _guarantorUsers.length,
//       ),
//     );
//     notifyListeners();
//   }

//   void isPropertyExpand(bool value) {
//     propertyExpansion = value;
//     notifyListeners();
//   }

//   void isLandlordExpand(bool value) {
//     landlordBankExpansion = value;
//     notifyListeners();
//   }

//   void isButtonExpand(bool value) {
//     billButtonExpansion = value;
//     notifyListeners();
//   }

//   ///on Delete Tenantform
//   void onDeleteTenantForm(Tenants _user) {
//     // print("dfjdhg");
//     // final int index =
//     //     tenantForms.indexWhere((element) => element.tenant!.id == _user.id);
//     // tenantForms.removeAt(index);
//     final find = tenantForms.firstWhere(
//       (it) => it.tenant == _user,
//       orElse: () => null!,
//     );
//     tenantForms.removeAt(tenantForms.indexOf(find));

//     notifyListeners();
//   }

//   ///on add Tenantform
//   void onAddTenantForm() {
//     final Tenants _tenant = Tenants(id: tenantForms.length);
//     tenantForms.add(
//       TenantForm(
//         index: tenantForms.length,
//         tenant: _tenant,
//         onDelete: () => onDeleteTenantForm(_tenant),
//       ),
//     );
//   }

//   ///on Delete Guarantorform
//   void onDeleteGuarantorForm(Guarantor _guarantorUser) {
//     print("hi");
//     final find = _guarantorUsers.firstWhere(
//       (it) => it.guarantorUser == _guarantorUser,
//       orElse: () => null!,
//     );
//     _guarantorUsers.removeAt(_guarantorUsers.indexOf(find));
//     notifyListeners();
//   }

//   ///on Add Guarantorform
//   void onAddGuarantorForm() {
//     final _guarantorUser = Guarantor();
//     _guarantorUsers.add(
//       GuarantorForm(
//         guarantorUser: _guarantorUser,
//         onDelete: () => onDeleteGuarantorForm(_guarantorUser),
//         index: _guarantorUsers.length,
//       ),
//     );
//     notifyListeners();
//   }
// }
