import 'dart:math' as math;

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../models/submit_property_detail_model.dart';
import '../../widgets/custom_text.dart';

class AddFloorPlanScreen extends StatefulWidget {
  final List<FloorPlan> floorList;
  const AddFloorPlanScreen({Key? key, this.floorList = const []})
      : super(key: key);

  @override
  State<AddFloorPlanScreen> createState() => _AddFloorPlanScreenState();
}

class _AddFloorPlanScreenState extends State<AddFloorPlanScreen> {
  final ValueNotifier _floorNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: _floorNotifier,
              builder: (context, val, child) {
                return GridView.builder(
                  itemCount: widget.floorList.length,
                  //add this line ---------<
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    childAspectRatio: 16 / 22,
                  ),
                  itemBuilder: (context, index) => _buildVideoCard(
                    index,
                  ),
                );
              },
            ),
            _buildUploadFloorPlanButton(
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard(int index) {
    return Column(
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
              padding: const EdgeInsets.all(16),
              child: const CustImage(
                imgURL: ImgName.landlordPdf,
                height: 100,
                width: 86,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  widget.floorList.removeAt(index);

                  _floorNotifier.notifyListeners();
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
          child: FittedBox(
            child: CustomText(
              txtTitle: widget.floorList[index].fileName,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    color: ColorConstants.custGrey707070,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildUploadFloorPlanButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 20),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          final FilePickerResult? _file = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['jpg', 'pdf', 'doc'],
          );

          if (_file != null) {
            widget.floorList.addAll(
              _file.files.map(
                (e) => FloorPlan(
                  fileName: e.name,
                  originalUrl: e.path ?? "",
                  type: e.extension ?? "",
                ),
              ),
            );

            _floorNotifier.notifyListeners();
          }
        },
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
                    txtTitle: StaticString.uploadFloorPlan,
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
                      imgURL: ImgName.landlordPdf,
                      width: 24,
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
        txtTitle: StaticString.floorPlan,
      ),
      backgroundColor: ColorConstants.custDarkPurple500472,
    );
  }
}
