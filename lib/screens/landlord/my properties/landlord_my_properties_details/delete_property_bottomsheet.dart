// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';

import '../../../../constant/color_constants.dart';
import '../../../../constant/string_constants.dart';
import '../../../../utils/custom_extension.dart';
import '../../../../widgets/custom_alert.dart';
import '../../../../widgets/custom_text.dart';

class DeletePropertyScreen extends StatefulWidget {
  final void Function() onDelete;
  const DeletePropertyScreen({super.key, required this.onDelete});

  @override
  State<DeletePropertyScreen> createState() => _DeletePropertyScreenState();
}

class _DeletePropertyScreenState extends State<DeletePropertyScreen> {
  final TextEditingController _deleteController = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier _deleteNotifier = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return _buildDeleteContent();
  }

  Widget _buildDeleteContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(
              txtTitle: StaticString.deletePropertysubtitle,
              align: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: ColorConstants.custGrey707070,
                  ),
            ),
          ),
          const SizedBox(height: 35),
          ValueListenableBuilder(
            valueListenable: _deleteNotifier,
            builder: (context, value, child) => Form(
              autovalidateMode: autovalidateMode,
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: _deleteController,
                  autovalidateMode: autovalidateMode,
                  decoration: InputDecoration(
                    hintText: StaticString.delete.toUpperCase(),
                    labelText: StaticString.typeDeleteHere,
                  ),
                  validator: (value) => value?.validateEmptyDelete,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(
                        color: ColorConstants.custGrey707070,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          35.0,
                        ),
                      ),
                    ),
                    child: CustomText(
                      txtTitle: StaticString.cancel.toUpperCase(),
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorConstants.custGrey707070,
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      deleteAccount();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(
                        color: ColorConstants.custRedD92A2A,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          35.0,
                        ),
                      ),
                    ),
                    child: CustomText(
                      txtTitle: StaticString.delete1,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorConstants.custRedD92A2A,
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> deleteAccount() async {
    try {
      if (!_formKey.currentState!.validate()) {
        autovalidateMode = AutovalidateMode.always;
        _deleteNotifier.notifyListeners();
        return;
      }
      Navigator.of(context).pop();
      widget.onDelete();
    } catch (e) {
      showAlert(context: context, message: e);
    }
  }
}
