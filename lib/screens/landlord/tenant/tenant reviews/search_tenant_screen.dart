import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/models/room_list_model.dart';
import 'package:zungu_mobile/screens/landlord/tenant/tenant%20reviews/myreview_screen.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import '../../../../constant/color_constants.dart';
import '../../../../constant/img_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/settings/business_profile/fetch_profile_model.dart';
import '../../../../providers/landlord/tenant/fetch_property_provider.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/cust_image.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/image_upload_outlined_widget.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../utils/custom_extension.dart';
import '../add tenants/add_tenant.dart';

//  class Example {
//     String name;
//     String period;
//     bool canExpand;
//   }

class SearchTenantScreen extends StatefulWidget {
  const SearchTenantScreen({super.key});

  @override
  State<SearchTenantScreen> createState() => _SearchTenantScreenState();
}

bool isFilterIcon = false;

class _SearchTenantScreenState extends State<SearchTenantScreen> {
  // form keys

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier _searchNotifier = ValueNotifier(true);
  final GlobalKey<FormState> _formSearchKey = GlobalKey<FormState>();
  // controllers
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _selectPropetryController =
      TextEditingController();
  final TextEditingController _tenantFullNameController =
      TextEditingController();
  final TextEditingController _previousRentController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  // notifiers
  final LoadingIndicatorNotifier _indicatorNotifier =
      LoadingIndicatorNotifier();

  // providers
  LandlordTenantPropertyProvider get landlordTenantPropertyProvider =>
      Provider.of<LandlordTenantPropertyProvider>(
        context,
        listen: false,
      );
  late final _ratingController;
  late double _rating;
  final double _initialRating = 2.0;
  final bool _isVertical = false;
  bool urgentRequest = false;
  FetchProfileModel? _tradesprofileModel;
  bool isSearched = false;
  bool _isVisible = false;
  bool? cardExpansion = false;
  // ignore: prefer_final_fields
  bool _isReviewed = false;

  List<ReviewCardModel> reviewcard = [
    ReviewCardModel(canExpand: false, name: "Roy Odoom", period: "1"),
    ReviewCardModel(canExpand: false, name: "Anees Naidoo", period: "2"),
    ReviewCardModel(canExpand: false, name: "English Rose", period: "3")
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ratingController = TextEditingController(text: '3.0');
    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Row(
                children: [
                  const CustImage(
                    imgURL: ImgName.house,
                    height: 20,
                  ),
                  CustomText(
                    txtTitle: StaticString.tenantsMobileNumber,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custGrey707070,
                          fontWeight: FontWeight.w600,
                        ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5),
            // search bar
            _buildSearchBar(),
            // buildOutlineCommonSearchBar(
            //   context: context,
            //   color: ColorConstants.custDarkPurple500472,
            //   image: ImgName.landlordSearch,
            //   title: StaticString.searchByProperty,
            //   controller: _searchController,
            //   searchFunc: _searchFunc,
            // ),

            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: _isReviewed
                  ? CustomText(
                      align: TextAlign.center,
                      txtTitle:
                          "This Tenant does not have any Reviews. Would you like to Review this Tenant?",
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  : _buildReviewCard(
                      color: ColorConstants.custskyblue21C1EF,
                    ),
            ),

            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                if (mounted) {
                  setState(() {
                    _isVisible = !_isVisible;
                    _isReviewed = !_isReviewed;
                  });
                }
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (ctx) => ,
                //   ),
                // );
              },
              child: CustomText(
                txtTitle: StaticString.leaveAReview,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.custGreen34A308,
                    ),
              ),
            ),
            const SizedBox(height: 15),
            if (_isReviewed)
              Container()
            else
              Column(
                children: [
                  _buildPreviousLandlordReviewCardCard(),
                  const SizedBox(height: 20),
                  //_buildStack(),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _buildReviewInfoCard(
                        reviewCard: reviewcard[index],
                        onChange: (value) {
                          setState(() {
                            reviewcard[index].canExpand = value;
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: reviewcard.length,
                  ),
                  // _buildReviewInfoCard()
                ],
              ),
            //const Divider(),
            const SizedBox(height: 15),
            Visibility(
              visible: _isVisible,
              child: Column(
                children: [
                  _buildTenantReviewDetails(),
                  const SizedBox(height: 25),
                  _buildMobileNumberCard(),
                  const SizedBox(height: 30),
                  _buildRatingCard(textTitle: StaticString.tookCareOfProperty),
                  const SizedBox(height: 30),
                  _buildRatingCard(textTitle: StaticString.paidOnTime),
                  const SizedBox(height: 30),
                  _buildRatingCard(textTitle: StaticString.wouldRecommend),
                  const SizedBox(height: 30),
                  _arrearsSwitchRow(),
                  const SizedBox(height: 10),
                  _buidlArrearsAmountTextField(),
                  const SizedBox(height: 30),
                  UploadMediaOutlinedWidget(
                    title: "${StaticString.uploadLeaseToProveTenancy}*",
                    userRole: UserRole.TENANT,
                    image: ImgName.landlordCamera,
                    showOptional: false,
                    maxImages: 1,
                    prefillImages:
                        (_tradesprofileModel?.profileImg.isEmpty ?? true)
                            ? []
                            : [_tradesprofileModel?.profileImg ?? ""],
                    onSelectImg: (selectedImages) async {
                      if (selectedImages.isNotEmpty) {
                        if (mounted) {
                          setState(() {
                            _tradesprofileModel?.profileImg =
                                selectedImages.first;
                          });
                        }
                      } else {
                        _tradesprofileModel?.profileImg = "";
                      }
                    },
                  ),
                  const SizedBox(height: 50),
                  CommonElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showSubmitMessage();
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (ctx) =>,
                        //   ),
                        // );
                      }

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (ctx) => const MyReviewScreen(),
                      //   ),
                      // );
                    },
                    bttnText: StaticString.submitReview,
                    color: ColorConstants.custskyblue22CBFE,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard({required Color color}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstants.backgroundColorFFFFFF,
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const CustImage(
                    imgURL: ImgName.tenantUserIcon,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          txtTitle: "Phil Collins",
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: ColorConstants.custDarkPurple160935,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomText(
                          txtTitle: "Tnant",
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: ColorConstants.custGrey707070,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildRatingBar(),
                    const SizedBox(height: 15),
                  ],
                ),
              ],
            ),
            _buildRatingInformation(
              txtRating: "5.0",
              txtRatingInfo: StaticString.tookCareOfProperty,
            ),
            _buildRatingInformation(
              txtRating: "1.0",
              txtRatingInfo: StaticString.paidOnTime,
            ),
            _buildRatingInformation(
              txtRating: "1.0",
              txtRatingInfo: StaticString.tookCareOfProperty,
            ),
            _buildRentArrears(
              statusAndAmount: "Yes",
              txtArrears: StaticString.previousRentArrears,
            ),
          ],
        ),
      ),
    );
  }

  //---build reviewinfo card----

  Widget _buildReviewInfoCard({
    required ReviewCardModel reviewCard,
    required Function(bool) onChange,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstants.backgroundColorFFFFFF,
                    width: 2,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const CustImage(
                  imgURL: ImgName.tenantUserIcon,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      txtTitle: reviewCard.name,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custDarkPurple160935,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    _buildLandlordRating(
                      txtRating: "(5.0)",
                      txtRatingInfo: StaticString.landlordSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 30,
              ),
              Flexible(
                child: Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      secondary: Colors.black,
                    ),
                  ),
                  child: ExpansionTile(
                    expandedAlignment: Alignment.topLeft,
                    title: CustomText(
                      txtTitle: "${reviewCard.period} year ago",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.w300,
                            color: ColorConstants.custDarkPurple160935,
                          ),
                    ),
                    trailing: SvgPicture.asset(
                      reviewCard.canExpand
                          ? ImgName.upArrow
                          : ImgName.arrowDown,
                    ),
                    onExpansionChanged: (value) {
                      onChange(value);
                    },
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              txtTitle: StaticString.tookCareOfProperty,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            _buildRatingBarStar(),
                            const SizedBox(height: 10),
                            CustomText(
                              txtTitle: StaticString.paidOnTime,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            _buildRatingBarStar(),
                            const SizedBox(height: 10),
                            CustomText(
                              txtTitle: StaticString.wouldRecommend,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            _buildRatingBarStar(),
                            const SizedBox(height: 10),
                            _buildPreviousArrears(
                              statusAndAmount: "Yes",
                              txtArrears: StaticString.previousRentArrears,
                            ),
                            const SizedBox(height: 10),
                            _buildPreviousArrears(
                              statusAndAmount: "£2560",
                              txtArrears: StaticString.previousRentArrears,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  //----build LandLord Ratin-----

  Widget _buildLandlordRating({
    required String txtRating,
    required String txtRatingInfo,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              txtTitle: txtRatingInfo,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.amber,
              child: const Icon(
                Icons.star,
                color: Colors.white,
                size: 15,
              ),
            ),
            const SizedBox(width: 5),
            CustomText(
              txtTitle: txtRating,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ],
    );
  }

  //-------build Rating information----
  Widget _buildRatingInformation({
    required String txtRating,
    required String txtRatingInfo,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 8,
            ),
            CustomText(
              txtTitle: txtRatingInfo,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.amber,
              child: const Icon(
                Icons.star,
                color: Colors.white,
                size: 15,
              ),
            ),
            const SizedBox(width: 5),
            CustomText(
              txtTitle: txtRating,
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        ),
      ],
    );
  }

  //-------build Rating information----
  Widget _buildRentArrears({
    required String statusAndAmount,
    required String txtArrears,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 8,
            ),
            CustomText(
              txtTitle: txtArrears,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ],
        ),
        CustomText(
          txtTitle: statusAndAmount,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custRedFF0000,
              ),
        ),
      ],
    );
  }

  //-----build Previous Arrears

  Widget _buildPreviousArrears({
    required String statusAndAmount,
    required String txtArrears,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              txtTitle: txtArrears,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ],
        ),
        CustomText(
          txtTitle: statusAndAmount,
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: ColorConstants.custRedFF0000,
              ),
        ),
      ],
    );
  }

  //-----Show Submit Mesaage-----
  Future _showSubmitMessage() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: ColorConstants.backgroundColorFFFFFF,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.custBlack000000.withOpacity(0.1),
                blurRadius: 15,
                spreadRadius: 0.2,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // TODO: Exact center title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: ColorConstants.custLightGreyC6C6C6,
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Align(
                        child: CustomText(
                          align: TextAlign.center,
                          txtTitle: StaticString.reviewTenant,
                          style:
                              Theme.of(context).textTheme.headline4?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.custDarkPurple150934,
                                  ),
                        ),
                      ),
                    ),
                    Expanded(child: Container())
                  ],
                ),
                const SizedBox(height: 20),
                const CustImage(
                  // imgColor: Colors.transparent,
                  imgURL: ImgName.rightIcon,
                ),
                const SizedBox(height: 20),
                CustomText(
                  align: TextAlign.center,
                  txtTitle:
                      "Your Review has been sent and is awaiting Approval",
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custGrey8F8F8F,
                      ),
                ),
                const SizedBox(height: 20),
                CommonElevatedButton(
                  bttnText: StaticString.ok,
                  color: ColorConstants.custskyblue22CBFE,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

//--------Tenant Review Details------
  Widget _buildTenantReviewDetails() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: TextFormField(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const LandlordAddTenant(),
                ),
              );
            },
            readOnly: true,
            cursorColor: ColorConstants.custDarkPurple150934,
            validator: (value) => value?.validateAddress,
            controller: _selectPropetryController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: "${StaticString.selectProperty}*",
              suffixIcon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 30,
                color: ColorConstants.custGrey707070,
              ),
            ),
            // onSaved: (name) {
            //   _tenancyModel.name = name ?? "";
            // },
          ),
        ),
        TextFormField(
          cursorColor: ColorConstants.custDarkPurple150934,
          validator: (value) => value?.validateName,
          controller: _tenantFullNameController,
          maxLength: 10,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.arrow_back),
            labelText: "${StaticString.tenantFullName}*",
            counterText: "",
          ),
          // onSaved: (mobileNumber) {
          //   _tenancyModel.mobileNumber = mobileNumber ?? "";
          // },
        ),
        CustomText(
          txtTitle: "*${StaticString.tenantNameNeeds}",
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: ColorConstants.custBlue2AC4EF,
              ),
        )
        // const CustomText(
        //   txtTitle: "*${StaticString.tenantNameNeeds}",
        // )
      ],
    );
  }

//-------Mobile Number Card-----

  Widget _buildMobileNumberCard() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConstants.custGreyE6E8E8,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: CustomText(
          txtTitle: "07425 542 692",
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }

  //Build Previous landlord reviews row card
  Widget _buildPreviousLandlordReviewCardCard() {
    return Container(
      alignment: Alignment.center,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorConstants.custDarkPurple500472.withOpacity(0.2),
      ),
      child: CustomText(
        txtTitle: "PREVIOUS LANDLORD REVIEWS",
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: ColorConstants.custDarkPurple500472,
            ),
      ),
    );
  }

  //-----build Rating Card------

  Widget _buildRatingCard({required String textTitle}) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: ColorConstants.custDarkPurple500472.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                txtTitle: textTitle,
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 10),
              SizedBox(
                child: RatingBar.builder(
                  initialRating: _initialRating,
                  minRating: 1,
                  direction: _isVertical ? Axis.vertical : Axis.horizontal,
                  allowHalfRating: true,
                  unratedColor: ColorConstants.custGreyBDBCBC,
                  itemSize: 25.0,
                  itemPadding: const EdgeInsets.symmetric(
                    horizontal: 2.0,
                  ),
                  updateOnDrag: true,
                  itemBuilder: (context, index) => Container(
                    color: Colors.amber,
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                  ),
                  onRatingUpdate: (rating) {
                    if (mounted) {
                      setState(() {
                        _rating = rating;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //--Previous Rent Arrears switch--

  Widget _arrearsSwitchRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: StaticString.previousRentArrears,
          style: Theme.of(context).textTheme.headline1,
        ),
        Switch.adaptive(
          activeTrackColor: ColorConstants.custPurple500472,
          activeColor: ColorConstants.backgroundColorFFFFFF,
          value: urgentRequest,
          onChanged: (value) {
            if (mounted) {
              setState(() {
                urgentRequest = value;
              });
            }
          },
        ),
      ],
    );
  }

  //---- Buid RatingBar-----

  Widget _buildRatingBar() {
    return Row(
      children: [
        SizedBox(
          child: RatingBar.builder(
            initialRating: _initialRating,
            minRating: 1,
            direction: _isVertical ? Axis.vertical : Axis.horizontal,
            allowHalfRating: true,
            unratedColor: ColorConstants.custGreyBDBCBC,
            itemSize: 15.0,
            itemPadding: const EdgeInsets.symmetric(
              horizontal: 1.0,
            ),
            updateOnDrag: true,
            itemBuilder: (context, index) => Container(
              color: Colors.amber,
              child: const Icon(
                Icons.star,
                color: Colors.white,
              ),
            ),
            onRatingUpdate: (rating) {
              if (mounted) {
                setState(() {
                  _rating = rating;
                });
              }
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        CustomText(
          txtTitle: "(${_rating.toString()})",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorConstants.custGrey707070,
              ),
        ),
      ],
    );
  }

  Widget _buildRatingBarStar() {
    return Row(
      children: [
        SizedBox(
          child: RatingBar.builder(
            initialRating: _initialRating,
            minRating: 1,
            direction: _isVertical ? Axis.vertical : Axis.horizontal,
            allowHalfRating: true,
            unratedColor: ColorConstants.custGreyBDBCBC,
            itemSize: 15.0,
            itemPadding: const EdgeInsets.symmetric(
              horizontal: 1.0,
            ),
            updateOnDrag: true,
            itemBuilder: (context, index) => Container(
              color: Colors.amber,
              child: const Icon(
                Icons.star,
                color: Colors.white,
              ),
            ),
            onRatingUpdate: (rating) {
              if (mounted) {
                setState(() {
                  _rating = rating;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  //----Arrears Amount Text form field----
  Widget _buidlArrearsAmountTextField() {
    return TextFormField(
      cursorColor: ColorConstants.custDarkPurple150934,
      validator: (value) => value?.validatemptyAmount,
      controller: _previousRentController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: "${StaticString.rentArrearsAmount}*",
      ),
      // onSaved: (name) {
      //   _tenancyModel.name = name ?? "";
      // },
    );
  }

  // search button action
  Future<void> _searchFunc() async {
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      _indicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      if (_formKey.currentState?.validate() ?? true) {
        await landlordTenantPropertyProvider.fetchProperties(
          query: _searchController.text,
        );
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _indicatorNotifier.hide();
    }
  }

  Widget _buildSearchBar() {
    return ValueListenableBuilder(
      valueListenable: _searchNotifier,
      builder: (context, val, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Form(
            key: _formSearchKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  enabled: !isSearched,
                  controller: _searchController,
                  cursorHeight: 20,
                  onEditingComplete: _searchFunc,
                  cursorColor: ColorConstants.custDarkPurple500472,
                  validator: (value) => value?.validatePhoneNumber,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  textInputAction: TextInputAction.search,
                  decoration: addTenantSearchInputdecoration(
                    onTap: _searchFunc,
                    enable: !isSearched,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// search bar decoration
  InputDecoration addTenantSearchInputdecoration({
    void Function()? onTap,
    required bool enable,
  }) {
    return InputDecoration(
      fillColor: enable ? null : ColorConstants.custWhiteF5F5F5,
      counterText: "",
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
      border: commonBorder(),
      enabledBorder: commonBorder(),
      disabledBorder: commonBorder(),
      focusedBorder: commonBorder(),
      focusedErrorBorder: commonBorder(),
      errorBorder: commonBorder(),
      labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
            color: ColorConstants.custDarkPurple160935,
          ),
      suffixIcon: IconButton(
        padding: const EdgeInsets.only(right: 10),
        onPressed: onTap,
        icon: const CustImage(
          imgURL: ImgName.landlordSearch,
          width: 24,
        ),
      ),
    );
  }

//  common Border of textformfield...
  OutlineInputBorder commonBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorConstants.borderColorACB4B0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
    );
  }

  // Search field
  Widget buildOutlineCommonSearchBar({
    required BuildContext context,
    required Color color,
    required String image,
    required String title,
    required TextEditingController controller,
    required Function() searchFunc,
    double doubleBorderRadius = 15,
    TextStyle? hintStyle,
  }) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      // padding: const EdgeInsets.symmetric(
      //   horizontal: 8,
      // ),
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.custGreyE6E6E6, width: 2),
        color: ColorConstants.backgroundColorFFFFFF,
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextFormField(
        validator: (value) {
          if (value == "") {
            return "";
          }
          return null;
        },
        textInputAction: TextInputAction.search,
        keyboardType: TextInputType.phone,
        style: Theme.of(context).textTheme.headline2,
        cursorColor: color,
        controller: controller,
        onEditingComplete: searchFunc,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 2.0,
            horizontal: 8.0,
          ),
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          //hintText: title,
          hintStyle: hintStyle,
          suffixIcon: IconButton(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: searchFunc,
            icon: CustImage(
              imgURL: image,
              width: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class ReviewCardModel {
  String name;
  String period;
  bool canExpand;

  ReviewCardModel({
    required this.name,
    required this.period,
    required this.canExpand,
  });
}
