import 'package:flutter/material.dart';

import '../../../constant/color_constants.dart';
import '../../../constant/string_constants.dart';
import '../../../utils/custom_extension.dart';
import '../../../widgets/common_elevated_button.dart';

class EditDescriptionPopup extends StatefulWidget {
  const EditDescriptionPopup({super.key});

  @override
  State<EditDescriptionPopup> createState() => _EditDescriptionPopupState();
}

class _EditDescriptionPopupState extends State<EditDescriptionPopup> {
  final TextEditingController headlineController = TextEditingController();
  final TextEditingController tenantsDescriptionController =
      TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier _updateNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 25, bottom: 30, right: 25),
      child: ValueListenableBuilder(
        valueListenable: _updateNotifier,
        builder: (context, value, child) => Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: autovalidateMode,
                validator: (value) => value?.emptyHeadline,
                decoration: const InputDecoration(
                  labelText: StaticString.headLine,
                ),
              ),
              const SizedBox(height: 35),
              TextFormField(
                autovalidateMode: autovalidateMode,
                validator: (value) => value?.emptyHeadline,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: StaticString.tenantDescription,
                ),
              ),
              const SizedBox(height: 25),
              CommonElevatedButton(
                color: ColorConstants.custPurple500472,
                bttnText: StaticString.update,
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    autovalidateMode = AutovalidateMode.always;
                    _updateNotifier.notifyListeners();
                    return;
                  } else {
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
