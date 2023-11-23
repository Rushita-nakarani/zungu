import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_constants.dart';
import 'package:zungu_mobile/widgets/common_widget.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../constant/color_constants.dart';
import '../../constant/string_constants.dart';
import '../../models/property_view_day_model.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/custom_text.dart';

class PropertyViewingTimesScreen extends StatelessWidget {
  PropertyViewingTimesScreen({Key? key}) : super(key: key);

  final List<PropertyViewDayModel> _propertViewDetailList =
      listOfPropertyViewDayModelFromJson(
    json.encode(
      dummyPropertyData,
    ),
  );

  final ValueNotifier _dayOnOffNotifier = ValueNotifier(true);
  final ValueNotifier _startTimeNotifier = ValueNotifier(true);
  final ValueNotifier _endTimeNotifier = ValueNotifier(true);
  final ValueNotifier _timeDurationNotifier = ValueNotifier(true);

  String selectedMinDuration = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const SizedBox(height: 18),
              commonHeaderLable(
                title: StaticString.allocatedTimes,
                spaceBetween: 32,
                child: _buildtimeAllocatedCard(context),
              ),
              const SizedBox(
                height: 42,
              ),
              commonHeaderLable(
                title: StaticString.setViewingTimes,
                child: _buildSetViewingMethodCard(context),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: CommonElevatedButton(
                      bttnText: StaticString.back,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      fontSize: 14,
                      side: MaterialStateProperty.all(
                        const BorderSide(
                          color: ColorConstants.custLightGreyD1D3D4,
                        ),
                      ),
                      textColor: ColorConstants.custGrey707070,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CommonElevatedButton(
                      bttnText: StaticString.save,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      fontSize: 14,
                      color: ColorConstants.custBlue1EC0EF,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSetViewingMethodCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
            blurRadius: 12,
          ),
        ],
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(top: 24, bottom: 10),
          height: 1,
          color: ColorConstants.custGreyEBEAEA,
        ),
        itemCount: _propertViewDetailList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildDayCard(
          context,
          propertyViewDayModel: _propertViewDetailList[index],
        ),
      ),
    );
  }

  Widget _buildDayCard(
    BuildContext context, {
    required PropertyViewDayModel propertyViewDayModel,
  }) {
    return Column(
      children: [
        _buildDayWithSwitchTile(
          context,
          propertyViewDayModel: propertyViewDayModel,
        ),
        const SizedBox(
          height: 10,
        ),
        _buildMorningEveningRow(
          context,
          timeModel: propertyViewDayModel.timeModel[0],
        ),
        const SizedBox(
          height: 20,
        ),
        _buildMorningEveningRow(
          context,
          timeModel: propertyViewDayModel.timeModel[1],
          isMorning: false,
        ),
      ],
    );
  }

  Widget _buildMorningEveningRow(
    BuildContext context, {
    bool isMorning = true,
    required TimeModel timeModel,
  }) {
    return Row(
      children: [
        CustomText(
          txtTitle: timeModel.timeSlote,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: ColorConstants.custGrey707070,
                fontWeight: FontWeight.w500,
              ),
        ),
        const Spacer(),
        InkWell(
          onTap: () async {
            final TimeOfDay? _selectedStartTme = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (_selectedStartTme != null) {
              timeModel.startTime =
                  "${_selectedStartTme.hour}:${_selectedStartTme.minute}";
            }

            // TimeOfDay? endTime = _selectedStartTme?.replacing(
            //   hour: _selectedStartTme.hour,
            //   minute: _selectedStartTme.minute + int.parse(selectedMinDuration),
            // );

            // if (endTime != null) {
            //   timeModel.endTime = "${endTime.hour}:${endTime.minute}";
            // }

            _startTimeNotifier.notifyListeners();
          },
          child: ValueListenableBuilder(
            valueListenable: _startTimeNotifier,
            builder: (context, val, child) {
              return _timeContainer(
                context,
                time: timeModel.startTime,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomText(
            txtTitle: "-",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        InkWell(
          onTap: () async {
            final TimeOfDay? _selectedStartTme = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );

            if (_selectedStartTme != null) {
              timeModel.endTime =
                  "${_selectedStartTme.hour}:${_selectedStartTme.minute}";
            }

            _endTimeNotifier.notifyListeners();
          },
          child: ValueListenableBuilder(
            valueListenable: _endTimeNotifier,
            builder: (context, val, child) {
              return _timeContainer(
                context,
                time: timeModel.endTime,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _timeContainer(BuildContext context, {required String time}) {
    return Container(
      alignment: Alignment.center,
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          5,
        ),
        border: Border.all(
          color: ColorConstants.custLightGreyD1D3D4,
        ),
      ),
      child: Row(
        children: [
          const CustImage(
            imgURL: ImgName.watch,
            height: 18,
            width: 18,
          ),
          const SizedBox(
            width: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: CustomText(
              txtTitle: time,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w500,
                  ),
              align: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayWithSwitchTile(
    BuildContext context, {
    required PropertyViewDayModel propertyViewDayModel,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          txtTitle: propertyViewDayModel.day,
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorConstants.custDarkBlue150934,
              ),
        ),
        ValueListenableBuilder(
          valueListenable: _dayOnOffNotifier,
          builder: (context, val, child) {
            return Switch(
              activeColor: ColorConstants.custDarkPurple500472,
              value: propertyViewDayModel.enableDay,
              onChanged: (val) {
                propertyViewDayModel.enableDay = val;

                _dayOnOffNotifier.notifyListeners();
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildtimeAllocatedCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.2),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            txtTitle: StaticString.timesAllocatedForEach,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.custGrey707070,
                ),
          ),
          const SizedBox(
            height: 22,
          ),
          ValueListenableBuilder(
            valueListenable: _timeDurationNotifier,
            builder: (context, val, child) {
              return SizedBox(
                height: 60,
                child: Row(
                  children: [
                    _buidTimeDurationCard(context, time: "15"),
                    const SizedBox(
                      width: 16,
                    ),
                    _buidTimeDurationCard(context, time: "30"),
                    const SizedBox(
                      width: 16,
                    ),
                    _buidTimeDurationCard(context, time: "45"),
                    const SizedBox(
                      width: 16,
                    ),
                    _buidTimeDurationCard(context, time: "60"),
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 22,
          ),
        ],
      ),
    );
  }

  Widget _buidTimeDurationCard(BuildContext context, {required String time}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          selectedMinDuration = time;

          _timeDurationNotifier.notifyListeners();
        },
        child: Container(
          decoration: BoxDecoration(
            color: time == selectedMinDuration
                ? ColorConstants.custBlue1BC4F4
                : ColorConstants.custGreyF7F7F7,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: time == selectedMinDuration
                  ? ColorConstants.custBlue1BC4F4
                  : ColorConstants.custLightGreyD1D3D4,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                txtTitle: time,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: time == selectedMinDuration
                          ? Colors.white
                          : ColorConstants.custBlue1BC4F4,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
              ),
              CustomText(
                txtTitle: "min",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: time == selectedMinDuration
                          ? Colors.white
                          : ColorConstants.custBlue1BC4F4,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // App bar ...
  AppBar _buildAppBar() {
    return AppBar(
      title: const CustomText(
        txtTitle: StaticString.generalSettings,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }
}
