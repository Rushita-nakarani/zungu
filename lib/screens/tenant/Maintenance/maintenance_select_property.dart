import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/tenant/Maintenance/maintenance_home.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';

import '../../../../cards/property_card.dart';
import '../../../../main.dart';
import '../../../../widgets/common_searchbar.dart';
import '../../../../widgets/custom_text.dart';
import '../../../../widgets/rounded_lg_shape_widget.dart';


class MaintenanceSelectProperty extends StatefulWidget {
  const MaintenanceSelectProperty({super.key});

  @override
  State<MaintenanceSelectProperty> createState() => _MaintenanceSelectPropertyState();
}

class _MaintenanceSelectPropertyState extends State<MaintenanceSelectProperty> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autovalidateMode = AutovalidateMode.onUserInteraction;

  final TextEditingController _searchController = TextEditingController();

  final ValueNotifier _searchNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child:
          // full screen design
          _buildScaffold(),
    );
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.maintenance,
        ),
        backgroundColor: ColorConstants.custDarkPurple662851,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // _buildTopColor(),
              _buildTitle(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 110,
                    ),
                    buildCommonSearchBar(
                      context: context,
                      color: ColorConstants.custDarkPurple662851,
                      image: ImgName.landlordSearch,
                      title: StaticString.searchByProperty,
                      controller: _searchController,
                      searchFunc: _searchFunc,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ValueListenableBuilder(
                      valueListenable: _searchNotifier,
                      builder: (context, val, child) {
                        return _buildPropertyCard();
                      },
                    ),
                    // bottom space
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Backgroung circle Image
  Flex _buildTopColor() {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: Container(
            height: 1,
            decoration: const BoxDecoration(
              color: ColorConstants.custDarkPurple500472,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Column(
      children: const [
        // SizedBox(
        //   height: 40,
        // ),
        SizedBox(
          width: double.infinity,
          child: RoundedLgShapeWidget(
            color: ColorConstants.custDarkPurple662851,
            title: StaticString.selectProperty,
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyCard() {
    return FutureBuilder<List>(
      future: _getSamplePropertyData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              ...snapshot.data!.map((item) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (ctx) =>
                    //         const LandlordAddEditTenantRentDetailForm(),
                    //   ),
                    // );
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: const PropertyCard(
                      imageUrl:
                          "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                      propertyTitle: "24 Oxford Street",
                      propertySubtitle: "London Paddington SE1 4ER",
                      color: ColorConstants.custDarkPurple500472,
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 50),
            _buildSendCodeButton(),
         
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );

    // return const PropertyCard(
    //   imageUrl: "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    //   propertyTitle: "24 Oxford Street",
    //   propertySubtitle: "London Paddington SE1 4ER",
    // );
  }

  void _searchFunc() {
    if (_formKey.currentState?.validate() ?? true) {
      // Provider.of<PropertySearchProvider>(getContext, listen: false)
      //     .search(_searchController.text);
      // _searchNotifier.notifyListeners();
    } else {
      _autovalidateMode = AutovalidateMode.always;

      return;
    }
  }
  Widget _buildSendCodeButton() {
    return CommonElevatedButton(
      color: ColorConstants.custDarkYellow838500,
      bttnText: StaticString.selectThisProperty.toUpperCase(),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const TenantMaintenance(),
          ),
        );
      },
    );
  }
}

Future<List> _getSamplePropertyData() async {
  // await Future.delayed(const Duration(seconds: 1));
  return [
    1,
    2,
    3,
  ];
}

 