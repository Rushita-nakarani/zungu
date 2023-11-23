import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../constant/img_font_color_string.dart';
import '../utils/cust_eums.dart';
import 'cust_image.dart';
import 'custom_text.dart';
import 'image_picker_button.dart';

class UploadMediaOutlinedWidget extends StatefulWidget {
  const UploadMediaOutlinedWidget({
    super.key,
    required this.title,
    required this.image,
    required this.userRole,
    this.prefillImages = const [],
    this.showOptional = true,
    this.onSelectImg,
    this.maxImages = 6,
    this.onTap,
    this.onRemove,
  });
  final String title;
  final UserRole userRole;
  final String image;
  final bool showOptional;
  final List<String> prefillImages;
  final int maxImages;
  final void Function(List<String>)? onSelectImg;
  final void Function(String)? onRemove;
  final VoidCallback?
      onTap; // set ontap if wants to view or do anything not selecting

  @override
  State<UploadMediaOutlinedWidget> createState() =>
      _UploadMediaOutlinedWidgetState();
}

class _UploadMediaOutlinedWidgetState extends State<UploadMediaOutlinedWidget> {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      dashPattern: const [3, 3],
      strokeWidth: 2,
      strokeCap: StrokeCap.round,
      color: ColorConstants.custGreyb4bfd8,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: widget.onTap == null
            ? _buildWidgetChild()
            : InkWell(
                onTap: widget.onTap,
                child: _buildWidgetChild(),
              ),
      ),
    );
  }

  Widget _buildWidgetChild() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      color: ColorConstants.custWhiteFAFCFF,
      child: widget.prefillImages.isEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      txtTitle: widget.title,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorConstants.custDarkPurple150934,
                          ),
                    ),
                    if (widget.showOptional)
                      CustomText(
                        txtTitle: StaticString.optional,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorConstants.custDarkPurple150934,
                            ),
                      )
                  ],
                ),
                pickMedia(
                  image: widget.image,
                  images: widget.prefillImages,
                ),
              ],
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.prefillImages.length < widget.maxImages
                  ? widget.prefillImages.length + 1
                  : widget.prefillImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (widget.prefillImages.length == index) {
                  return pickMedia(
                    image: widget.image,
                    images: widget.prefillImages,
                  );
                }
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustImage(
                        imgURL: widget.prefillImages[index],
                        cornerRadius: 10,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              if (widget.onRemove != null) {
                                widget.onRemove!(widget.prefillImages[index]);
                              }
                              widget.prefillImages.removeAt(index);
                            });
                          }
                        },
                        child: CustImage(
                          imgURL: widget.userRole == UserRole.LANDLORD
                              ? ImgName.landlordCross
                              : widget.userRole == UserRole.TENANT
                                  ? ImgName.tenantCross
                                  : ImgName.tradesmanCross,
                          width: 18,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }

  Widget pickMedia({
    required String image,
    required List<String> images,
  }) {
    return widget.onTap == null
        ? ImagePickerButton(
            onImageSelected: (selectedImages) {
              if (mounted) {
                setState(() {
                  widget.prefillImages.addAll(selectedImages);
                });
              }
              if (widget.onSelectImg != null) {
                // ignore: prefer_null_aware_method_calls
                widget.onSelectImg!(widget.prefillImages);
              }
            },
            child: _buildPreviewMediaChild(image: image),
          )
        : _buildPreviewMediaChild(image: image);
  }

  Widget _buildPreviewMediaChild({
    required String image,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      // margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorConstants.backgroundColorFFFFFF,
        border: Border.all(
          color: ColorConstants.custLightGreyEBEAEA,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustImage(
        imgURL: image,
        boxfit: BoxFit.contain,
        width: 36,
        height: 36,
      ),
    );
  }
}
