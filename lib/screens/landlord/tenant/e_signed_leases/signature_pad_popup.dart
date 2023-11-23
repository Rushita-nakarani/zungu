import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../providers/landlord/tenant/create_leases_provider.dart';
import '../../../../widgets/common_elevated_button.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/loading_indicator.dart';

class SignaturePadPopup extends StatefulWidget {
  final String leaseID;
  final String eSignType;
  final Function? onSubmit;
  const SignaturePadPopup({
    super.key,
    required this.leaseID,
    required this.eSignType,
    this.onSubmit,
  });

  @override
  State<SignaturePadPopup> createState() => _SignaturePadPopupState();
}

class _SignaturePadPopupState extends State<SignaturePadPopup> {
  String base64Image = "";
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: ColorConstants.custDarkBlue150934,
    exportBackgroundColor: Colors.white,
    exportPenColor: Colors.black,
  );
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();
  // Provider
  CreateLeasesProvider get leaseProvider =>
      Provider.of<CreateLeasesProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: DottedBorder(
            radius: const Radius.circular(10),
            color: ColorConstants.custGrey707070,
            borderType: BorderType.RRect,
            dashPattern: const [4, 2],
            strokeWidth: 1.5,
            child: Signature(
              controller: _controller,
              height: 200,
              width: 320,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Undo Icon Button
              IconButton(
                icon: const Icon(Icons.undo),
                color: ColorConstants.custPurple500472,
                onPressed: () {
                  if (mounted) {
                    setState(() => _controller.undo());
                  }
                },
              ),

              // Redo Icon Button
              IconButton(
                icon: const Icon(Icons.redo),
                color: ColorConstants.custPurple500472,
                onPressed: () {
                  if (mounted) {
                    setState(() => _controller.redo());
                  }
                },
              ),

              // Clear Icon Button
              IconButton(
                icon: const Icon(Icons.clear),
                color: ColorConstants.custPurple500472,
                onPressed: () {
                  if (mounted) {
                    setState(() => _controller.clear());
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: ValueListenableBuilder<LoadingStatus>(
            valueListenable: _loadingIndicatorNotifier.statusNotifier,
            builder: (context, value, child) => value == LoadingStatus.show
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.custDarkBlue150934,
                    ),
                  )
                : CommonElevatedButton(
                    bttnText: StaticString.submit,
                    color: ColorConstants.custBlue1EC0EF,
                    onPressed: () async {
                      await exportImage();
                    },
                  ),
          ),
        ),
      ],
    );
  }

  //-----------------------------Helper function--------------------------------//

  // Export Image
  Future<void> exportImage() async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('No content')));
      return;
    }

    final Uint8List? data = await _controller.toPngBytes();

    if (data != null) {
      await eSignLeaseUploadDoc(
        signImg: data,
        leaseDetailId: widget.leaseID,
        eSignType: widget.eSignType,
      );
    }
  }

  //ESignLease Upload Doc
  Future<void> eSignLeaseUploadDoc({
    required Uint8List signImg,
    required String leaseDetailId,
    required String eSignType,
  }) async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      String? path;
      final String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      if (Platform.isAndroid ||
          Platform.isIOS ||
          Platform.isLinux ||
          Platform.isWindows) {
        final Directory directory = await getApplicationSupportDirectory();
        path = directory.path;
      } else {
        path = await PathProviderPlatform.instance.getApplicationSupportPath();
      }
      final File file =
          File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName.png');
      await file.writeAsBytes(
        signImg,
      );
      await leaseProvider.eSignLease(
        signImage: file.path,
        leaseDetailId: leaseDetailId,
        eSignTypes: eSignType,
      );
      Navigator.of(context).pop();
      if (widget.onSubmit != null) widget.onSubmit!();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
