// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';

import '../../models/landloard/property_feature_model.dart';
import '../../providers/landlord_provider.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/common_widget.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/loading_indicator.dart';

class LandlordAddpropertyFeatureScreen extends StatelessWidget {
  final List<PropertyFeatureModel> addFeatureScreenModel;
  final List<PropertyFeatureModel> selectedFeature;
  final void Function(List<PropertyFeatureModel> propertyFeatureList) onPressed;
  LandlordAddpropertyFeatureScreen({
    Key? key,
    required this.addFeatureScreenModel,
    required this.onPressed,
    required this.selectedFeature,
  }) : super(key: key) {
    if (selectedFeature.isNotEmpty) {
      _addFeatureScreenModel = selectedFeature;
    } else {
      _addFeatureScreenModel = addFeatureScreenModel;
    }
    _initialNotifier.notifyListeners();
  }

  //-----------------------------Variables-----------------------------//
  final ValueNotifier _initialNotifier = ValueNotifier(true);

  // Value Notifier
  final ValueNotifier _valueNotifier = ValueNotifier(true);
  // Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  List<PropertyFeatureModel> _addFeatureScreenModel = [];

  //-----------------------------UI-----------------------------//

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  //-----------------------------Widget-----------------------------//

  //Appbar
  AppBar _buildAppBar() {
    return AppBar(
      title: const CustomText(
        txtTitle: StaticString.addProperty,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }

  // Body
  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () => keyBoardHieOntap(context),
      child: ValueListenableBuilder(
        valueListenable: _initialNotifier,
        builder: (context, lis, child) => Consumer<LandlordProvider>(
          builder: (context, val, child) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Features Card View
                      commonHeaderLable(
                        title: StaticString.features,
                        spaceBetween: 10,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _addFeatureScreenModel.length,
                          itemBuilder: (context, index) => _buildHeaderCard(
                            _addFeatureScreenModel[index],
                            context,
                          ),
                          separatorBuilder: (context, index) => Container(
                            height: 1,
                            color: ColorConstants.custLightGreyEBEAEA,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Submit Button Action
                      CommonElevatedButton(
                        bttnText: StaticString.submit,
                        onPressed: () => submitBtnAction(context),
                        fontSize: 14,
                        color: ColorConstants.custBlue1EC0EF,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // FEature Header Title Text and SubList Tile View
  Widget _buildHeaderCard(
    PropertyFeatureModel propertyFeatureModel,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          // Header Tile
          _buildHeaderTile(propertyFeatureModel, context),

          // SubList Tile View
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                _buildChildTile(propertyFeatureModel.child[index], context),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: ColorConstants.custLightGreyEBEAEA,
            ),
            itemCount: propertyFeatureModel.child.length,
          )
        ],
      ),
    );
  }

  // Features Title And Switch
  Widget _buildHeaderTile(
    PropertyFeatureModel propertyFeatureModel,
    BuildContext context,
  ) {
    return Row(
      children: [
        // Features Subtitle Text
        Expanded(
          child: CustomText(
            txtTitle: propertyFeatureModel.name,
            style: Theme.of(context).textTheme.headline2?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.custDarkBlue160935,
                ),
          ),
        ),

        // Swicth
        if (propertyFeatureModel.getShowSwitch)
          ValueListenableBuilder(
            valueListenable: _valueNotifier,
            builder: (context, val, child) {
              return Switch.adaptive(
                activeTrackColor: ColorConstants.custPurple500472,
                activeColor: ColorConstants.custDarkPurple500472,
                value: propertyFeatureModel.switchValue,
                onChanged: (val) {
                  propertyFeatureModel.switchValue = val;

                  _valueNotifier.notifyListeners();
                },
              );
            },
          )
        else
          const SizedBox(height: 48)
      ],
    );
  }

  // Feature subList Tile
  Widget _buildChildTile(
    PropertyFeatureElementModel propertyFeatureElementModel,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        top: 2,
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              txtTitle: propertyFeatureElementModel.name,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ),
          if (propertyFeatureElementModel.showSwitch)
            ValueListenableBuilder(
              valueListenable: _valueNotifier,
              builder: (context, val, child) {
                return Switch.adaptive(
                  activeColor: ColorConstants.custDarkPurple500472,
                  value: propertyFeatureElementModel.switchValue,
                  onChanged: (val) {
                    propertyFeatureElementModel.switchValue = val;

                    _valueNotifier.notifyListeners();
                  },
                );
              },
            )
          else
            const SizedBox(height: 48)
        ],
      ),
    );
  }

  //------------------------- Button action ------------------------//

  // Key Board  Hide On tap
  void keyBoardHieOntap(BuildContext context) {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  // Submit Button Action
  void submitBtnAction(BuildContext context) {
    for (final element in _addFeatureScreenModel) {
      if (element.child.any(
        (addFeature) => addFeature.switchValue,
      )) {
        element.switchValue = true;
      }
    }

    Navigator.of(context).pop();
    onPressed(_addFeatureScreenModel);
  }
}
