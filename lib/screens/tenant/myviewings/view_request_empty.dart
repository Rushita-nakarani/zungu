import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class ViewingRequestsEmptyScreen extends StatefulWidget {
  const ViewingRequestsEmptyScreen({super.key});

  @override
  State<ViewingRequestsEmptyScreen> createState() =>
      _ViewingRequestsEmptyScreenState();
}

class _ViewingRequestsEmptyScreenState
    extends State<ViewingRequestsEmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.myViewings,
        ),
        backgroundColor: ColorConstants.custDarkPurple662851,
      ),
      body: SafeArea(child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 38),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorConstants.custWhiteFFFFFF,
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.custGrey7A7A7A.withOpacity(0.3),
                  blurRadius: 7,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const CustImage(
                  cornerRadius: 12,
                  imgURL: ImgName.confirmedview,
                ),
                const SizedBox(height: 30),
                CustomText(
                  align: TextAlign.center,
                  txtTitle: StaticString.emptyViewingsPage,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custLightGreyD1D3D4,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
