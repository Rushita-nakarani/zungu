// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/color_constants.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/providers/auth/auth_provider.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';
import 'package:zungu_mobile/widgets/scrollable_widget.dart';

import '../../utils/custom_extension.dart';

class DeleteAccountscreen extends StatefulWidget {
  const DeleteAccountscreen({super.key});

  @override
  State<DeleteAccountscreen> createState() => _DeleteAccountscreenState();
}

class _DeleteAccountscreenState extends State<DeleteAccountscreen> {
  //------------------------------- Variables-----------------------------//
  // AutoValidate mode
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  //Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //Delete Value Notifier
  final ValueNotifier _deleteNotifier = ValueNotifier(true);
  //Loading Indicator
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  @override
  void initState() {
    super.initState();
  }

  //------------------------------- UI-----------------------------//
  @override
  Widget build(BuildContext context) {
    return LoadingIndicator(
      loadingStatusNotifier: _loadingIndicatorNotifier,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildDeleteContent(context),
      ),
    );
  }

  //------------------------------- Widgets-----------------------------//
  //  appbar...
  AppBar _buildAppBar() {
    return AppBar(
      title: const CustomText(txtTitle: StaticString.deleteAccountt),
    );
  }

  //  Body...
  Widget _buildDeleteContent(BuildContext context) {
    return SafeArea(
      child: BuildScrollableWidget(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
        child: Column(
          children: [
            //Delete My Account Header Text
            const CustomTitleWithLine(
              title: StaticString.deletemyAccount,
              primaryColor: ColorConstants.custDarkBlue150934,
              secondaryColor: ColorConstants.custgreen19B445,
            ),
            const SizedBox(height: 15),

            //Delete Info Text
            commonDeleteText(deleteInfo: StaticString.deleteInfo),
            const SizedBox(height: 35),

            //Delete Type Word Text
            Center(
              child: commonDeleteText(
                deleteInfo: StaticString.deleteTypeWord,
                align: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),

            //Delete Text field
            ValueListenableBuilder(
              valueListenable: _deleteNotifier,
              builder: (context, value, child) => Form(
                autovalidateMode: autovalidateMode,
                key: _formKey,
                child: TextFormField(
                  autovalidateMode: autovalidateMode,
                  decoration: InputDecoration(
                    hintText: StaticString.delete.toUpperCase(),
                    labelText: StaticString.deleteType,
                  ),
                  validator: (value) => value?.validateEmptyDelete,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(height: MediaQuery.of(context).size.height / 5),

            //Delete elevated Button
            CommonElevatedButton(
              onPressed: () {
                deleteAccount();
              },
              bttnText: StaticString.delete,
              color: ColorConstants.custredFA1111,
            )
          ],
        ),
      ),
    );
  }

  // Common delete info text...
  Widget commonDeleteText({
    String? deleteInfo,
    TextAlign? align,
  }) {
    return CustomText(
      txtTitle: deleteInfo,
      align: align,
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorConstants.custGrey707070,
          ),
    );
  }

  //------------------------------- Helper function-----------------------------//

  //  Delete Account api call...
  Future<void> deleteAccount() async {
    try {
      if (!_formKey.currentState!.validate()) {
        autovalidateMode = AutovalidateMode.always;
        _deleteNotifier.notifyListeners();
        return;
      }
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );
      await Provider.of<AuthProvider>(context, listen: false).deleteUser();
      Navigator.of(context).pop();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
