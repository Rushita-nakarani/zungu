import 'package:flutter/material.dart';
import 'package:lazy_loading_list/lazy_loading_list.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/providers/landlord_provider.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../models/landloard/my_property_list_model.dart';
import '../../../../widgets/custom_text.dart';

class PropertyAddressSheet extends StatefulWidget {
  final List<String> categoryList;
  final Function(PropertiesList propertiesList) cardOntap;
  const PropertyAddressSheet({
    super.key,
    required this.cardOntap,
    required this.categoryList,
  });

  @override
  State<PropertyAddressSheet> createState() => _PropertyAddressSheetState();
}

class _PropertyAddressSheetState extends State<PropertyAddressSheet> {
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          // Close button and
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 5),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const CustImage(
                    imgURL: ImgName.closeIcon,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: CustomText(
                    align: TextAlign.center,
                    txtTitle: StaticString.propertyList,
                    style: Theme.of(context).textTheme.headline1?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _page = 1;
                await Provider.of<LandlordProvider>(context, listen: false)
                    .fetchPropertiesListData(
                  _page,
                  categoryIdList: widget.categoryList,
                );
              },
              child: SingleChildScrollView(
                // physics: const ClampingScrollPhysics(),
                child: Consumer<LandlordProvider>(
                  builder: (context, myPropertyListData, child) {
                    return myPropertyListData.myPropertyList.isEmpty
                        ? NoContentLabel(
                            title: StaticString.nodataFound,
                            onPress: () {
                              myPropertyListData.fetchPropertiesListData(
                                _page,
                                categoryIdList: widget.categoryList,
                              );
                            },
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.only(top: 20, bottom: 30),
                            itemCount: myPropertyListData.myPropertyList.length,
                            itemBuilder: (context, index) {
                              return LazyLoadingList(
                                index: index,
                                hasMore: myPropertyListData
                                        .propertiesListModel!.count >=
                                    myPropertyListData.myPropertyList.length,
                                loadMore: () async {
                                  _page++;
                                  await myPropertyListData
                                      .fetchPropertiesListData(
                                    _page,
                                    categoryIdList: widget.categoryList,
                                  );
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    widget.cardOntap(
                                      myPropertyListData.myPropertyList[index],
                                    );
                                  },
                                  child: _tenantDetailsCard(
                                    propertyList: myPropertyListData
                                        .myPropertyList[index],
                                  ),
                                ),
                              );
                            },
                          );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//  Tenant details card...
  Widget _tenantDetailsCard({
    required PropertiesList propertyList,
  }) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: propertyList.isDeleted
            ? Colors.white.withOpacity(0.60)
            : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
            blurRadius: 12,
          )
        ],
      ),
      child: Row(
        children: [
          // Tenant Person Image
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CustImage(
                    imgURL: propertyList
                                .propertyResourceDetail?.photos.isEmpty ??
                            false
                        ? ""
                        : propertyList.propertyResourceDetail?.photos.first ??
                            "",
                    height: 60,
                    width: 60,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: propertyList.isDeleted
                      ? ColorConstants.custGrey707070.withOpacity(0.60)
                      : null,
                ),
              ),
            ],
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                CustomText(
                  textOverflow: TextOverflow.ellipsis,
                  maxLine: 1,
                  txtTitle: propertyList.name,
                  style: Theme.of(context).textTheme.headline2?.copyWith(
                        color: propertyList.addressDetail?.isDeleted ?? false
                            ? ColorConstants.custBlack808080.withOpacity(0.30)
                            : ColorConstants.custDarkPurple150934,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                CustomText(
                  txtTitle: propertyList.addressDetail?.fullAddress,
                  textOverflow: TextOverflow.ellipsis,
                  maxLine: 1,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: propertyList.addressDetail?.isDeleted ?? false
                            ? ColorConstants.custBlack808080.withOpacity(0.30)
                            : ColorConstants.custGrey707070,
                      ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
