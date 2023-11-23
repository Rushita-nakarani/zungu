import 'package:flutter/material.dart';

import '../constant/img_font_color_string.dart';
import '../services/pdf_viewer_service.dart';
import '../utils/cust_eums.dart';
import '../widgets/cust_image.dart';
import '../widgets/custom_text.dart';

class CustomLeaseCard extends StatefulWidget {
  const CustomLeaseCard({
    super.key,
    required this.title,
    required this.color,
    required this.image,
    required this.onTap,
    this.isSelected = false,
    required this.previewUrl,
    required this.colors,
  });

  final String title;
  final Color color;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;
  final String previewUrl;
  final Color colors;

  @override
  State<CustomLeaseCard> createState() => _CustomLeaseCardState();
}

class _CustomLeaseCardState extends State<CustomLeaseCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      onTap: () => {if (!widget.isSelected) widget.onTap()},
      child: Stack(
        children: [
          CustImage(
            imgURL: ImgName.tenancyCard,
            imgColor: widget.color,
            width: MediaQuery.of(context).size.width / 2.7,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2.7,
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        margin: const EdgeInsets.only(top: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstants.backgroundColorFFFFFF,
                        ),
                        child: CustImage(
                          imgURL: widget.image,
                          imgColor: widget.colors,
                        ),
                      ),
                    ),
                    // if (widget.isSelected)
                    //   const Icon(
                    //     Icons.check,
                    //     color: ColorConstants.custChartGreen,
                    //     size: 28,
                    //   )
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: CustomText(
                    txtTitle: widget.title,
                    maxLine: 3,
                    textOverflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custDarkPurple150934,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: CustomText(
                //     txtTitle: "View >",
                //     style: Theme.of(context).textTheme.bodyText1,
                //   ),
                // ),
              ],
            ),
          ),
          if (widget.isSelected)
            const Positioned(
              top: 0,
              right: 10,
              child: Icon(
                Icons.check,
                color: ColorConstants.custChartGreen,
                size: 28,
              ),
            )
          else
            Container(),
          Positioned(
            bottom: 18,
            right: 12,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => PDFViewerService(
                      pdfUrl: widget.previewUrl,
                      userRole: UserRole.LANDLORD,
                    ),
                  ),
                );
              },
              child: CustomText(
                txtTitle: "View >",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
