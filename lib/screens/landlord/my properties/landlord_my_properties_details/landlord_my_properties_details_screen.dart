// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/screens/landlord/my%20properties/landlord_my_properties_details/financialOverview/financial_overview.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/address_model.dart';
import '../../../../models/landloard/property_detail_model.dart';
import '../../../../models/landloard/property_list_model.dart';
import '../../../../models/settings/feedback_regarding_model.dart';
import '../../../../providers/dashboard_provider/landlord_dashboard_provider.dart';
import '../../../../providers/landlord/tenant/fetch_property_provider.dart';
import '../../../../providers/landlord/tenant/lease_detail_provider.dart';
import '../../../../providers/landlord/tenant/view_tenant_provider.dart';
import '../../../../providers/landlord_provider.dart';
import '../../../../services/image_picker_service.dart';
import '../../../../services/pdf_viewer_service.dart';
import '../../../../services/uri_launch_service.dart';
import '../../../../utils/cust_eums.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/bookmark_widget.dart';
import '../../../../widgets/calender_card.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/lenear_container.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/no_content_label.dart';
import '../../tenant/add tenants/add_tenant_rent_details_form.dart';
import '../../tenant/view_end tenancy/renew_lease_screen.dart';
import 'edit_rental_payment_bottomsheet.dart';
import 'landlord_income_payment_history_screen.dart';
import 'landlord_my_lease_screen.dart';
import 'logrental_payment_bottomsheet.dart';
import 'manage_property_bottom_sheet.dart';

class LandlordMyPropertiesDetailsScreen extends StatefulWidget {
  const LandlordMyPropertiesDetailsScreen({
    super.key,
    this.initialIndex = 0,
    this.propertyId = "",
  });

  final int initialIndex;
  final String propertyId;

  @override
  State<LandlordMyPropertiesDetailsScreen> createState() =>
      _LandlordMyPropertiesDetailsScreenState();
}

class _LandlordMyPropertiesDetailsScreenState
    extends State<LandlordMyPropertiesDetailsScreen>
    with TickerProviderStateMixin {
  //--------------------------------- variable-------------------------------//;

  //-------------List------------//
  // Home Item List
  List<String> homeItemList = [
    ImgName.landlordBed,
    ImgName.landlordBathtub,
    ImgName.landlordSofa,
  ];

  // Tab List
  List<String> tabList = [
    StaticString.income,
    StaticString.expenses,
    StaticString.tenantCapital
  ];

  // Property Image List
  List<String> propertyListImg = [
    ImgName.financial,
    ImgName.landlordMaintenance,
    ImgName.listMyProperties,
  ];

  // Property List Name
  List<String> propertyListName = [
    StaticString.financialOverview,
    StaticString.maintenanceHistory,
    StaticString.listMyProperty
  ];

  // Tenant Image List
  List<String> tenantListImg = [
    ImgName.addTenant1,
    ImgName.myLeases1,
    ImgName.previousTenants,
  ];

  // Tenant List Name
  List<String> tenantListName = [
    StaticString.addTenant,
    StaticString.myLeases,
    StaticString.previousTenant
  ];

  // Call Mail And Edit icon List
  List<String> callMailEdit = [
    ImgName.tenantCall,
    ImgName.landlordEmailCircle,
    ImgName.tenantEdit
  ];

  List<FeedbackRegardingModel> paymentTypeList = [
    FeedbackRegardingModel(
      id: 0,
      feedbackType: "Online",
    ),
    FeedbackRegardingModel(
      id: 1,
      feedbackType: "Cash on Delivery",
    ),
    FeedbackRegardingModel(
      id: 2,
      feedbackType: "Bank Transfer",
    ),
  ];

  //Tenancy List
  List<Tenancy> tenancyList = [];

  // Previous Tenancy List
  List<Tenancy> previousTenancyList = [];

  // Tab Controller
  TabController? _tabController;

  // Is Previous Tenant
  bool isPreviousTenant = false;

  //--------getter methods-------//

  //landlord tenant ViewTenant Provider getter method
  LandlordTenantViewTenantProvider get landlordTenantViewTenantProvider =>
      Provider.of<LandlordTenantViewTenantProvider>(
        context,
        listen: false,
      );
  //landlord tenant ViewTenant Provider getter method
  LandlordDashboradProvider get landlordDashboradProvider =>
      Provider.of<LandlordDashboradProvider>(
        context,
        listen: false,
      );
  //landlord tenant ViewTenant Provider getter method
  LandlordProvider get landlordProvider => Provider.of<LandlordProvider>(
        context,
        listen: false,
      );
  //landlord tenant Property Provider getter method
  LandlordTenantPropertyProvider get landlordTenantPropertyProvider =>
      Provider.of<LandlordTenantPropertyProvider>(
        context,
        listen: false,
      );

  //get fetch Lease Provider
  LeaseDetailProvider get getFetchLease =>
      Provider.of<LeaseDetailProvider>(context, listen: false);

  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // Properties Provider getter
  LandlordProvider get getPropertiesProvider =>
      Provider.of<LandlordProvider>(context, listen: false);

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: 3,
      initialIndex: widget.initialIndex,
    );
    super.initState();
    fetchPropertyData();
  }

  //--------------------------------- UI -------------------------------//;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  //------------------------------------Widgets------------------------------//

  // App bar
  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const Text(
        StaticString.myProperty,
      ),
      actions: [
        IconButton(
          onPressed: () => managePropertyBtnActiom(),
          icon: const CustImage(
            imgURL: ImgName.more,
            imgColor: Colors.white,
          ),
        )
      ],
    );
  }

  // Body
  Widget _buildBody() {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Consumer<LandlordProvider>(
        builder: (context, propertyDetailData, child) {
          return propertyDetailData.getPropertiesDetailList.isEmpty
              ? NoContentLabel(
                  title: StaticString.nodataFound,
                  onPress: () {
                    fetchPropertyData();
                  },
                )
              : DefaultTabController(
                  initialIndex: widget.initialIndex,
                  length: 3,
                  child: NestedScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverToBoxAdapter(
                        child: Stack(
                          children: [
                            //Property Image
                            Align(
                              alignment: Alignment.topLeft,
                              child: CustImage(
                                height: 200,
                                width: double.infinity,
                                imgURL: propertyDetailData
                                        .getPropertiesDetailList
                                        .first
                                        .photos
                                        .isNotEmpty
                                    ? propertyDetailData.getPropertiesDetailList
                                        .first.photos.first
                                    : "",
                              ),
                            ),

                            //Property Detail Card
                            _propertyDetailsCard(
                              propertyDetailModel: propertyDetailData
                                  .getPropertiesDetailList.first,
                            ),
                          ],
                        ),
                      ),
                    ],
                    body: _buildTabbarView(),
                  ),
                );
        },
      ),
    );
  }

  //Property Detail Card
  Widget _propertyDetailsCard({
    required PropertiesDetailModel propertyDetailModel,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 150),
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
          // Property title and subtitle text and book mark card
          _propertyTitleAndBookmarkIconCardRow(
            propertyDetailModel: propertyDetailModel,
          ),
          const SizedBox(height: 20),

          // Home Property item count
          _homeItemList(propertyDetailModel: propertyDetailModel),
          const SizedBox(height: 45),

          // Property List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                propertyListImg.length,
                (index) => InkWell(
                  onTap: () {
                    if (index == 0) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => FinancialOverviewScreen(
                            financeId: widget.propertyId,
                            propertyDetailModel: propertyDetailModel,
                          ),
                        ),
                      );
                    }
                  },
                  child: _propertyCard(
                    width: 90,
                    img: propertyListImg[index],
                    title: propertyListName[index],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Tabbar
          _tabbar(),
        ],
      ),
    );
  }

  // Property title and subtitle text and book mark card
  Widget _propertyTitleAndBookmarkIconCardRow({
    required PropertiesDetailModel propertyDetailModel,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Property name text
                CustomText(
                  txtTitle: propertyDetailModel.name,
                  textOverflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline3?.copyWith(
                        color: ColorConstants.custDarkBlue150934,
                        fontWeight: FontWeight.w700,
                      ),
                ),

                // Property full Address text
                CustomText(
                  txtTitle: propertyDetailModel.address?.fullAddress,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontSize: 15,
                        color: ColorConstants.custGrey707070,
                      ),
                )
              ],
            ),
          ),
        ),

        //Book Mark Card
        if (propertyDetailModel.property.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.005,
              right: MediaQuery.of(context).size.height * 0.03,
            ),
            child: buildBookmark(
              text: propertyDetailModel.property.first.status
                  .replaceAll("_", "\n"),
              color: propertyDetailModel.property.first.status == "TO_LET"
                  ? ColorConstants.custRedE0320D
                  : propertyDetailModel.property.first.status == "LET"
                      ? ColorConstants.custGreen3CAC71
                      : propertyDetailModel.property.first.status == "HMO"
                          ? ColorConstants.custPurpleB772FF
                          : ColorConstants.custBlue29C3EF,
              size: const Size(43, 55),
            ),
          )
        else
          Container(),
      ],
    );
  }

  // Home Property item count
  Widget _homeItemList({required PropertiesDetailModel propertyDetailModel}) {
    final List<int> homeItemcount = [
      propertyDetailModel.bedRoom,
      propertyDetailModel.bathRoom,
      propertyDetailModel.livingRoom,
    ];
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: const EdgeInsets.only(left: 35),
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

  // Custom Home Item Card
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
              ),
        ),
        const SizedBox(width: 30),
      ],
    );
  }

  // Custom Property Card
  Widget _propertyCard({
    required String img,
    required String title,
    required double width,
    Color cardColor = Colors.white,
    Color shdowColor = ColorConstants.custGrey7A7A7A,
    Color textColor = ColorConstants.custGrey707070,
  }) {
    return Column(
      children: [
        //Property Image Card
        Container(
          padding: const EdgeInsets.all(10),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: cardColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: shdowColor.withOpacity(0.20),
                blurRadius: 12,
              )
            ],
          ),
          child: CustImage(
            imgURL: img,
            boxfit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 10),

        //Property Name Text
        SizedBox(
          width: width,
          child: CustomText(
            maxLine: 2,
            align: TextAlign.center,
            txtTitle: title,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
          ),
        )
      ],
    );
  }

  // Tabbar
  Widget _tabbar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TabBar(
            padding: EdgeInsets.zero,
            labelColor: ColorConstants.custBlue1EC0EF,
            unselectedLabelColor: ColorConstants.custGrey707070,
            indicatorColor: ColorConstants.custBlue1EC0EF,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
            controller: _tabController,
            tabs: const [
              Tab(text: StaticString.income),
              Tab(text: StaticString.expenses),
              Tab(text: StaticString.tenantCapital),
            ],
            unselectedLabelStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w600),
            labelStyle: Theme.of(context)
                .textTheme
                .bodyText2!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  // tenant tabbarView...
  TabBarView _buildTabbarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        //Income Tabbar View
        _incomeTabbarView(),

        //Expenses Tabbar View
        Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.red,
          ),
        ),

        //Tenant Tabbar view
        _tenantsTabbarView()
      ],
    );
  }

  //  income tav=bbarView...
  Widget _incomeTabbarView() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),

          //Income Card
          _buildIncomeCard(),
          const SizedBox(height: 40),

          // Payment history Header text and view alll button row
          _commanHeaderAndChildColumn(
            title: StaticString.paymentHistory,
          ),
          const SizedBox(height: 30),

          //Payment History Card
          _paymentHistoryCard(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildIncomeCard() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
              _tenantRentCard(bookMarkTxt: "", rentAmount: "1986"),
              const SizedBox(height: 10),
              // Over due  and rent due date text row
              _overdueTextAndDuedateTextRow(),
              const SizedBox(height: 25),

              //start and end tenancy card row
              _startandendTenancyCardRow(),
              const SizedBox(height: 20),

              // Rent Period card
              _rentPeriodCard(
                rentPeriodDate: StaticString.rentPeriodDate1,
                rentStatus: StaticString.remainingDue,
                rentStatusColor: ColorConstants.custGreen3CAC71,
                rent: "1986",
                lateFee: "",
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 12),
                child: Divider(
                  indent: 10,
                  endIndent: 10,
                ),
              ),

              _rentPeriodCard(
                rentPeriodDate: StaticString.rentPeriodDate2,
                rentStatus: StaticString.overDue,
                rentStatusColor: ColorConstants.custPureRedFF0000,
                rent: "1986",
                lateFee: "50",
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
        // Profile image card
        _profilImagecard(profileImg: ""),
      ],
    );
  }

  // Profile image card
  Widget _profilImagecard({required String profileImg}) {
    return Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CustImage(
          imgURL: profileImg,
        ),
      ),
    );
  }

  // Tenat Rent card
  Widget _tenantRentCard({
    bool isBookmarkCard = false,
    required String bookMarkTxt,
    required String rentAmount,
  }) {
    return Row(
      mainAxisAlignment: isBookmarkCard
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.end,
      children: [
        if (isBookmarkCard && bookMarkTxt.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: buildBookmark(
              size: const Size(40, 55),
              text: bookMarkTxt.replaceAll(" ", "\n"),
              color: isPreviousTenant
                  ? ColorConstants.custGrey707070.withOpacity(0.70)
                  : ColorConstants.custDarkPurple160935,
            ),
          )
        else
          Container(),
        Container(
          width: 85,
          height: 55,
          padding: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: isPreviousTenant
                ? ColorConstants.custGrey707070.withOpacity(0.70)
                : ColorConstants.custGreen3CAC71, //propertyList.offerColor
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // RENT Text
              CustomText(
                align: TextAlign.center,
                txtTitle: StaticString.rent,
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),

              // rent text
              CustomText(
                align: TextAlign.center,
                txtTitle:
                    "${StaticString.currency}$rentAmount", //propertyList.tenantRent
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Over due  and rent due date text row
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
              txtTitle: "${StaticString.overdueBy} 17 Days",
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

  //start and end tenancy card row
  Widget _startandendTenancyCardRow() {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        children: [
          const CommonCalenderCard(
            title: StaticString.startTenancy,
            date: "01 ",
            calenderUrl: ImgName.commonCalendar,
            bgColor: ColorConstants.custWhiteF7F7F7,
            dateMonth: StaticString.startTenancyDate,
            imgColor: ColorConstants.custDarkPurple500472,
          ),
          SizedBox(width: MediaQuery.of(context).size.height * 0.032),
          const CommonCalenderCard(
            date: "31 ",
            title: StaticString.endTenancy,
            bgColor: ColorConstants.custWhiteF7F7F7,
            dateMonth: StaticString.endTenancyDate,
            calenderUrl: ImgName.commonCalendar,
            imgColor: ColorConstants.custDarkPurple500472,
          ),
        ],
      ),
    );
  }

  // Custom Rent Period Card
  Column _rentPeriodCard({
    required String rentPeriodDate,
    required Color rentStatusColor,
    required String rentStatus,
    required String rent,
    required String lateFee,
  }) {
    return Column(
      children: [
        // Calender clock image , rent period text and logpayment text row
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12, right: 5),
              child: CustImage(
                imgURL: ImgName.calenderClockBlue,
                height: 18,
                width: 18,
                boxfit: BoxFit.contain,
              ),
            ),

            // rent Period and date text
            Expanded(
              flex: 4,
              child: CustomText(
                txtTitle:
                    "${StaticString.rentPeriod}${" ("}$rentPeriodDate${") "}",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: ColorConstants.custDarkPurple500472,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),

            //log payment text
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: logPaymntBtnAction,
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
            )
          ],
        ),
        const SizedBox(height: 10),
        // rent title. status and amount text row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  text: StaticString.rent1,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.custGrey707070,
                        fontWeight: FontWeight.w500,
                      ),
                  children: <TextSpan>[
                    TextSpan(
                      text: rentStatus,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: rentStatusColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
              // rent amount text
              CustomText(
                txtTitle: "${StaticString.currency}$rent",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custBlue1EC0EF,
                      fontWeight: FontWeight.w600,
                    ),
              )
            ],
          ),
        ),
        // late fee and amount text row
        if (lateFee.isEmpty)
          const SizedBox(height: 0)
        else
          _custTitleAndAmountRow(title: StaticString.lateFee, amount: lateFee)
      ],
    );
  }

  // Payment history Header text and view alll button row
  Widget _commanHeaderAndChildColumn({
    required String title,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: title,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.custDarkBlue150934,
                    ),
              ),
              InkWell(
                onTap: viewAllBtnaction,
                child: CustomText(
                  // onPressed: viewAllBtnaction,
                  txtTitle: StaticString.viewAll.toLowerCase(),
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custBlue1EC0EF,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          LinearContainer(
            width: MediaQuery.of(context).size.width / 7,
            color: ColorConstants.custDarkPurple500472,
          ),
          const SizedBox(
            height: 3,
          ),
          LinearContainer(
            width: MediaQuery.of(context).size.width / 11,
            color: ColorConstants.custBlue1BC4F4,
          ),
        ],
      ),
    );
  }

  // Payment hitory card
  Widget _paymentHistoryCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
          )
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          _custTitleAndAmountRow(title: StaticString.rent1, amount: "1986"),
          const SizedBox(height: 15),
          _custTitleAndAmountRow(
            title: StaticString.paymentType,
            amount: StaticString.bankTransfer,
            isCurrency: false,
          ),
          const SizedBox(height: 20),

          // Calender card row
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                const CommonCalenderCard(
                  title: StaticString.paymentDate,
                  date: "15 ",
                  calenderUrl: ImgName.commonCalendar,
                  bgColor: ColorConstants.custWhiteF7F7F7,
                  dateMonth: StaticString.startTenancyDate,
                  imgColor: ColorConstants.custDarkPurple500472,
                ),
                SizedBox(width: MediaQuery.of(context).size.height * 0.033),
                const CommonCalenderCard(
                  title: StaticString.rentPeriod,
                  date: "30 ",
                  dateMonth: StaticString.endTenancyDate,
                  calenderUrl: ImgName.commonCalendar,
                  bgColor: ColorConstants.custWhiteF7F7F7,
                  imgColor: ColorConstants.custDarkPurple500472,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          //recuring payment
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 7,
                  top: 10,
                  bottom: 10,
                ),
                decoration: const BoxDecoration(
                  color: ColorConstants.custDarkPurple500472,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: CustomText(
                  txtTitle: StaticString.recuringPayment,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const Spacer(),
              // Edit icon card
              InkWell(
                onTap: editRentalPaymntBtnAction,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: const BoxDecoration(
                    color: ColorConstants.custDarkPurple500472,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(20)),
                  ),
                  child: const CustImage(imgURL: ImgName.editIcon),
                ),
              ),
              const SizedBox(width: 1.5),
              //Delete icon card
              InkWell(
                onTap: deleteRentalPaymentBtnAction,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: const BoxDecoration(
                    color: ColorConstants.custBlue1EC0EF,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(10)),
                  ),
                  child: const CustImage(imgURL: ImgName.deleteWhite),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // Tenants tabbar view
  Widget _tenantsTabbarView() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 25),
          // Tenant List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                tenantListImg.length,
                (index) {
                  return GestureDetector(
                    onTap: () => tenatPropertyCardOntap(
                      index: index,
                    ),
                    // Tenant Card
                    child: _propertyCard(
                      img: tenantListImg[index],
                      title: tenantListName[index],
                      width: 60,
                      textColor: index == 2
                          ? isPreviousTenant
                              ? ColorConstants.custBlue1EC0EF
                              : ColorConstants.custGrey707070
                          : ColorConstants.custGrey707070,
                      cardColor: index == 2
                          ? isPreviousTenant
                              ? ColorConstants.custBlue1EC0EF
                              : Colors.white
                          : Colors.white,
                      shdowColor: index == 2
                          ? isPreviousTenant
                              ? Colors.transparent
                              : ColorConstants.custGrey707070
                          : ColorConstants.custGrey707070,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 50),

          if (isPreviousTenant)
            previousTenancyList.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: const NoContentLabel(
                      title: StaticString.noPreviousTenancyDataFound,
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: previousTenancyList.length,
                    itemBuilder: (context, index) {
                      return
                          // Previous Tenant person details card
                          _customPreviousTenantCard(
                        previousTenancyModel: previousTenancyList[index],
                      );
                    },
                  )
          else
            tenancyList.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: const NoContentLabel(
                      title: StaticString.noTenancyDataFound,
                    ),
                  )
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tenancyList.length,
                    itemBuilder: (context, index) {
                      return
                          // Tenant person details card
                          _customTenantCard(
                        tenancyModel: tenancyList[index],
                      );
                    },
                  ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // Custom Tenant Card
  Widget _customTenantCard({required Tenancy tenancyModel}) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
              )
            ],
          ),
          // Tenant Person Details
          child: Column(
            children: [
              // Tenanr rent card
              _tenantRentCard(
                isBookmarkCard: true,
                bookMarkTxt: tenancyModel.roomName,
                rentAmount: tenancyModel.rentAmount.toString(),
              ),

              // tenant person name text and call,mail,edit Icon Row
              _tenantPersonTextAndCallMailEditIcon(
                tenacyDetail: tenancyModel,
                propertyDetailId: tenancyModel.propertyId,
              ),
              const SizedBox(height: 10),

              //Deposite Paid  and amout Text Row
              _custTitleAndAmountRow(
                title: StaticString.deposit,
                amount: tenancyModel.depositAmount.toString(),
              ), //7990065313

              //my Deposite and amout Text Row
              _custTitleAndAmountRow(
                title: tenancyModel.depositScheme?.attributeValue ?? "",
                amount: tenancyModel.depositId,
                isCurrency: false,
              ),
              const SizedBox(height: 10),

              // Upload Leases doc text and Camera option row

              _uploadLeasesDocTextAndCameraRow(tenancyModel),

              const SizedBox(height: 15),

              // Renew Lease and end tenancy card row
              Consumer<LandlordProvider>(
                builder: (context, lanloardProvider, child) => Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => renewLeaseBtnAction(
                          tenancyModel: tenancyModel,
                          propertyModel:
                              lanloardProvider.getPropertiesDetailList.first,
                        ),
                        child: _custRenewAndEndTenancyCard(
                          color: ColorConstants.custBlue1EC0EF,
                          img: ImgName.renewLease,
                          title: StaticString.renewLease.toUpperCase(),
                          radius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () =>
                            endTenancyBtnAction(tenancyId: tenancyModel.id),
                        child: _custRenewAndEndTenancyCard(
                          color: ColorConstants.custRedD92A2A,
                          img: ImgName.endTenancy,
                          title: StaticString.endTenancyCapital,
                          radius: const BorderRadius.only(
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // Profile image card
        _profilImagecard(profileImg: tenancyModel.profile?.profileImg ?? ""),
        const SizedBox(height: 30),
      ],
    );
  }

  //Custom Previous Tenant card
  Widget _customPreviousTenantCard({required Tenancy previousTenancyModel}) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
              )
            ],
          ),
          // Tenant Person Details
          child: Column(
            children: [
              // Tenanr rent card
              _tenantRentCard(
                isBookmarkCard: true,
                bookMarkTxt: previousTenancyModel.roomName,
                rentAmount: previousTenancyModel.rentAmount.toString(),
              ),
              const SizedBox(height: 10),

              // tenant person name text and call,mail,edit Icon Row
              _previousTenantPersonTextAndCallIcon(
                tenacyDetail: previousTenancyModel,
              ),
              const SizedBox(height: 15),

              // Calender card row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: CommonCalenderCard(
                        titleColor: ColorConstants.custGrey707070,
                        title: StaticString.leasesStart,
                        date: DateFormat("dd").format(
                          previousTenancyModel.startDate ?? DateTime.now(),
                        ),
                        calenderUrl: ImgName.commonCalendar,
                        bgColor: ColorConstants.custWhiteF7F7F7,
                        dateMonth: DateFormat(" MMM yyyy").format(
                          previousTenancyModel.startDate ?? DateTime.now(),
                        ),
                        imgColor: ColorConstants.custGrey707070,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CommonCalenderCard(
                        title: StaticString.leasesEnd,
                        titleColor: ColorConstants.custGrey707070,
                        date: DateFormat("dd").format(
                          previousTenancyModel.endDate ?? DateTime.now(),
                        ),
                        dateMonth: DateFormat(" MMM yyyy").format(
                          previousTenancyModel.endDate ?? DateTime.now(),
                        ),
                        calenderUrl: ImgName.commonCalendar,
                        bgColor: ColorConstants.custWhiteF7F7F7,
                        imgColor: ColorConstants.custGrey707070,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              //Deposite Paid  and amout Text Row
              _custTitleAndAmountRow(
                title: StaticString.depositPaid1,
                amount: previousTenancyModel.depositAmount.toString(),
                amountColor: ColorConstants.custGrey707070,
              ),

              //Damage Charges  and amout Text Row
              _custTitleAndAmountRow(
                title: StaticString.damageCharegs,
                amount: previousTenancyModel.depositAmount.toString(),
              ),
              //Deposit Refunded and amout Text Row
              _custTitleAndAmountRow(
                title: StaticString.depositeRefunded,
                amount: previousTenancyModel.depositAmount.toString(),
                amountColor: ColorConstants.custGrey707070,
              ),

              //Tenancy Deposit Scheme and amout Text Row
              _custTitleAndAmountRow(
                title: previousTenancyModel.depositScheme?.attributeValue ?? "",
                amount: previousTenancyModel.depositId,
                amountColor: ColorConstants.custGrey707070,
                isCurrency: false,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
        // Profile image card
        Stack(
          children: [
            _profilImagecard(
              profileImg: previousTenancyModel.profile?.profileImg ?? "",
            ),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.custGrey707070.withOpacity(0.50),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Container _custRenewAndEndTenancyCard({
    required Color color,
    required String img,
    required String title,
    required BorderRadiusGeometry radius,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 5),
        child: Row(
          children: [
            CustImage(
              imgURL: img,
              height: 20,
            ),
            const SizedBox(width: 4),
            CustomText(
              txtTitle: title,
              align: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            )
          ],
        ),
      ),
    );
  }

  Widget _tenantPersonTextAndCallMailEditIcon({
    required Tenancy tenacyDetail,
    required String propertyDetailId,
  }) {
    return Column(
      children: [
        // Tenant Full Name
        CustomText(
          txtTitle: tenacyDetail.profile?.fullName ?? "",
          style: Theme.of(context).textTheme.headline3?.copyWith(
                color: ColorConstants.custDarkPurple150934,
                fontWeight: FontWeight.w500,
              ),
        ),

        // Call Mail And Edit Button Action
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            children: List.generate(
              callMailEdit.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 7, top: 5),
                child: InkWell(
                  onTap: () => callMailEmailCardOntap(
                    index: index,
                    tenacyDetail: tenacyDetail,
                  ),
                  child: CustImage(
                    imgURL: callMailEdit[index],
                    width: 24,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  // Previous Tenant PErson Text and Call  Icon Row
  Widget _previousTenantPersonTextAndCallIcon({required Tenancy tenacyDetail}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          txtTitle: tenacyDetail.profile?.fullName ?? "",
          style: Theme.of(context).textTheme.headline3?.copyWith(
                color: ColorConstants.custDarkPurple150934,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(width: 10),
        InkWell(
          onTap: () => launchMobile(tenacyDetail.profile?.mobile ?? ""),
          child: const CustImage(
            imgURL: ImgName.tenantCall,
            width: 24,
            height: 24,
          ),
        ),
      ],
    );
  }

  // Upload Leases doc text and Camera option row
  Widget _uploadLeasesDocTextAndCameraRow(Tenancy tenancyModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: StaticString.uploadLeaseDoc,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custRedD92A2A,
                  fontWeight: FontWeight.w500,
                ),
          ),
          // Row(
          //   children: List.generate(
          //     uploaddocImg.length,
          //     (index) => CustImage(
          //       imgURL: uploaddocImg[index],
          //       height: 50,
          //     ),
          //   ),
          // ),
          if (tenancyModel.leaseUrl.isEmpty)
            InkWell(
              onTap: () {
                cameraIconOntap(tenancyModel.leaseId, tenancyModel);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 5),
                child: CustImage(
                  imgURL: ImgName.landlordCamera,
                  boxfit: BoxFit.contain,
                  height: 25,
                  width: 25,
                ),
              ),
            )
          else
            InkWell(
              onTap: () {
                if (tenancyModel.leaseUrl.isNetworkImage) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PDFViewerService(
                        userRole: UserRole.LANDLORD,
                        pdfUrl: tenancyModel.leaseUrl,
                      ),
                    ),
                  );
                }
              },
              child: const CustImage(
                imgURL: ImgName.landlordPdf,
                height: 25,
                boxfit: BoxFit.contain,
              ),
            )
        ],
      ),
    );
  }

  //----------------------------Helper Widget------------------------//

  // custom Title and amount row
  Widget _custTitleAndAmountRow({
    required String title,
    Color amountColor = ColorConstants.custBlue1EC0EF,
    required String amount,
    bool isCurrency = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: title,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w500,
                ),
          ),
          // rent amount text
          CustomText(
            txtTitle: isCurrency ? "${StaticString.currency}$amount" : amount,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: amountColor,
                  fontWeight: FontWeight.w600,
                ),
          )
        ],
      ),
    );
  }

  //---------------------------button action------------------------------//

  // view all butoon action
  void viewAllBtnaction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const LandlordIncomePaymentHistoryscreen(),
      ),
    );
  }

  // Manage Property Button action
  void managePropertyBtnActiom() {
    if (getPropertiesProvider.getPropertiesDetailList.isNotEmpty) {
      showAlert(
        hideButton: true,
        showCustomContent: true,
        context: context,
        showIcon: false,
        title: StaticString.manageProperty,
        content: ManagePropertyBottomSheet(
          propertiesDetailModel:
              getPropertiesProvider.getPropertiesDetailList.first,
          onDelete: deleteProperty,
        ),
      );
    }
  }

  // Log payment Button action
  void logPaymntBtnAction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const LogRentalPaymentBottomsheet();
      },
    );
  }

  // Edit Rental payment Button action
  void editRentalPaymntBtnAction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const EditRentalPaymentBottomsheet();
      },
    );
  }

  // Delete Rental payment Button action
  void deleteRentalPaymentBtnAction() {
    showAlert(
      context: context,
      showIcon: false,
      icon: ImgName.activesubscriptionImage,
      title: StaticString.deleteTransection,
      message: StaticString.areYouSureYouWantToDeleteThisEntry,
      singleBtnTitle: StaticString.delete1,
      singleBtnColor: ColorConstants.custRedFF0000,
    );
  }

  // Renew Lease Button action
  void renewLeaseBtnAction({
    required Tenancy tenancyModel,
    required PropertiesDetailModel propertyModel,
  }) {
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => TenantRenewLeaseScreen(
          tenancyModel: tenancyModel,
          propertiesDetailModel: propertyModel,
          //  getPropertiesProvider.getPropertiesDetailList.first,
        ),
      ),
    );
  }

  // Tenant Property Card Ontap
  Future<void> tenatPropertyCardOntap({
    required int index,
  }) async {
    if (index == 0) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => LandlordAddEditTenantRentDetailForm(
            property: LandlordAddTenantPropertyListModel(
              id: widget.propertyId,
              address: AddressModel(),
              propertyResource: PropertyResourceModel(),
            ),
            doPop: true,
          ),
        ),
      );
      fetchPropertyData(isBackgroundCall: true);
    } else if (index == 1) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => LandlordMyLeaseScreen(
            propertyDetailId: widget.propertyId,
          ),
        ),
      );
      fetchPropertyData(isBackgroundCall: true);
    } else if (index == 2) {
      if (mounted) {
        setState(() {
          isPreviousTenant = !isPreviousTenant;
        });
      }
    }
  }

  // Call Mail Email Card On tap
  Future<void> callMailEmailCardOntap({
    required int index,
    required Tenancy tenacyDetail,
  }) async {
    if (index == 0) {
      // tenacyDetail.profile;
      launchMobile(tenacyDetail.profile?.mobile ?? "");
    } else if (index == 1) {
      launchEmail(tenacyDetail.profile?.email ?? "");
    } else if (index == 2) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => LandlordAddEditTenantRentDetailForm(
            property: LandlordAddTenantPropertyListModel(
              id: widget.propertyId,
              address: AddressModel(),
              propertyResource: PropertyResourceModel(),
            ),
            doPop: true,
            tenancyId: tenacyDetail.id,
          ),
        ),
      );
      fetchPropertyData(isBackgroundCall: true);
    }
  }

  // End Tenancy button action
  void endTenancyBtnAction({required String tenancyId}) {
    showAlert(
      context: context,
      title: StaticString.endTenancy,
      singleBtnTitle: AlertMessageString.yesEndTenancy.toUpperCase(),
      showIcon: false,
      singleBtnColor: ColorConstants.custChartRed,
      message: AlertMessageString.endTenancyConf,
      onRightAction: () async {
        try {
          _loadingIndicatorNotifier.show(
            loadingIndicatorType: LoadingIndicatorType.overlay,
          );
          await landlordTenantViewTenantProvider.removeTenancy(
            tenancyId: tenancyId,
          );
          await fetchPropertyData(isBackgroundCall: true);
          landlordDashboradProvider.fetchLandlordDashboardList(context);
        } catch (e) {
          showAlert(context: context, message: e);
        } finally {
          _loadingIndicatorNotifier.hide();
        }
      },
    );
  }

  //-----------------------Helper function------------------//

  //Fetch Property Data Function
  Future<void> fetchPropertyData({bool isBackgroundCall = false}) async {
    try {
      if (!isBackgroundCall) {
        _loadingIndicatorNotifier.show(
          loadingIndicatorType: LoadingIndicatorType.spinner,
        );
      }

      await getPropertiesProvider.fetchPropertiesDetailsData(
        propertyId: widget.propertyId,
      );

      tenancyList.clear();
      previousTenancyList.clear();
      if (getPropertiesProvider.getPropertiesDetailList.isNotEmpty) {
        for (final propertyList
            in getPropertiesProvider.getPropertiesDetailList.first.property) {
          for (final tenant in propertyList.tenants) {
            if (tenant.status != TenantStatus.ENDED) {
              List<Tenancy> _tenancyList = [];
              _tenancyList = tenant.tenancies.map((e) {
                e.roomName = propertyList.roomName;
                e.propertyStatus = propertyList.status;
                return e;
              }).toList();

              tenancyList.addAll(_tenancyList);
            } else {
              List<Tenancy> _tenancyList = [];
              _tenancyList = tenant.tenancies.map((e) {
                e.roomName = propertyList.roomName;
                e.propertyStatus = propertyList.status;
                return e;
              }).toList();

              previousTenancyList.addAll(_tenancyList);
            }
          }
        }
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // Delete Property funtion
  Future<void> deleteProperty() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );

      await landlordProvider.deleteProperty(widget.propertyId);
      landlordDashboradProvider.fetchLandlordDashboardList(context);

      Navigator.of(context).pop();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // Camera Icon Card Ontap
  void cameraIconOntap(String leaesId, Tenancy tenancy) {
    if (leaesId.isEmpty) {
      return;
    }
    ImagePickerService(
      isDocumentsFile: true,
      pickedImg: (imgPath) async {
        if (imgPath?.isNotEmpty ?? false) {
          updateLeaseUrl(
            tenancy,
            imgPath?.first ?? "",
            leaesId,
          );
        }
      },
    ).openImagePikcer(
      multipicker: false,
      context: context,
      iosImagePicker: Platform.isIOS,
    );
  }

  Future<void> updateLeaseUrl(
    Tenancy tenancy,
    String leaseUrl,
    String leaseId,
  ) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );

      final String getLeaseUrl = await getFetchLease.leaesUpdateUrl(
        leaesId: leaseId,
        leaesUrl: leaseUrl,
      );
      if (mounted) {
        setState(() {
          tenancy.leaseUrl = getLeaseUrl;
        });
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
