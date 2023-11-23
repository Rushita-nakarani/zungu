import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/models/submit_property_detail_model.dart';
import 'package:zungu_mobile/providers/landlord_provider.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../constant/color_constants.dart';
import '../../constant/string_constants.dart';
import '../../main.dart';
import '../../models/landloard/attribute_info_model.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/common_widget.dart';
import '../../widgets/custom_text.dart';

class ManageRoomsScreen extends StatelessWidget {
  final int numberOfRoom;
  final List<Room> facilitylist;
  final void Function(List<Room> rooms) onPressed;
  ManageRoomsScreen({
    required this.numberOfRoom,
    required this.facilitylist,
    required this.onPressed,
  }) {
    for (int i = 0; i < numberOfRoom; i++) {
      final Room _room = Room(
        name: "Room ${i + 1}",
      );
      final List<Room> _roomList =
          facilitylist.where((element) => element.name == _room.name).toList();
      if (_roomList.isNotEmpty) {
        _room.typeId = _roomList.first.typeId;
        _room.typeName = _roomList.first.typeName;
      }
      _listOfFacilityModel.add(_room);
    }

    _listOfAttributeInfoModel =
        Provider.of<LandlordProvider>(getContext, listen: false)
            .getAttributeList;

    _initialNotifier.notifyListeners();
  }

  // int numberOfRoom = 3;

  final List<Room> _listOfFacilityModel = [];

  List<AttributeInfoModel> _listOfAttributeInfoModel = [];

  final ValueNotifier _valueNotifier = ValueNotifier(true);

  final ValueNotifier _initialNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ValueListenableBuilder(
        valueListenable: _initialNotifier,
        builder: (context, val, child) {
          return _listOfAttributeInfoModel.isEmpty
              ? CustomText(
                  txtTitle: StaticString.noAttributeAvailable,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.custGrey707070,
                      ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopCard(context),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              _buildRoomEquipementCard(
                            index,
                          ),
                          itemCount: _listOfFacilityModel.length,
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        CommonElevatedButton(
                          bttnText: StaticString.submit,
                          onPressed: () {
                            _listOfFacilityModel.removeWhere(
                              (element) => element.typeId.isEmpty,
                            );
                            Navigator.of(context).pop();
                            onPressed(_listOfFacilityModel);
                          },
                          color: ColorConstants.custBlue1EC0EF,
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget _buildTopCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.custLightBlueF5F9FA,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 10,
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: const CustImage(
              imgURL: ImgName.commonInformation,
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: CustomText(
              txtTitle: StaticString.whyNotGiveYour,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          )
        ],
      ),
    );
  }

  // property type selection content
  Widget _buildRoomEquipementCard(int index) {
    return ValueListenableBuilder(
      valueListenable: _valueNotifier,
      builder: (context, val, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: commonHeaderLable(
            title: "${StaticString.room} ${index + 1}",
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                _listOfAttributeInfoModel.length,
                (index1) => InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    if ((_listOfFacilityModel[index].typeName ==
                            _listOfAttributeInfoModel[index1].attributeValue) &&
                        (_listOfFacilityModel[index].typeId ==
                            _listOfAttributeInfoModel[index1].id)) {
                      _listOfFacilityModel[index].typeName = "";
                      _listOfFacilityModel[index].typeId = "";
                    } else {
                      _listOfFacilityModel[index].typeName =
                          _listOfAttributeInfoModel[index1].attributeValue;
                      _listOfFacilityModel[index].typeId =
                          _listOfAttributeInfoModel[index1].id;
                    }
                    _valueNotifier.notifyListeners();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: _listOfFacilityModel[index].typeName ==
                              _listOfAttributeInfoModel[index1].attributeValue
                          ? ColorConstants.custBlue1EC0EF
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: CustomText(
                      txtTitle:
                          _listOfAttributeInfoModel[index1].attributeValue,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: _listOfFacilityModel[index].typeName ==
                                    _listOfAttributeInfoModel[index1]
                                        .attributeValue
                                ? Colors.white
                                : ColorConstants.custGrey707070,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // App bar ...
  AppBar _buildAppBar() {
    return AppBar(
      title: const CustomText(
        txtTitle: StaticString.manageRooms,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }
}
