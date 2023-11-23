import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/landloard/active_leases_data_model.dart';
import 'package:zungu_mobile/providers/landlord/active_leaese_provider.dart';
import 'package:zungu_mobile/screens/landlord/tenant/active%20leases/active_leases_detail_screen.dart';
import 'package:zungu_mobile/utils/custom_extension.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../../../../models/landloard/attribute_info_model.dart';
import '../../../../widgets/custom_text.dart';
import 'active_leases_ filter_bottomsheet.dart';

class ActiveLeasesListingScreen extends StatefulWidget {
  const ActiveLeasesListingScreen({Key? key}) : super(key: key);

  @override
  State<ActiveLeasesListingScreen> createState() =>
      _ActiveLeasesListingScreenState();
}

class _ActiveLeasesListingScreenState extends State<ActiveLeasesListingScreen> {
  AttributeInfoModel? attributeInfoModel;
// Variables...
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();
// Provider...
  ActiveLeasesProvider get getActiveLeasesProvider =>
      Provider.of<ActiveLeasesProvider>(context, listen: false);

  @override
  void initState() {
    tenantActiveLeases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  //  Appbar...
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.custDarkPurple500472,
      title: const CustomText(
        txtTitle: StaticString.activeLeases,
      ),
      actions: [
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => ActiveLeasesFiltterBottomsheet(
                onItemSelect: (val) async {
                  // if (val != null) {
                  onSelectItemontapAction(val);
                  // }
                },
                selected: attributeInfoModel,
              ),
            );
          },
          icon: const CustImage(
            imgURL: ImgName.filter,
          ),
        )
      ],
    );
  }

// Body...
  Widget _buildBody() {
    return SafeArea(
      child: Consumer<ActiveLeasesProvider>(
        builder: (context, activeLeasesData, child) {
          return activeLeasesData.activeLeaseDataList.isEmpty
              ? NoContentLabel(
                  title: StaticString.nodataFound,
                  onPress: tenantActiveLeases,
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await getActiveLeasesProvider.tenantActiveLeases();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: activeLeasesData.activeLeaseDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          leasesListOnTapAction(
                            activeLeasesData
                                .activeLeaseDataList[index].propertyDetailId,
                          );
                        },
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Column(
                          children: [
                            Card(
                              shadowColor: ColorConstants.custGrey7A7A7A
                                  .withOpacity(0.2),
                              elevation: 5,
                              margin: const EdgeInsets.only(top: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.topLeft,
                                    children: [
                                      Hero(
                                        tag: "hero-lease$index",
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            child: CustImage(
                                              height: 200,
                                              width: double.infinity,
                                              imgURL: activeLeasesData
                                                  .activeLeaseDataList[index]
                                                  .photos
                                                  .first,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 5,
                                          horizontal: 15,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: (index * 25)
                                              .getExpiresColor
                                              .withOpacity(0.5),
                                        ),
                                        child: CustomText(
                                          txtTitle:
                                              "${StaticString.endingInDays}${activeLeasesData.activeLeaseDataList[index].expiresIn?.toString()} ${StaticString.days}"
                                                  .toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                top: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    txtTitle:
                                        "${activeLeasesData.activeLeaseDataList[index].address?.addressLine1} ${activeLeasesData.activeLeaseDataList[index].address?.addressLine2}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                  CustomText(
                                    txtTitle: activeLeasesData
                                        .activeLeaseDataList[index]
                                        .address
                                        ?.fullAddress,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: ColorConstants.custGrey707070,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(height: 25),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 15,
                                      bottom: 20,
                                      left: 5,
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        children: [
                                          _buildDateCard(
                                            StaticString.leaseStartDate,
                                            activeLeasesData
                                                    .activeLeaseDataList[index]
                                                    .startDate
                                                    ?.toMobileString ??
                                                "",
                                          ),
                                          // BuildDatecard ...
                                          _buildDateCard(
                                            StaticString.renewalDate,
                                            activeLeasesData
                                                    .activeLeaseDataList[index]
                                                    .renewalDate
                                                    ?.toMobileString ??
                                                "",
                                          ),
                                          // build Expires Card...
                                          _buildExpiersDayView(
                                            index,
                                            activeLeasesData
                                                .activeLeaseDataList[index],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }

  // Expires dayView...
  Widget _buildExpiersDayView(
    int index,
    ActiveLeaseDataModel activeLeaseDataModel,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: (index * 25).getExpiresColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),
        child: CustomText(
          align: TextAlign.center,
          txtTitle:
              "${StaticString.expires}\n${activeLeaseDataModel.expiresIn.toString()} ${StaticString.days}"
                  .toUpperCase(),
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }

  // DateCard...
  Widget _buildDateCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
            blurRadius: 7,
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustImage(
              imgURL: ImgName.commonCalendar,
              imgColor: ColorConstants.custDarkPurple500472,
              width: 20,
            ),
            const SizedBox(height: 5),
            CustomText(
              txtTitle: value,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            CustomText(
              txtTitle: title,
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custGrey6E6E6E,
                  ),
            )
          ],
        ),
      ),
    );
  }

  // Active leases list ontao action...
  void leasesListOnTapAction(
    String propertyDetailsId,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ActiveLeasesDetailScreen(
          propertyDetailId: propertyDetailsId,
        ),
      ),
    );
  }

  // tennat activeLeases...
  Future<void> tenantActiveLeases() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await getActiveLeasesProvider.tenantActiveLeases();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  // ActiveLeases fliter bottomsheet ontap...
  Future<void> onSelectItemontapAction(
      AttributeInfoModel? atributeModel,) async {
    try {
      Navigator.of(context).pop();
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      attributeInfoModel = atributeModel;

      String? endingValue = attributeInfoModel?.attributeValue;

      if (endingValue == "All"|| atributeModel==null) {
        await getActiveLeasesProvider.tenantActiveLeases();
      } else {
        if (endingValue?.isNotEmpty ?? false) {
          final List<String> endingonlyValue = endingValue?.split(" ") ?? [];

          endingValue = endingonlyValue[2];
          await getActiveLeasesProvider.tenantActiveLeases(
            endingValue: endingValue,
          );
        }
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
      if (mounted) {
        setState(() {});
      }
    }
  }
}
