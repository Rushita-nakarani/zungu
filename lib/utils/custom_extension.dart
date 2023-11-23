// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constant/img_font_color_string.dart';
import 'cust_eums.dart';

//String Extension...
extension StringExtension on String {
  bool get isImage =>
      toLowerCase().endsWith(".jpg") ||
      toLowerCase().endsWith(".jpeg") ||
      toLowerCase().endsWith(".png") ||
      toLowerCase().endsWith(".gif") ||
      toLowerCase().endsWith(".webp") ||
      toLowerCase().endsWith(".heic");

  // Remove Special character from string...
  String get removeSpecialCharacters =>
      trim().replaceAll(RegExp('[^A-Za-z0-9]'), '');

  // Process String...
  List<TextSpan> processCaption({
    String matcher = "#",
    TextStyle? fancyTextStyle,
    TextStyle? normalTextStyle,
    void Function(String)? onTap,
  }) {
    return split(' ')
        .map(
          (text) => TextSpan(
            text:
                '${text.toString().contains(matcher) ? text.replaceAll(matcher, "") : text} ',
            style: text.toString().contains(matcher)
                ? fancyTextStyle
                : normalTextStyle,
            recognizer: text.toString().contains(matcher)
                ? onTap == null
                    ? null
                    : (TapGestureRecognizer()..onTap = () => onTap(text))
                : null,
          ),
        )
        .toList();
  }

  String get toCapitalFirstLetter {
    return isEmpty ? "" : toFirstLetter.toUpperCase() + substring(1, length);
  }

  // launch url...
  Future<void> launchURL({
    String? fallbackUrl,
    String? msg,
  }) async {
    try {
      final bool launched = await launchUrlString(
        this,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        print(fallbackUrl);
        if (fallbackUrl != null) {
          await launchUrlString(
            fallbackUrl,
          );
        } else {
          Fluttertoast.showToast(
            msg: msg ?? "Can not launch URL",
          );
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }

  //Change time format to 24 hr...
  String to24hrFormat() {
    try {
      print(this);
      final DateTime dt = DateFormat("hh:mm a").parse(this).toLocal();
      print(dt);
      return DateFormat("HH:mm:ss").format(dt);
    } catch (e) {
      print(
        "Error while converting 24hr time format, please check incomming time is $this",
      );
      return "";
    }
  }

  String get toFirstLetter {
    if (isEmpty) return this;
    String temp = "";
    final List<String> splittedWords = isEmpty ? [] : split(" ");

    splittedWords.removeWhere((word) => word.isEmpty);

    if (splittedWords.length == 1) {
      temp = splittedWords[0][0].removeSpecialCharacters.toUpperCase();
    } else if (splittedWords.length >= 2) {
      temp = splittedWords[0][0].removeSpecialCharacters.toUpperCase() +
          splittedWords[1][0].removeSpecialCharacters.toUpperCase();
    }

    return temp;
  }

  //Change time format to 12 hr...
  String get to12hrFormat {
    try {
      final DateTime dt = DateFormat("HH:mm").parse(this);
      return DateFormat("hh:mm a").format(dt);
    } catch (e) {
      print(
        "Error while converting 12hr time format, please check incomming time is $this",
      );
      return "";
    }
  }

  //Change time format to 12 hr...
  String get to12hrFormatWithDate {
    try {
      final DateTime dt = DateFormat("MM/dd/yyyy HH:mm:ss").parse(this);
      return DateFormat("MM/dd/yyyy hh:mma").format(dt);
    } catch (e) {
      print(
        "Error while converting 12hr time format, please check incomming time is $this",
      );
      return "";
    }
  }

  bool get isNetworkImage =>
      toLowerCase().startsWith("http://") ||
      toLowerCase().startsWith("https://");

  bool get isNetworkPdf =>
      toLowerCase().startsWith("http://") ||
      toLowerCase().startsWith("https://") && toLowerCase().endsWith(".pdf");

  // Validate image url

  String get getValidProfileImage {
    return isEmpty ? ImgName.zunguFloating : this;
  }

  // Check route is same route, if its same return empty...
  String getRoute(BuildContext context) {
    return ModalRoute.of(context)?.settings.name == this ? "" : this;
  }

  /// price formate  (₹00,000.00)
  static NumberFormat priceFormat =
      NumberFormat.currency(customPattern: '#,### ', decimalDigits: 2);
  //Email validation Regular expression...
  static const String emailRegx =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String dleteREgx = 'DELETE';

  //Validate Your Name...
  String? get validateYourName =>
      trim().isEmpty ? AlertMessageString.emptyYourName : null;

  //Validate Name...
  String? get validateName =>
      trim().isEmpty ? AlertMessageString.emptyName : null;

  //Validate Bank Name...
  String? get emptyBankName =>
      trim().isEmpty ? AlertMessageString.emptyBankName : null;

  //Validate, Account Name...
  String? get emptyAccountName =>
      trim().isEmpty ? AlertMessageString.emptyAccountName : null;

  //Validate Name...
  String? get validateClientName =>
      trim().isEmpty ? AlertMessageString.emptyClientName : null;

  //Validate Email...
  String? get validateEmail => trim().isEmpty
      ? AlertMessageString.emptyEmail
      : !RegExp(emailRegx).hasMatch(trim())
          ? AlertMessageString.validEmail
          : null;

  //Validate Optional Email...
  String? get validateOptionalEmail => trim().isEmpty
      ? null
      : !RegExp(emailRegx).hasMatch(trim())
          ? AlertMessageString.validEmail
          : null;

// Validate OLd Password...
  String? get validateOldPassword => trim().isEmpty
      ? AlertMessageString.emptyOldPwd
      : trim().length < 8
          ? AlertMessageString.validPassword
          : null;

// Validate Password...
  String? get validatePassword => trim().isEmpty
      ? AlertMessageString.emptyPwd
      : trim().length < 8
          ? AlertMessageString.validPassword
          : null;

  // Validate Password...
  String? validateConfrimPassword({String? confrimPasswordVal}) =>
      (trim().isEmpty)
          ? AlertMessageString.emptyConfirmPwd
          : trim().length < 8
              ? AlertMessageString.validPassword
              : confrimPasswordVal == null
                  ? null
                  : this != confrimPasswordVal
                      ? AlertMessageString.passwordDoNotMatch
                      : null;

  // Validate phonenumber...
  String? get validatePhoneNumber => trim().isEmpty
      ? AlertMessageString.emptyPhoneNumber
      : trim().length < 10
          ? AlertMessageString.validPhonenumber
          : int.tryParse(this) == null
              ? AlertMessageString.validPhonenumber
              : null;

  // Validate accountnumber...
  String? get validateAccountNumber => trim().isEmpty
      ? AlertMessageString.emptyAccountNumber
      : trim().length < 5
          ? AlertMessageString.validAccountNumber
          : null;
  // Validate Empty
  String? get emptySortCode =>
      trim().isEmpty ? AlertMessageString.emptySortCode : null;

  // Validate Empty
  String? get emptyOtherReason =>
      trim().isEmpty ? AlertMessageString.emptyOtherReason : null;

  String? get emptyHeadline =>
      trim().isEmpty ? AlertMessageString.emptyHesdline : null;

  String? get emptyTenantDescription =>
      trim().isEmpty ? AlertMessageString.emptyTenantDscription : null;

  // Validate Empty
  String? get emptyRentCycle =>
      trim().isEmpty ? AlertMessageString.emptyRentCycle : null;

  // Validate Empty
  String? get emptyDepositSchemeName =>
      trim().isEmpty ? AlertMessageString.emptyDepositSchemeName : null;

  // Validate Empty
  String? get emptySelectCountry =>
      trim().isEmpty ? AlertMessageString.emptySelectCountry : null;

  // Validate Empty
  String? get validateEmpty =>
      trim().isEmpty ? AlertMessageString.amountErrorMsg : null;
  // Validate Empty
  String? get validVatEmpty =>
      trim().isEmpty ? AlertMessageString.incomeExpensesVatAlert : null;
  // Validate Empty
  String? get validateEmptyregarding =>
      trim().isEmpty ? AlertMessageString.emptyRegarding : null;

  // Validate Empty
  String? get validateEmptyName =>
      trim().isEmpty ? AlertMessageString.nameErrorMsg : null;

  // Validate delete..
  String? get validateEmptyDelete => trim().isEmpty
      ? AlertMessageString.deleteMsg
      : !RegExp(dleteREgx).hasMatch(trim())
          ? AlertMessageString.deleteUppercaseMsg
          : null;

  // Validate Empty
  String? get validateDueDate {
    if (trim().isEmpty) {
      return AlertMessageString.dueDateErrorMsg;
    }
    final int? parsedInt = toInt;
    if (parsedInt != null && parsedInt >= 1 && parsedInt <= 31) {
      return null;
    }
    return AlertMessageString.dueDateValidErrorMsg;
  }

  // Validate Empty
  String? get validateDepositId =>
      trim().isEmpty ? AlertMessageString.depositIdErrorMsg : null;

  // Validate Empty
  String? get validateDate =>
      trim().isEmpty ? AlertMessageString.dateErrorMsg : null;

  // Validate End Date
  String? validateEndDate({DateTime? startDate, DateTime? endDate}) {
    if (validateDate == null) {
      if (startDate != null && endDate != null) {
        if (endDate.isAfter(startDate)) {
          return validateDate;
        }
      }
      return AlertMessageString.dateSmallMsg;
    } else {
      return AlertMessageString.dateErrorMsg;
    }
  }

  // Validate End Date Optional
  String? validateEndDateOptional({DateTime? startDate, DateTime? endDate}) {
    if (startDate != null && endDate != null) {
      if (endDate.isAfter(startDate)) {
        return null;
      } else {
        return AlertMessageString.dateSmallMsg;
      }
    }
    return null;
  }

  // validate zipcode...
  String? get validateZipcode =>
      trim().isEmpty ? AlertMessageString.emptyzipcode : null;
  // validate city...
  String? get validateCity =>
      trim().isEmpty ? AlertMessageString.emptycity : null;
  // validate state...
  String? get validateState =>
      trim().isEmpty ? AlertMessageString.emptyState : null;
  // validate country...
  String? get validateCountry =>
      trim().isEmpty ? AlertMessageString.emptyCountry : null;
  // validate address...
  String? get validateAddress =>
      trim().isEmpty ? AlertMessageString.emptyAddress : null;

  // validate vatnumber...
  String? get validateVAT =>
      trim().isEmpty ? AlertMessageString.emptyvatNumber : null;

  // validate telephonrNumber...
  String? get validateTelephone =>
      trim().isEmpty ? AlertMessageString.emptytelephoneNumber : null;
  // validate websiteAddress...
  String? get validateWebsiteAddress =>
      trim().isEmpty ? AlertMessageString.emptywebsiteAddress : null;
  // validate companyRegisterNumber...
  String? get validateCompanyRegister =>
      trim().isEmpty ? AlertMessageString.emptycompanyRegisterdNumber : null;
  // validate landloardRegisterNumber...
  String? get validateLandloardRegisterNumber =>
      trim().isEmpty ? AlertMessageString.emptylandloardregisterNumber : null;
  // validate trandingName...
  String? get validatetrandingName =>
      trim().isEmpty ? AlertMessageString.emptytrandingName : null;

  // validate message...
  String? get validateMessage =>
      trim().isEmpty ? AlertMessageString.emptyMessage : null;

  // validate message...
  String? get validateDateMessage =>
      trim().isEmpty ? AlertMessageString.emptyDateMessage : null;

  String? get validatemptyAmount =>
      trim().isEmpty ? AlertMessageString.emptyPaymentAmount : null;

  // validate message...
  // validate message...
  String? get validateTimeMessage =>
      trim().isEmpty ? AlertMessageString.emptyTimeMessage : null;
  // validate message...
  String? get validateType =>
      trim().isEmpty ? AlertMessageString.selectTypeMsg : null;

  // validate Price message...
  String? get validateJobPrice =>
      trim().isEmpty ? AlertMessageString.pleaseEnterJobPrice : null;

  // validate Labour Costs message...
  String? get validateLabourcost =>
      trim().isEmpty ? AlertMessageString.pleaseEnterLabourCost : null;

  // validate Parts/Materials Cost message...
  String? get validatePartsMaterialCost =>
      trim().isEmpty ? AlertMessageString.pleaseEnterpartsMaterialsCost : null;

// validate Tradesmans Profession...
  String? get emptyTradesmansProfession => trim().isEmpty
      ? AlertMessageString.postAjobPleaseChooseTradesmansProfession
      : null;

// validate Select a Service...
  String? get emptySelectAService => trim().isEmpty
      ? AlertMessageString.postAjobPleaseChooseSelectAService
      : null;

// Add Financials ...
  String? get emptyPurchaseDate1 =>
      trim().isEmpty ? AlertMessageString.purchaseDate1 : null;
  // String? get emptyPurchasePrice1 =>
  //     trim().isEmpty ? AlertMessageString.purchasePrice1 : null;

// Validate Empty
  String? get emptyPurchasePrice1 {
    if (trim().isEmpty) {
      return AlertMessageString.purchasePrice1;
    }
    final int? parsedInt = toInt;
    if (parsedInt != null) {
      return null;
    }
    return AlertMessageString.purchasePrice1ValidErrorMsg;
  }

  // String? get emptyOutstandingMortgageAmount =>
  //     trim().isEmpty ? AlertMessageString.outstandingMortgageAmount : null;

  String? get emptyOutstandingMortgageAmount {
    if (trim().isEmpty) {
      return AlertMessageString.outstandingMortgageAmount;
    }
    final int? parsedInt = toInt;
    if (parsedInt != null) {
      return null;
    }
    return AlertMessageString.outstandingMortgageAmountValidErrorMsg;
  }

  // String? get emptyMonthlyMortgagePayment =>
  //     trim().isEmpty ? AlertMessageString.monthlyMortgagePayment : null;

  String? get emptyMonthlyMortgagePayment {
    if (trim().isEmpty) {
      return AlertMessageString.monthlyMortgagePayment;
    }
    final int? parsedInt = toInt;
    if (parsedInt != null) {
      return null;
    }
    return AlertMessageString.monthlyMortgagePaymentValidErrorMsg;
  }

  // String? get emptyMortgagePaymentDay =>
  //     trim().isEmpty ? AlertMessageString.mortgagePaymentDay : null;

  // Validate Empty
  String? get emptyMortgagePaymentDay {
    if (trim().isEmpty) {
      return AlertMessageString.mortgagePaymentDay;
    }
    final int? parsedInt = toInt;
    if (parsedInt != null && parsedInt >= 1 && parsedInt <= 31) {
      return null;
    }
    return AlertMessageString.mortgagePaymentDayValidErrorMsg;
  }

  //-------------------------Add Private job------------------------//

  // validate VAT message...
  String? get validatePercentageOfVAT =>
      trim().isEmpty ? AlertMessageString.pleaseEnterVAT : null;

  // Validate Client Mobile Number...
  String? get validateClientMobileNumber => trim().isEmpty
      ? AlertMessageString.emptyClientMobileNumber
      : trim().length < 10
          ? AlertMessageString.validMobilenumber
          : null;

  //Validate Email...
  String? get validateClientEmail => trim().isEmpty
      ? AlertMessageString.emptyClientEmail
      : !RegExp(emailRegx).hasMatch(trim())
          ? AlertMessageString.validEmail
          : null;

  // Validate Job Heading
  String? get validatejobHeading =>
      trim().isEmpty ? AlertMessageString.emptyJobHeading : null;

  // Validate Job Heading
  String? get validatejobDescription =>
      trim().isEmpty ? AlertMessageString.emptyJobDescription : null;

  // Validate Job Heading
  String? get validateInvoiceAmount =>
      trim().isEmpty ? AlertMessageString.emptyinvoiceamount : null;

  // Validate Job Heading
  String? get validatereview =>
      trim().isEmpty ? AlertMessageString.emptyReview : null;

  // Convert to int
  int? get toInt => int.tryParse(this);

  // Add space after text
  String get addSpaceAfter => "${this} ";

  // Add required * after text
  String get addStarAfter => "${this}*";

  // Add Decimal if not
  String get convertToDecimal => int.tryParse(this)?.toStringAsFixed(2) ?? this;

  // bool isMobileNumberValid(String phoneNumber) {
  //   String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
  //   var regExp = new RegExp(regexPattern);

  //   if (phoneNumber.length == 0) {
  //     return false;
  //   } else if (regExp.hasMatch(phoneNumber)) {
  //     return true;
  //   }
  //   return false;
  // }

//   //Validate More Info   ...
//   String? get validateMoreInfo =>
//       trim().isEmpty ? AlertMessageString.emptyMoreInfo : null;
//   //Validate Address   ...
//   String? get validateAddress =>
//       trim().isEmpty ? AlertMessageString.emptyAddress : null;
//   //!--------------  Lend New items validation----------------------
//   //Validate Item Name...
//   String? get validateItemName =>
//       trim().isEmpty ? AlertMessageString.emptyItemName : null;

//   //Validate Lender Type...
//   String? get validateLenderType =>
//       trim().isEmpty ? AlertMessageString.emptyLenderType : null;

//   //Validate Category Type...
//   String? get validateCategoryType =>
//       trim().isEmpty ? AlertMessageString.emptyCategoryType : null;

//   //Validate location...
//   String? get validatelocation =>
//       trim().isEmpty ? AlertMessageString.emptylocation : null;

// //Validate Description...
//   String? get validateDescription =>
//       trim().isEmpty ? AlertMessageString.emptyDescription : null;

//   //Validate Value...
//   String? get validateValue =>
//       trim().isEmpty ? AlertMessageString.emptyValue : null;

//   //Validate Duration...
//   String? get validateDuration =>
//       trim().isEmpty ? AlertMessageString.emptyDuration : null;

//   //Validate Safety Deposite...
//   String? get validateSafetyDeposite =>
//       trim().isEmpty ? AlertMessageString.emptySafetyDeposite : null;

//   //Validate Rate Per Day...
//   String? get validateRatePerDay =>
//       trim().isEmpty ? AlertMessageString.emptyRatePerDay : null;

//   //Validate Rate Per Day...
//   String? get validateRatePerWeek =>
//       trim().isEmpty ? AlertMessageString.emptyRatePerWeek : null;

  // //Validate Rate Per Day...
  // String? get validateRatePerMonth =>
  //     trim().isEmpty ? AlertMessageString.emptyRatePerMonth : null;

  static const String instahandelRegx = "^(?!.*..)(?!.*.\$)[^W][w.]{0,29}\$";

  static const String phoneNoRegx = "^[0-9]";

  bool isNullorEmpty(dynamic object) =>
      object == null || (object?.isEmpty ?? false);

  //Decode JWT Token...
  Map<String, dynamic> get getJsonFromJWT {
    try {
      if (isEmpty) {
        return {"exp": "0"};
      } else {
        final String normalizedSource = base64Url.normalize(split(".")[1]);
        return json.decode(
          utf8.decode(
            base64Url.decode(normalizedSource),
          ),
        );
      }
    } catch (error) {
      print("Error converting token data, $error");
      return {"exp": "0"};
    }
  }

  String get currencyFormatter {
    // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
    final double value = double.parse(this);

    if (value < 1000000) {
      // less than a million
      return value.toStringAsFixed(0);
    } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
      // less than 100 million
      final double result = value / 1000000;
      return "${result.toStringAsFixed(2)}M";
    } else if (value >= (1000000 * 10 * 100) &&
        value < (1000000 * 10 * 100 * 100)) {
      // less than 100 billion
      final double result = value / (1000000 * 10 * 100);
      return "${result.toStringAsFixed(2)}B";
    } else if (value >= (1000000 * 10 * 100 * 100) &&
        value < (1000000 * 10 * 100 * 100 * 100)) {
      // less than 100 trillion
      final double result = value / (1000000 * 10 * 100 * 100);
      return "${result.toStringAsFixed(2)}T";
    }

    return value.toString();
  }

  bool get isYoutubeLink {
    if (toLowerCase().contains("youtube")) {
      return true;
    } else {
      return false;
    }
  }
}

//Convert Date...
extension DateConversion on DateTime {
  // To Server Date...
  DateTime get toUTCTimeZone =>
      DateTime.parse(DateFormat('yyyy-MM-dd HH:mm:ss').format(this));

  // To Filter Date...
  String get toFilterDate => DateFormat('yyyy-MM-dd').format(this);
  // createLease Screen...
  String get createLeaseDate => DateFormat('dd-MM-yyyy').format(this);
  //  activeLease dayDate...
  String get activeLeaseDay => DateFormat('dd').format(this);
  //  activeLease monthYearDate...
  String get monthYearLeaseDay => DateFormat('MMM yyyy').format(this);

  // To Filter Date...
  String get tofilterPlaceHolderDate => DateFormat('MM/dd/yyyy').format(this);
  // to activeFilter

  // Date to String...
  String get toMobileString => DateFormat('dd MMM yyyy').format(this);

  // Date to String with only month and year...
  String get toMonthYear => DateFormat('MMM yyyy').format(this);

  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return numericDates ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return numericDates ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return numericDates ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return numericDates ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}

extension ExtEnum on Object {
  String get getEnumName => toString().split(".").last.toLowerCase();
}

bool isNullorEmpty(dynamic object) =>
    object == null || (object?.isEmpty ?? false);

// Check Double...
double checkAndToDouble(dynamic value) {
  return value == null ? 0.0 : double.tryParse(value.toString())!;
}

extension IntExtension on int {
//Epoch time to Local...
  String get epochToLocal {
    try {
      final DateTime localTime = DateTime.fromMillisecondsSinceEpoch(this);
      final String dateTime =
          DateFormat("MM/dd/yyyy HH:mm:ss").format(localTime).toString();
      return dateTime.to12hrFormatWithDate;
    } catch (e) {
      return "";
    }
  }

  Color get getExpiresColor {
    if (this > 90) {
      return ColorConstants.custgreen09A814;
    } else if (this <= 90 && this > 60) {
      return ColorConstants.custDarkPurple500472;
    } else if (this <= 60 && this > 30) {
      return ColorConstants.custDarkYellowFFBF00;
    } else if (this <= 30) {
      return ColorConstants.custRedD92A2A;
    } else {
      return Colors.transparent;
    }
  }

  String get toNonNegativeString => isNegative ? "" : toString();
}

//Get File name...
extension FileExtention on File {
  String get name {
    return path.split("/").last;
  }

  Future<int> get fileSize async {
    return length();
  }

  String get getFileSizeInMb {
    try {
      // Get length of file in bytes
      final int fileSizeInBytes = lengthSync();

      // Convert the bytes to Kilobytes (1 KB = 1024 Bytes)
      final double fileSizeInKB = fileSizeInBytes / 1024;

      // Convert the KB to MegaBytes (1 MB = 1024 KBytes)
      final double fileSizeInMB = fileSizeInKB / 1024;

      return fileSizeInMB.toStringAsFixed(2);
    } catch (e) {
      return "0.0";
    }
  }
}

extension HexColor on String {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  Color get hexToColor {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension DateTimeExtension on DateTime? {
  bool? isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isAfter(dateTime);
    }
    return null;
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    if (date != null) {
      final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
      return isAtSameMomentAs | date.isBefore(dateTime);
    }
    return null;
  }

  bool isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    try {
      final date = this;
      if (date != null) {
        final isAfter = date.isAfterOrEqualTo(fromDateTime) ?? false;
        final isBefore = date.isBeforeOrEqualTo(toDateTime) ?? false;
        return isAfter && isBefore;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

// extension UserToUserInfo on User? {
//   UserInfoModel get toUserInfoModel => UserInfoModel(
//         id: this?.uid ?? "",
//         authType: AuthType.None,
//         email: this?.email ?? "",
//         firstName: this?.displayName ?? "",
//         phoneNumber: this?.phoneNumber ?? "",
//       );
// }

//Convert Date...
extension MapExtension on Map {
  // To json
  String toJson() => json.encode(this);
}

//Convert Date...
extension CurrentTenantsFilterExtension on CurrentTenantsFilter {
  // To json
  String parseToString() => toString().split('.').last;
}
