import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/models/landloard/financial_overview_model.dart';
import 'package:zungu_mobile/models/landloard/property_detail_model.dart';
import 'package:zungu_mobile/providers/landlord_provider.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/landlord_my_properties_details/financialOverview/add_financials.dart';
import 'package:zungu_mobile/widgets/bookmark_widget.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/customtitlewithline_headline3.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';

class FinancialOverviewScreen extends StatefulWidget {
  final PropertiesDetailModel propertyDetailModel;
  final String financeId;
  const FinancialOverviewScreen({
    super.key,
    required this.propertyDetailModel,
    this.financeId = "",
  });

  @override
  State<FinancialOverviewScreen> createState() =>
      _FinancialOverviewScreenState();
}

class _FinancialOverviewScreenState extends State<FinancialOverviewScreen> {
  //---------------------------------Variables-------------------------------//

//Home Item Image List
  List<String> homeItemList = [
    ImgName.landlordBed,
    ImgName.landlordBathtub,
    ImgName.landlordSofa,
  ];
//------------------------------------UI-----------------------------------//

  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  LandlordProvider get financialLandlordProvider =>
      Provider.of<LandlordProvider>(
        context,
        listen: false,
      );

  @override
  void initState() {
    super.initState();
    fetchFinancialOverviewDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  //------------------------------------Widgets------------------------------//

  Widget _buildBody() {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              CustImage(
                height: 240,
                width: double.infinity,
                imgURL: widget.propertyDetailModel.photos.first,
              ),
              _financialOverViewCard(),
            ],
          ),
        ),
      ),
    );
  }

//----------------------------Financial OverView Card-----------------------/
  Widget _financialOverViewCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 210),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title and subtitle text and book mark card
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          _buildTitle(),
                          const SizedBox(height: 5),
                          _buildSubTitle(),
                        ],
                      ),
                    ),
                    //Book Mark
                    _buildBookMark(),
                  ],
                ),

                const SizedBox(height: 20),
                // Home Property item count
                _homeItemList(widget.propertyDetailModel),
                const SizedBox(height: 45),
              ],
            ),
          ),

          Consumer<LandlordProvider>(
            builder: (context, financiaProvider, child) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Financial Overview Text
                        const CustomTitleWithLineHeadLine3(
                          title: StaticString.financialOverview,
                          primaryColor: ColorConstants.custDarkBlue150934,
                          secondaryColor: ColorConstants.custBlue1EC0EF,
                        ),
                        InkWell(
                          onTap: financiaProvider
                                      .getFinancialOverViewModel?.id.isEmpty ??
                                  true
                              ? filterButtonAction
                              : filterButtonAction,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: financiaProvider.getFinancialOverViewModel
                                          ?.id.isEmpty ??
                                      true
                                  ? ColorConstants.custPurple500472
                                  : ColorConstants.custBlue1EC0EF,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: CustImage(
                              height: 20,
                              imgURL: financiaProvider.getFinancialOverViewModel
                                          ?.id.isEmpty ??
                                      true
                                  ? ImgName.addIcon
                                  : ImgName.editIcon,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  _custPurchaseAndOutstandingCard(
                    priceAndMortgage:
                        financiaProvider.getFinancialOverViewModel,
                  ),
                  const SizedBox(height: 30),
                  _custYearlyRentalAndYieldCard(
                    rentalAndYield: financiaProvider.getFinancialOverViewModel,
                  ),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Home Property item count
  Widget _homeItemList(PropertiesDetailModel propertyDetailModel) {
    final List<int> homeItemcount = [
      propertyDetailModel.bedRoom,
      propertyDetailModel.bathRoom,
      propertyDetailModel.livingRoom,
    ];
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: const EdgeInsets.only(left: 35, right: 20),
        child: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                homeItemList.length,
                (index) => _custHomeItemCard(
                  img: homeItemList[index],
                  itemCount: homeItemcount[index],
                ),
              ),
            ),
            // Wheel chair image
            CustImage(
              imgURL: propertyDetailModel.disabledFriendly
                  ? ImgName.landlordDisableAllow
                  : ImgName.landlordDisableNotAllow,
              height: 36,
              width: 36,
            ),
          ],
        ),
      ),
    );
  }

//--------------------------Purchase And Outstanding------------------------/

  Widget _custPurchaseAndOutstandingCard({
    FinancialOverViewModel? priceAndMortgage,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _financialOverviewCard(
              "£ ${priceAndMortgage?.purchasePrice ?? 0}",
              StaticString.purchasePrice,
              ColorConstants.custDarkPurple500472,
              ImgName.purchasePricee,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _financialOverviewCard(
              "£ ${priceAndMortgage?.outstandingMortgage ?? 0}",
              StaticString.outstandingMortgage,
              ColorConstants.custRed3081E,
              ImgName.outstanding,
            ),
          ),
        ],
      ),
    );
  }

//---------------------------YearlyRentalAndYieldCard-----------------------/
  Widget _custYearlyRentalAndYieldCard({
    FinancialOverViewModel? rentalAndYield,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _financialOverviewCard(
              "£ ${rentalAndYield?.yearlyRental ?? 0}",
              StaticString.yearlyRental,
              ColorConstants.custBlue2AC4EF,
              ImgName.yearlyRental,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _financialOverviewCard(
              "${rentalAndYield?.financialOverViewModelYield ?? 0} %",
              StaticString.yield,
              ColorConstants.custGreen3CAC71,
              ImgName.yield1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _financialOverviewCard(
    String price,
    String txtTitle,
    Color bgColor,
    String img,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: ColorConstants.custGrey707070.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //Icon Image
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustImage(
                  imgURL: img,
                  width: 56,
                  height: 57,
                ),
                const SizedBox(width: 5),
                //Price
                Flexible(
                  child: CustomText(
                    txtTitle: price,
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.custWhiteFFFFFF,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          // Title text
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CustomText(
                txtTitle: txtTitle,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.custWhiteFFFFFF,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

//--------------------------------- Button Action -----------------------------------/

  // Filter button Ontap Action
  void filterButtonAction() {
    showModalBottomSheet(
      enableDrag: true,
      isDismissible: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        if (financialLandlordProvider.getFinancialOverViewModel == null) {
          return const AddFinancialsScreen();
        } else {
          return financialLandlordProvider.getFinancialOverViewModel!.id.isEmpty
              ? const AddFinancialsScreen()
              : AddFinancialsScreen(
                  financialOverViewModel:
                      financialLandlordProvider.getFinancialOverViewModel,
                );
        }
      },
    );
  }

//------------------------------HomeItemCard--------------------------------/
  Widget _custHomeItemCard({
    required String img,
    required int itemCount,
  }) {
    return Row(
      children: [
        // Home Item Icon Image
        CustImage(
          imgURL: img,
          height: 36,
          width: 36,
          boxfit: BoxFit.contain,
        ),
        const SizedBox(width: 15),

        //Home Item Name Text
        CustomText(
          txtTitle: itemCount.toString(),
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: ColorConstants.custBlack808080,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(width: 30),
      ],
    );
  }
//--------------------------------Book Mark---------------------------------/

  Widget _buildBookMark() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        width: 37,
        height: 50,
        child: buildBookmark(
          text: widget.propertyDetailModel.property.first.status
              .replaceAll("_", "\n"),
          color: widget.propertyDetailModel.property.first.status == "TO_LET"
              ? ColorConstants.custRedE0320D
              : widget.propertyDetailModel.property.first.status == "LET"
                  ? ColorConstants.custGreen3CAC71
                  : widget.propertyDetailModel.property.first.status == "HMO"
                      ? ColorConstants.custPurpleB772FF
                      : ColorConstants.custBlue29C3EF,
        ),
      ),
    );
  }
//--------------------------------Sub Title---------------------------------/

  Widget _buildSubTitle() {
    return CustomText(
      txtTitle: widget.propertyDetailModel.address?.fullAddress,
      style: Theme.of(context).textTheme.bodyText1?.copyWith(
            color: ColorConstants.custGrey707070,
            fontWeight: FontWeight.w400,
          ),
    );
  }
//----------------------------------Title-----------------------------------/

  Widget _buildTitle() {
    return CustomText(
      txtTitle: widget.propertyDetailModel.name,
      textOverflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headline3?.copyWith(
            color: ColorConstants.custDarkBlue150934,
            fontWeight: FontWeight.w700,
          ),
    );
  }

//----------------------------------AppBar----------------------------------/
  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const Text(
        StaticString.myProperty,
      ),
    );
  }

  // Financial Overview Details
  Future<void> fetchFinancialOverviewDetails() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );

      await financialLandlordProvider.fetchFinancialOverviewData(
        financeId: widget.financeId,
      );
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
