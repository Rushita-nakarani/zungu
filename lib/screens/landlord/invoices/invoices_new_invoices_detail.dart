import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';

import '../../../constant/img_font_color_string.dart';
import '../../../utils/cust_eums.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/image_upload_outlined_widget.dart';
import 'invoices_common_components.dart';
import 'log_payment_invoice_bottomsheet.dart';

class LandlordInvoicesNewInvoicesDetail extends StatefulWidget {
  const LandlordInvoicesNewInvoicesDetail({super.key});

  @override
  State<LandlordInvoicesNewInvoicesDetail> createState() =>
      _LandlordInvoicesNewInvoicesDetailState();
}

class _LandlordInvoicesNewInvoicesDetailState
    extends State<LandlordInvoicesNewInvoicesDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO : remove app bar
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.invoices,
        ),
        backgroundColor: ColorConstants.custPurple500472,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          sliderView(),
          const SizedBox(height: 18),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildJobIdNumber(jobId: "#YQ6CA040521"),
                buildInvoiceNumber(invoiceNumber: "#1CN4627"),
                buildDescription(
                  address: "121 Cowley Road Littlemore Oxford OX4 4PH",
                ),
                const SizedBox(height: 10),
                buildBath(
                  title: "Shower Leak",
                  date: "27 Jun 2021",
                ),
                const SizedBox(height: 10),
                buildTenantDescription(
                  description:
                      "Shower has a leak from the faucet, it seems like it is a washer which has deteriorated. The hose  also seems to be worn badly and will The hose  also seems to be worn badly and will",
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 30),
                buildPlumbingWithMoreDetail(
                  rating: "(3.5)",
                  amount: "236",
                  dateCompleted: "15 Oct 2021",
                ),
                const SizedBox(height: 40),
                const UploadMediaOutlinedWidget(
                  title: StaticString.viewInvoice,
                  userRole: UserRole.LANDLORD,
                  image: ImgName.landlordPdf,
                ),
                const SizedBox(height: 40),
                CommonElevatedButton(
                  bttnText: StaticString.logPayment,
                  color: ColorConstants.custRedD92727,
                  onPressed: () {
                    logPaymentInvoiceBottomSheet(
                      btnText: StaticString.logPayment,
                      title: "Invoice Payment",
                      primaryColor: ColorConstants.custBlue1EC0EF,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sliderView() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      itemCount: 5,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://assets-news.housing.com/news/wp-content/uploads/2022/04/07013406/ELEVATED-HOUSE-DESIGN-FEATURE-compressed.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 15,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ColorConstants.custRedFF0000.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: CustomText(
                  txtTitle: "Urgent",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.backgroundColorFFFFFF,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
