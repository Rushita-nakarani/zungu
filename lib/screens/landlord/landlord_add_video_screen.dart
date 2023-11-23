import 'dart:math' as math;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/image_picker_button.dart';

import '../../widgets/custom_text.dart';

class AddPropertyVideoScreen extends StatefulWidget {
  final List<String> videoList;
  const AddPropertyVideoScreen({Key? key,this.videoList = const []}) : super(key: key);

  @override
  State<AddPropertyVideoScreen> createState() => _AddPropertyVideoScreenState();
}

class _AddPropertyVideoScreenState extends State<AddPropertyVideoScreen> {


  final ValueNotifier _videoNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: _videoNotifier,
              builder: (context, val, child) {
                return GridView.builder(
                  itemCount: widget.videoList.length,
                  //add this line ---------<
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    childAspectRatio: 16 / 21,
                  ),
                  itemBuilder: (context, index) => _videoThumbNail(index),
                );
              },
            ),
            _buildUploadVideoButton(),
          ],
        ),
      ),
    );
  }

  Widget _videoThumbNail(int index) {
    return FutureBuilder<Uint8List?>(
      future: VideoThumbnail.thumbnailData(
        video: widget.videoList[index],
        imageFormat: ImageFormat.JPEG,
        quality: 20,
      ),
      builder: (ctx, imageData) {
        Widget child = const CustImage();
        if (imageData.hasData && imageData.data != null) {
          child = true
              ? _buildVideoCard(index, imageData.data)
              : InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {},
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.memory(
                      imageData.data!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
        } else if (imageData.hasError) {
          child =
              true ? _buildVideoCard(index, imageData.data) : const CustImage();
        } else {
          child = const Center(
            child: CircularProgressIndicator(
              color: Color(0xffF54768),
            ),
          );
        }
        return child;
      },
    );
  }

  Widget _buildVideoCard(int index, Uint8List? data) {
    return FittedBox(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10, top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: ColorConstants.custGreyEBEAEA,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 38,
                  horizontal: 32,
                ),
                child: Image.memory(
                  data!,
                  height: 140,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    widget.videoList.removeAt(index);

                    _videoNotifier.notifyListeners();
                  },
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: ColorConstants.custDarkBlue150934,
                    ),
                    child: Transform.rotate(
                      angle: -math.pi / 4.0,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CustomText(
              txtTitle: StaticString.video,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUploadVideoButton() {
    return VideoPickerButton(
      onVideoSelected: (video) {
        debugPrint(video);
        if (video.isNotEmpty) {
          widget.videoList.add(video);
        }

        _videoNotifier.notifyListeners();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: DottedBorder(
          borderType: BorderType.RRect,
          dashPattern: const [3, 3],
          strokeWidth: 2,
          strokeCap: StrokeCap.round,
          radius: const Radius.circular(12),
          color: ColorConstants.custGreyb4bfd8,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
              height: 85,
              width: double.infinity,
              color: const Color(0xFFFAFCFF),
              padding: const EdgeInsets.only(left: 24, right: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    txtTitle: StaticString.uploadVideo,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ColorConstants.custGrey707070,
                        ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                    ),
                    child: const CustImage(
                      imgURL: ImgName.uploadVideo,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // App bar ...
  AppBar _buildAppBar() {
    return AppBar(
      title: const CustomText(
        txtTitle: "Video",
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }
}
