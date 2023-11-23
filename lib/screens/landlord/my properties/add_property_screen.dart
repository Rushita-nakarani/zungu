// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/modules.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../constant/img_font_color_string.dart';
import '../../../../models/landloard/upsert_detail_model.dart';
import '../../../../models/submit_property_detail_model.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/common_widget.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/rich_text.dart';
import '../../../providers/landlord_provider.dart';
import '../../../services/in_app_purchase_service.dart';
import '../../../widgets/custom_alert.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/html_view.dart';
import '../../../widgets/loading_indicator.dart';

class SubmitPropertyScreen extends StatefulWidget {
  final UpsetProfileModel upsetProfileModel;
  final SubmitPropertyDetailModel submitPropertyDetailModelClass;
  const SubmitPropertyScreen({
    Key? key,
    required this.submitPropertyDetailModelClass,
    required this.upsetProfileModel,
  }) : super(key: key);

  @override
  State<SubmitPropertyScreen> createState() => _SubmitPropertyScreenState();
}

class _SubmitPropertyScreenState extends State<SubmitPropertyScreen> {
  //----------------------------Varibles-----------------------//

  //-----------List-------------//

  //ItemList
  List<IAPItem> _items = [];
  // HMO Field List
  List<String> hmoFieldList = [];
  // Question List
  List<String> questionList = [];
  // Hmo Field Answer List
  List<String> hmoFieldAnswerList = [];
  // Shop Field Answer List
  List<String> shopFieldAnswerList = [];
  // House Field Answer List
  List<String> houseFieldAnswerList = [];
  // Answer List
  List<String> answerList = [];

  //Home FieldList
  List<String> houseFieldList = [
    "",
    StaticString.rentalType,
    StaticString.propertyType,
    StaticString.rentalAmountWithoutStar,
    StaticString.bedroom,
    StaticString.bathroom,
    StaticString.livingRoom,
    StaticString.furnishing,
    StaticString.lettingStatus,
    StaticString.petsAllowed,
    StaticString.disableFriednly,
  ];

  // Shop Field List
  List<String> shopFieldList = [
    "",
    StaticString.rentalType,
    StaticString.floorSize,
    StaticString.annualRent,
    StaticString.pricePerSquareFoot,
    StaticString.categoryClass,
    StaticString.lettingStatus,
  ];

  //------------Model------------//
  // Submit Property Detail Model
  SubmitPropertyDetailModel _submitModel = SubmitPropertyDetailModel(
    features: [],
    floorPlan: [],
    photos: [],
    videos: [],
    rooms: [],
  );

  // Terms And Conditions Accepted bool
  bool _termsConditionsAccepted = false;

  // Value Notifier
  final ValueNotifier _valueNotifier = ValueNotifier(true);

  // Landlord Provider getter;
  LandlordProvider get getLandlordProvider =>
      Provider.of<LandlordProvider>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _submitModel = widget.submitPropertyDetailModelClass;

    // Hmo Field List Data
    hmoFieldList = [
      "",
      StaticString.rentalType,
      StaticString.propertyType,
      StaticString.rentalAmountWithoutStar,
      ...[
        StaticString.bedroom,
        ..._submitModel.rooms.map((e) => e.name).toList()
      ],
      StaticString.bathroom,
      StaticString.livingRoom,
      StaticString.furnishing,
      StaticString.petsAllowed,
      StaticString.disableFriednly,
    ];

    // Hmo Field Answer List Data
    hmoFieldAnswerList = [
      _submitModel.address?.fullAddress ?? "",
      _submitModel.rentalType,
      _submitModel.propertyTypeName,
      StaticString.currency + _submitModel.rent.toString(),
      ...[
        _submitModel.bedRoom.toString(),
        ..._submitModel.rooms.map((e) => e.typeName).toList()
      ],
      _submitModel.bathRoom.toString(),
      _submitModel.livingRoom.toString(),
      _submitModel.furnishedType,
      if (_submitModel.petAllowed) 'Yes' else 'No',
      if (_submitModel.disabledFriendly) 'Yes' else 'No',
    ];

    // Shop Field Answer List Data
    shopFieldAnswerList = [
      _submitModel.address?.fullAddress ?? "",
      _submitModel.rentalType,
      _submitModel.floorSize.toString(),
      StaticString.currency + _submitModel.rent.toString(),
      StaticString.currency + _submitModel.pps.toString(),
      _submitModel.className,
      "LET",
    ];

    // House Field Answer List Data
    houseFieldAnswerList = [
      _submitModel.address?.fullAddress ?? "",
      _submitModel.rentalType,
      _submitModel.propertyTypeName,
      StaticString.currency + _submitModel.rent.toString(),
      _submitModel.bedRoom.toString(),
      _submitModel.bathRoom.toString(),
      _submitModel.livingRoom.toString(),
      _submitModel.furnishedType,
      "LET",
      if (_submitModel.petAllowed) 'Yes' else 'No',
      if (_submitModel.disabledFriendly) 'Yes' else 'No',
    ];

    if (_submitModel.rentalType.toLowerCase() == "house") {
      questionList = houseFieldList;
      answerList = houseFieldAnswerList;
    } else if (_submitModel.rentalType.toLowerCase() == "flats") {
      houseFieldList.removeAt(2);
      houseFieldAnswerList.removeAt(2);
      questionList = houseFieldList;
      answerList = houseFieldAnswerList;
    } else if (_submitModel.rentalType.toLowerCase() == "hmo") {
      questionList = hmoFieldList;
      answerList = hmoFieldAnswerList;
    } else {
      questionList = shopFieldList;
      answerList = shopFieldAnswerList;
    }
  }

  @override
  void dispose() {
    PaymentService.instance.dispose();
    super.dispose();
  }

  //-------------------------UI-------------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  //-------------------------Widget-------------------------//
  // App bar
  AppBar _buildAppBar() {
    return AppBar(
      title: CustomText(
        txtTitle: StaticString.addProperty,
        style: Theme.of(context).textTheme.headline3?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }

  //Body
  Widget _buildBody() {
    return LoadingIndicator(
      loadingStatusNotifier: PaymentService.instance.loadingIndicator,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonHeaderLable(
                  title: StaticString.reviewInformation,
                  spaceBetween: 20,
                  child:
                      // Review Information Value Field ListView
                      _buildValueFields(),
                ),

                const SizedBox(height: 40),

                // This Proprty Will Be added ....text
                CustomText(
                  txtTitle: StaticString.thisPropertyWillBe,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w500,
                      ),
                  align: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Terms and conditions Row
                _buildTermsAndConditions(),

                const SizedBox(
                  height: 40,
                ),

                ValueListenableBuilder(
                  valueListenable: _valueNotifier,
                  builder: (context, val, child) {
                    return CommonElevatedButton(
                      disable: !_termsConditionsAccepted,
                      bttnText: StaticString.addProperty.toUpperCase(),
                      onPressed: addPropertryBtnAction,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Review Information Value Field ListView
  Widget _buildValueFields() {
    return ListView.separated(
      separatorBuilder: (context, index) => Container(
        height: 1,
        width: double.infinity,
        color: ColorConstants.custGreyEBEAEA,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return index == 0
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: CustomText(
                  txtTitle: answerList[index],
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custBlue1EC0EF,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              )
            : commonField(
                title: questionList[index],
                answer: answerList[index],
              );
      },
      itemCount: questionList.length,
    );
  }

  Widget _buildTermsAndConditions() {
    return GestureDetector(
      onTap: termAndConditionCheckboxOntap,
      child: Row(
        children: [
          ValueListenableBuilder(
            valueListenable: _valueNotifier,
            builder: (context, val, child) {
              return Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: ColorConstants.custGrey707070,
                  ),
                ),
                child: !_termsConditionsAccepted
                    ? const SizedBox()
                    : const CustImage(
                        imgURL: ImgName.tick,
                        imgColor: Colors.green,
                      ),
              );
            },
          ),
          const SizedBox(width: 10),

          // Terms And Conditions Text
          Expanded(
            child: CustomRichText(
              title: StaticString.termsAndConditions,
              fancyTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custBlue1EC0EF,
                    fontWeight: FontWeight.w600,
                  ),
              normalTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w600,
                  ),
              onTap: (val) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const HtmlCommonView(
                      title: StaticString.termsAndConditons,
                      viewType: HtmlViewType.TC,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //-----------------------Helper Widget---------------------//


  // Common title for the screen
  Widget commonField({required String title, required String answer}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: title,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: ColorConstants.custGrey707070),
          ),
          CustomText(
            txtTitle: answer,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custBlue1EC0EF,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  //------------------------Button Action-------------------//

  // Terms And Conditions CheckBox Ontaap
  void termAndConditionCheckboxOntap() {
    _termsConditionsAccepted = !_termsConditionsAccepted;

    _valueNotifier.notifyListeners();
  }

  Future<void> addPropertryBtnAction() async {
    if (!_termsConditionsAccepted) {
      Fluttertoast.showToast(
        msg: StaticString.mustHaveToacceptTermsConditions,
      );
      return;
    }

    buyProperty();
  }

  // Buy Property Function
  Future<void> buyProperty() async {
    try {
      PaymentService.instance.loadingIndicator.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      _items = await PaymentService.instance.products;
      if (_items.isNotEmpty) {
        final List<IAPItem> _productItems = _items
            .where(
              (element) =>
                  element.productId == widget.upsetProfileModel.inAppPurchaseId,
            )
            .toList();
        if (_productItems.isNotEmpty) {
          await PaymentService.instance
              .buyProduct(_productItems.first, widget.upsetProfileModel.id);
        }
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      PaymentService.instance.loadingIndicator.hide();
    }
  }
}
