import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

import '../../../../utils/custom_extension.dart';
import '../constant/img_font_color_string.dart';
import '../utils/cust_eums.dart';

class PDFViewerService extends StatefulWidget {
  final UserRole userRole;
  final Function()? nextBtnAction;
  const PDFViewerService({
    super.key,
    required this.pdfUrl,
    this.nextBtnAction,
    required this.userRole,
  });

  final String pdfUrl;

  @override
  State<PDFViewerService> createState() => _PDFViewerServiceState();
}

class _PDFViewerServiceState extends State<PDFViewerService> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final ValueNotifier _pdfNotifier = ValueNotifier(true);

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: widget.nextBtnAction == null
          ? null
          : InkWell(
              onTap: widget.nextBtnAction,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.custDarkBlue150934,
                ),
                child: const Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: widget.userRole == UserRole.LANDLORD
          ? ColorConstants.custDarkPurple500472
          : widget.userRole == UserRole.TENANT
              ? ColorConstants.custDarkPurple662851
              : ColorConstants.custDarkTeal017781,
      title: const CustomText(txtTitle: StaticString.leaseDocument),
      actions: widget.pdfUrl.isNetworkPdf
          ? <Widget>[
              Center(
                child: ValueListenableBuilder(
                  valueListenable: _pdfNotifier,
                  builder: (context, val, child) {
                    return CustomText(
                      txtTitle:
                          '${_pdfViewerController.pageNumber} / ${_pdfViewerController.pageCount}',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: Colors.white,
                          ),
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
                onPressed: () {
                  _pdfViewerController.previousPage();
                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                onPressed: () {
                  _pdfViewerController.nextPage();
                },
              ),
            ]
          : [],
    );
  }

  Widget _buildBody() {
    if (widget.pdfUrl.isEmpty) {
      return Center(
        child: CustomText(
          txtTitle: "NO URL PROVIDED".toUpperCase(),
          style: Theme.of(context).textTheme.headline4,
        ),
      );
    }
    if (widget.pdfUrl.isNetworkPdf) {
      return SfPdfViewer.network(
        widget.pdfUrl,
        controller: _pdfViewerController,
        onPageChanged: onPageChanged,
      );
    } else {
      return PhotoView(
        imageProvider: CachedNetworkImageProvider(widget.pdfUrl),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
      );
    }
  }

  void onPageChanged(PdfPageChangedDetails details) {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    _pdfNotifier.notifyListeners();
  }
}
