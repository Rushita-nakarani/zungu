import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/models/tenant/previous_tenancy_fetch_model.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../../../cards/detail_action_card.dart';
import '../../../constant/img_font_color_string.dart';
import '../../../providers/tenantProvider/tenancy_provider.dart';

class TenantMyTenanciesPreviousTenancy extends StatefulWidget {
  const TenantMyTenanciesPreviousTenancy({super.key});

  @override
  State<TenantMyTenanciesPreviousTenancy> createState() =>
      _TenantMyTenanciesPreviousTenancyState();
}

class _TenantMyTenanciesPreviousTenancyState
    extends State<TenantMyTenanciesPreviousTenancy> {
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  List<String> tenantOperationImg = [
    ImgName.myPayments,
    ImgName.myLeases,
    ImgName.inventoryCheck,
    ImgName.damageReport,
  ];

  List<String> tenantOperationName = [
    StaticString.myPayments,
    StaticString.myLeases,
    StaticString.inventoryCheck,
    StaticString.damageReport,
  ];

  List navigationOntap = [
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold()
  ];
  @override
  void initState() {
    fetchPreviousTenancies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Consumer<TenanciesProvider>(
        builder: (context, tenancyPrevious, child) => tenancyPrevious
                .fetchPreviousTenantList.isEmpty
            ? Center(
                child: NoContentLabel(
                  title: StaticString.nodataFound,
                  onPress: () {
                    fetchPreviousTenancies();
                  },
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await Provider.of<TenanciesProvider>(context, listen: false)
                      .fetchPreviousTenancy(StaticString.statusENDED);
                },
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tenancyPrevious.fetchPreviousTenantList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PreviousTenancyCard(
                        tenancyPrevious.fetchPreviousTenantList[index],
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }

  Widget PreviousTenancyCard(
    FetchTenanciesModel fetchTenanciesModel,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 18, right: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustImage(
                imgURL: ImgName.tenantMapPointer,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        txtTitle: fetchTenanciesModel.fullAddress,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorConstants.custDarkPurple160935,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 5),
                      CustomText(
                        txtTitle:
                            "Rent Amount: £${fetchTenanciesModel.rentAmount}",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorConstants.custGrey707070,
                              fontWeight: FontWeight.w500,
                            ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
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
        ],
      ),
    );
  }

  Future<void> fetchPreviousTenancies() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      await Provider.of<TenanciesProvider>(context, listen: false)
          .fetchPreviousTenancy(StaticString.statusENDED);
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
