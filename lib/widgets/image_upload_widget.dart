import 'package:flutter/material.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';

import '../constant/img_font_color_string.dart';
import 'cust_image.dart';
import 'image_picker_button.dart';

class UploadMediaWidget extends StatefulWidget {
  const UploadMediaWidget({
    super.key,
    required this.image,
    required this.userRole,
    this.maxUpload = 6,
    this.color,
    required this.imageList,
    this.multipicker = false,
    required this.images,
    this.removeFunc,
  });
  final String image;
  final Color? color;
  final UserRole userRole;
  final int maxUpload;
  final bool multipicker;
  final List<String> images;
  final Function(List<String>) imageList;
  final Function(String)? removeFunc;

  @override
  State<UploadMediaWidget> createState() => _UploadMediaWidgetState();
}

class _UploadMediaWidgetState extends State<UploadMediaWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.images.isEmpty
          ? pickMedia(
              isSmall: false,
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.images.length < widget.maxUpload
                  ? widget.images.length + 1
                  : widget.images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (widget.images.length == index) {
                  return pickMedia();
                }
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustImage(
                        imgURL: widget.images[index],
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
                              if (widget.removeFunc != null) {
                                widget.removeFunc!(widget.images[index]);
                              }
                              widget.images.removeAt(index);
                            });
                          }
                        },
                        child: CustImage(
                          imgURL: widget.userRole == UserRole.LANDLORD
                              ? ImgName.landlordCross
                              : widget.userRole == UserRole.TENANT
                                  ? ImgName.tenantCross
                                  : ImgName.tradesmanCross,
                          width: 24,
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
    bool isSmall = true,
  }) {
    return ImagePickerButton(
      multipicker: widget.multipicker,
      onImageSelected: (selectedImages) {
        if (mounted) {
          setState(() {
            widget.images.addAll(selectedImages);
          });
        }

        widget.imageList(widget.images);
      },
      child: FittedBox(
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: isSmall ? const EdgeInsets.all(8) : EdgeInsets.zero,
          decoration: BoxDecoration(
            color: ColorConstants.backgroundColorFFFFFF,
            border: Border.all(
              color: ColorConstants.custLightGreyEBEAEA,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustImage(
            boxfit: BoxFit.contain,
            imgURL: widget.image,
            imgColor: widget.color,
            width: 48,
            height: 48,
          ),
        ),
      ),
    );
  }
}
