import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/screens/tenant/my_tenancies/my_lease_screen.dart';
import 'package:zungu_mobile/screens/tenant/my_tenancies/tenant_app_damage_report_screen.dart';
import 'package:zungu_mobile/utils/custom_extension.dart';
import 'package:zungu_mobile/widgets/bookmark_widget.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../../cards/detail_action_card.dart';
import '../../../constant/img_font_color_string.dart';
import '../../../models/items_and_count_model.dart';
import '../../../models/tenant/fetch_current_tenancy_model.dart';
import '../../../providers/tenantProvider/tenancy_provider.dart';
import '../../../utils/cust_eums.dart';
import '../../../widgets/custom_alert.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_title_with_line.dart';
import '../../../widgets/home_item_row_widget.dart';
import '../../../widgets/loading_indicator.dart';
import 'custom_datebox.dart';
import 'edit_payment_bottom_sheet.dart';
import 'log_payment_bottom_sheet.dart';
import 'payment_history/payment_history_screen.dart';
import 'tenancy_detail_price_tag.dart';

class TenantMyTenanciesDetailScreen extends StatefulWidget {
  final CurrentTenancyModel fetchCurrentTenancyModel;
  const TenantMyTenanciesDetailScreen({
    super.key,
    required this.fetchCurrentTenancyModel,
  });

  @override
  State<TenantMyTenanciesDetailScreen> createState() =>
      _TenantMyTenanciesDetailScreenState();
}

class _TenantMyTenanciesDetailScreenState
    extends State<TenantMyTenanciesDetailScreen> {
  List<ItemAndCount> homeItemList = [];

  List<String> tenantOperationImg = [
    ImgName.myPayments,
    ImgName.myLeases,
    ImgName.inventoryCheck,
    ImgName.damageReport,
  ];

  List<String> tenantOperationName = [
    StaticString.myPayments.replaceAll(" ", "\n"),
    StaticString.myLeases.replaceAll(" ", "\n"),
    StaticString.inventoryCheck.replaceAll(" ", "\n"),
    StaticString.damageReport.replaceAll(" ", "\n"),
  ];

  List navigationOntap = [
    const Scaffold(),
    const MyLeaseScreen(),
    const Scaffold(),
    const TenantAppDamageReport()
  ];
  TenanciesProvider get tenancyProvider =>
      Provider.of<TenanciesProvider>(context, listen: false);
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: _buildAppBar(title: StaticString.myTenancies),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: CustImage(
                    height: 200,
                    width: double.infinity,
                    imgURL: widget.fetchCurrentTenancyModel.photos.isEmpty
                        ? ""
                        : widget.fetchCurrentTenancyModel.photos.first,
                  ),
                ),
                // _propertyDetailsCard(),
                Container(
                  margin: const EdgeInsets.only(top: 170),
                  child: _propertyDetailsCard(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar({required String title}) {
    return AppBar(
      title: CustomText(
        txtTitle: title,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: () {
              showAlert(
                context: context,
                title: StaticString.deleteTenancy,
                singleBtnTitle: StaticString.delete,
                showIcon: false,
                singleBtnColor: ColorConstants.custChartRed,
                message: AlertMessageString.deleteTenancyConf,
                onRightAction: deleteTenancy,
              );
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: const CircleAvatar(
              backgroundColor: ColorConstants.backgroundColorFFFFFF,
              child: CustImage(
                width: 25,
                imgURL: ImgName.deleteRed,
              ),
            ),
          ),
        )
      ],
      elevation: 0,
      backgroundColor: ColorConstants.custDarkPurple662851,
    );
  }

  Widget _propertyDetailsCard() {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height / 1.5,
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
          // Property title and subtitle text
          _propertyTitleAndOfferCardRow(),
          const SizedBox(height: 25),

          // Home Property item count
          _homeItemList(),
          const SizedBox(height: 25),

          // Property List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                tenantOperationImg.length,
                (index) => Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => navigationOntap[index],
                        ),
                      );
                    },
                    child: DetailActionCard(
                      image: tenantOperationImg[index],
                      title: tenantOperationName[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
          _buildRentCard(),
        ],
      ),
    );
  }

  Widget _propertyTitleAndOfferCardRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                CustomText(
                  txtTitle: widget.fetchCurrentTenancyModel.name,
                  maxLine: 2,
                  style: Theme.of(context).textTheme.headline3?.copyWith(
                        color: ColorConstants.custDarkBlue150934,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                CustomText(
                  txtTitle: widget.fetchCurrentTenancyModel.fullAddress,
                  maxLine: 2,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.custGrey707070,
                        fontSize: 15,
                      ),
                )
              ],
            ),
          ),
        ),

        // Offer card
        Padding(
          padding: const EdgeInsets.only(
            right: 20,
          ),
          child: buildBookmark(
            text: widget.fetchCurrentTenancyModel.lettingStatus,
            color: ColorConstants.custGreen3CAC71,
          ),
        ),
      ],
    );
  }

  Widget _homeItemList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustHomeItemRowWidget(
            item: ItemAndCount(
              image: ImgName.tenantBed,
              count: widget.fetchCurrentTenancyModel.bedRoom,
            ),
          ),
          CustHomeItemRowWidget(
            item: ItemAndCount(
              image: ImgName.tenantBath,
              count: widget.fetchCurrentTenancyModel.bathRoom,
            ),
          ),
          CustHomeItemRowWidget(
            item: ItemAndCount(
              image: ImgName.tenantSofa,
              count: widget.fetchCurrentTenancyModel.livingRoom,
            ),
          ),
          CustImage(
            imgURL: widget.fetchCurrentTenancyModel.disabledFriendly
                ? ImgName.tenantDisableAllow
                : ImgName.tenantDisableNotAllow,
            height: 30,
            width: 36,
          )
        ],
      ),
    );
  }

  // Custom Home Item Card

  Widget _buildRentCard() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
                  )
                ],
              ),
              // Tenant rent card
              child: Column(
                children: [
                  // Tenanr rent card
                  _tenantRentCard(),
                  // Over due  and rent due date text row
                  const SizedBox(height: 10),
                  _overdueTextAndDuedateTextRow(),
                  const SizedBox(height: 30),

                  // //start and end tenancy card row
                  _startAndEndTenancyCardRow(),
                  const SizedBox(height: 30),

                  // // Rent Period card
                  _rentPeriodCard(
                    rentPeriodDate: "Sep 21",
                    rentStatus: StaticString.remainingDue,
                    rentPrimaryColor: ColorConstants.custDarkPurple662851,
                    rentSecondaryColor: ColorConstants.custDarkYellow838500,
                    rent: "500",
                  ),
                  _buildDivider(),

                  _rentPeriodCard(
                    rentPeriodDate: "Aug 21",
                    rentStatus: StaticString.overDue,
                    rentPrimaryColor: ColorConstants.custDarkPurple662851,
                    rentSecondaryColor: ColorConstants.custDarkYellow838500,
                    rent: "500",
                    lateFee: "50",
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
            // Profile image card
            _profileImagecard(),
          ],
        ),
        const SizedBox(height: 50),
        _buildPaymentHistory(),
        const SizedBox(height: 35),
        _buildPaymentHistoryCard(
          primaryColor: ColorConstants.custDarkPurple662851,
          secondaryColor: ColorConstants.custDarkYellow838500,
        ),
        const SizedBox(height: 35),
      ],
    );
  }

  // Tenat Rent card
  Widget _tenantRentCard() {
    return Align(
      alignment: Alignment.topRight,
      child: PriceTagWidget(
        color: ColorConstants.custChartGreen,
        rentPrice: "${StaticString.currency}500",
      ),
    );
  }

  Row _overdueTextAndDuedateTextRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustImage(
          imgURL: ImgName.commonRedCross,
          height: 36,
          width: 36,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              txtTitle: "Overdue by 2 days",
              style: Theme.of(context).textTheme.headline3?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontSize: 23,
                  ),
            ),
            CustomText(
              txtTitle:
                  "${StaticString.rentDueDate.addSpaceAfter}${" - "}15 Sep 2021",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey707070,
                  ),
            )
          ],
        )
      ],
    );
  }

  Widget _startAndEndTenancyCardRow() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const CustomCalender(
            title: StaticString.startTenancy,
            date: "01",
            monthYear: "Jun 2020",
            backgroundcolor: ColorConstants.custWhiteF7F7F7,
            fontColor: ColorConstants.custDarkPurple662851,
          ),
          SizedBox(width: MediaQuery.of(context).size.height * 0.032),
          const CustomCalender(
            title: StaticString.endTenancy,
            date: "01",
            monthYear: "May 2021",
            backgroundcolor: ColorConstants.custWhiteF7F7F7,
            fontColor: ColorConstants.custDarkPurple662851,
          ),
        ],
      ),
    );
  }

  Widget _rentPeriodCard({
    required String rentPeriodDate,
    required Color rentPrimaryColor,
    required Color rentSecondaryColor,
    required String rentStatus,
    required String rent,
    String? lateFee,
  }) {
    return Column(
      children: [
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12, right: 5),
              child: CustImage(
                imgURL: ImgName.calenderClockTenant,
                height: 18,
                width: 18,
                boxfit: BoxFit.contain,
              ),
            ),
            Expanded(
              flex: 4,
              child: CustomText(
                txtTitle: "${StaticString.rentPeriod} ($rentPeriodDate)",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: rentPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: logPaymentBottomSheet,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CustomText(
                    align: TextAlign.end,
                    txtTitle: StaticString.logPayment.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstants.custPureRedFF0000,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomText(
                    txtTitle: StaticString.rent,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(width: 3),
                  CustomText(
                    txtTitle: rentStatus,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: lateFee == null
                              ? ColorConstants.custGreen3CAC71
                              : ColorConstants.custPureRedFF0000,
                          fontWeight: FontWeight.w500,
                        ),
                  )
                ],
              ),
              CustomText(
                txtTitle: "${StaticString.currency}$rent",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: rentSecondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
        if (lateFee != null) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomText(
                      txtTitle: StaticString.lateFee,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                CustomText(
                  txtTitle: "${StaticString.currency}$lateFee",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: rentSecondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
          ),
        ]
      ],
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.only(top: 15, bottom: 25),
      child: Divider(
        indent: 10,
        endIndent: 10,
      ),
    );
  }

  Widget _custTitleAndAmountRow({
    required String title,
    required String amount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: title,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custGrey707070,
                ),
          ),
          // rent amount text
          CustomText(
            txtTitle: "${StaticString.currency}$amount",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(color: ColorConstants.custBlue1EC0EF),
          )
        ],
      ),
    );
  }

  Widget _profileImagecard() {
    return Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: const CustImage(
          imgURL: ImgName.tenantPersonImage,
        ),
      ),
    );
  }

  Widget _buildPaymentHistory() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomTitleWithLine(
            title: StaticString.paymentHistory,
            primaryColor: ColorConstants.custDarkPurple662851,
            secondaryColor: ColorConstants.custDarkYellow838500,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const PaymentHistoryScreen(
                    screenType: UserRole.TENANT,
                  ),
                ),
              );
            },
            child: CustomText(
              txtTitle: StaticString.viewAll,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custDarkPurple662851,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPaymentHistoryCard({
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstants.backgroundColorFFFFFF,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custBlack000000.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txtTitle: StaticString.rent,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                CustomText(
                  txtTitle: "£1 250",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custDarkYellow838500,
                        fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  txtTitle: StaticString.paymentType,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                CustomText(
                  txtTitle: StaticString.bankTransfer,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custDarkYellow838500,
                      ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CustomCalender(
                  title: StaticString.paymentDate,
                  date: "15",
                  monthYear: "Sep 2021",
                  backgroundcolor: ColorConstants.custWhiteF7F7F7,
                  fontColor: ColorConstants.custDarkPurple662851,
                ),
                SizedBox(width: 10),
                CustomCalender(
                  title: StaticString.rentPeriod,
                  date: "16",
                  monthYear: "Aug 2021",
                  backgroundcolor: ColorConstants.custWhiteF7F7F7,
                  fontColor: ColorConstants.custDarkPurple662851,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: editPaymentBottomSheet,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: const CustImage(imgURL: ImgName.editIcon),
                ),
              ),
              const SizedBox(width: 1.5),
              InkWell(
                onTap: () {
                  showAlert(
                    context: context,
                    title: StaticString.deleteTenancy,
                    singleBtnTitle: StaticString.delete,
                    showIcon: false,
                    singleBtnColor: ColorConstants.custChartRed,
                    message: AlertMessageString.deleteTenancyConf,
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: const CustImage(imgURL: ImgName.deleteWhite),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> deleteTenancy() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      await tenancyProvider.deleteTenacy(widget.fetchCurrentTenancyModel.id);
      Provider.of<TenanciesProvider>(context, listen: false)
          .fetchPreviousTenancy(StaticString.statusCURRENT);
      Navigator.of(context).pop();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
