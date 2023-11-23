import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shimmer/shimmer.dart';

import '../constant/color_constants.dart';
import '../constant/img_constants.dart';
import '../utils/custom_extension.dart';
import '../widgets/custom_text.dart';

class CustImage extends StatelessWidget {
  final String imgURL;
  final double? height;
  final double? width;
  final double? cornerRadius;
  final String errorImage;
  final bool zoomablePhoto;
  final Color? backgroundColor;
  final Color? imgColor;
  final BoxFit boxfit;
  final String name;
  final Color? textColor;
  final EdgeInsets letterPadding;

  const CustImage({
    Key? key,
    this.imgURL = "",
    this.cornerRadius = 0,
    this.height,
    this.width,
    this.boxfit = BoxFit.cover,
    this.errorImage = ImgName.zugnuPlaceholder,
    this.zoomablePhoto = false,
    this.backgroundColor,
    this.imgColor,
    this.textColor,
    this.name = "",
    this.letterPadding = const EdgeInsets.all(8.0),
  }) : super(key: key);

  Widget defaultImg(BuildContext context) => name.isEmpty
      ? Image.asset(
          errorImage,
          color: imgColor,
          errorBuilder: (context, error, stackTrace) => Image.asset(
            errorImage,
            fit: BoxFit.cover,
            color: imgColor,
            height: height,
            width: width,
          ),
          fit: BoxFit.cover,
          height: height,
          width: width,
        )
      : userName(context);

  Widget userName(BuildContext context) => Padding(
        padding: letterPadding,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: CustomText(
            txtTitle: name.toFirstLetter,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: textColor ?? const Color(0xFF808080),
                ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Widget _image = defaultImg(context);
    if (imgURL.isNotEmpty) {
      // Check if Network image...
      if (imgURL.isNetworkImage) {
        _image =
            zoomablePhoto ? _buildZoomablePhoto(context) : _cacheImage(context);

        // Check if Asset image...
      } else if (isAssetImage(imgURL)) {
        _image = imgURL.contains(".svg")
            ? SvgPicture.asset(
                imgURL,
                color: imgColor,
                fit: boxfit,
                height: height,
                width: width,
              )
            : Image.asset(
                imgURL,
                height: height,
                width: width,
                color: imgColor,
                errorBuilder: (context, error, stackTrace) =>
                    defaultImg(context),
                fit: boxfit,
              );

        // Check if File image...
      } else if (isFileImage(imgURL)) {
        _image = Image.file(
          File(imgURL),
          height: height,
          width: width,
          color: imgColor,
          errorBuilder: (context, error, stackTrace) => defaultImg(context),
          fit: boxfit,
        );
      }
    } else if (name.trim().isNotEmpty) {
      _image = userName(context);
    }

    return Container(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: name.trim().isNotEmpty
            ? ColorConstants.custGrey7A7A7A.withOpacity(0.3)
            : backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(cornerRadius ?? 0.0),
        ),
      ),
      height: height,
      width: width,
      child: _image,
    );
  }

  Widget _cacheImage(BuildContext context) {
    return imgURL.contains(".svg")
        ? SvgPicture.network(
            imgURL,
            color: imgColor,
            fit: boxfit,
            height: height,
            width: width,
            placeholderBuilder: (context) => defaultImg(context),
          )
        : CachedNetworkImage(
            fit: boxfit,
            imageUrl: imgURL,
            height: height,
            width: width,
            color: imgColor,
            placeholder: (context, url) => shimmerWidget(),
            errorWidget: (ctx, url, obj) => defaultImg(context),
          );
  }

  Widget _buildZoomablePhoto(BuildContext context) {
    return PhotoViewGallery(
      pageOptions: [
        PhotoViewGalleryPageOptions(
          imageProvider: CachedNetworkImageProvider(
            imgURL,
          ),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
        )
      ],
      loadingBuilder: (context, url) => const CircularProgressIndicator(),
    );
  }

  Widget shimmerWidget() {
    return Shimmer.fromColors(
      baseColor: ColorConstants.custGrey7A7A7A.withOpacity(0.3),
      highlightColor: ColorConstants.custGrey707070.withOpacity(0.4),
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }

  bool isAssetImage(String url) => url.toLowerCase().contains(ImgName.imgPath);

  bool isFileImage(String url) => !isAssetImage(url);

  
}
