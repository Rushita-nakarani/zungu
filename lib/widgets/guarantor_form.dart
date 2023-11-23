import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zungu_mobile/models/landloard/create_lease_model.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/guarantor.dart';

import '../../utils/custom_extension.dart';
import '../constant/color_constants.dart';
import '../constant/img_constants.dart';
import '../constant/string_constants.dart';

// ignore: always_declare_return_types
typedef OnDelete = Function();

class GuarantorForm extends StatefulWidget {
  final Guarantor guarantorUser;
  final state = _GuarantorFormState();
  final OnDelete onDelete;
  int index;
  final TextEditingController? guarantorNameController;
  final TextEditingController? guarantorMobileNumberController;
  final TextEditingController? guarantorAddressController;

  GuarantorForm({
    super.key,
    required this.guarantorUser,
    required this.onDelete,
    required this.index,
    this.guarantorAddressController,
    this.guarantorMobileNumberController,
    this.guarantorNameController,
  });
  // final Tenant user;
  // final state = _TenantFormState();
  // final OnDelete onDelete;
  // //final OnRemove remove;
  // TenantForm({super.key, required this.user, required this.onDelete});

  @override
  State<GuarantorForm> createState() => _GuarantorFormState();
  bool isValid() => _GuarantorFormState().validate();
}

class _GuarantorFormState extends State<GuarantorForm> {
  // final TextEditingController guarantorNameController = TextEditingController();
  // final TextEditingController guarantorMobileNumberController =
  //     TextEditingController();
  // final TextEditingController guarantorAddressController =
  //     TextEditingController();

  final form = GlobalKey<FormState>();

  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        if (widget.index == 1)
          Container()
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtTitle: "${StaticString.guarantor} ${widget.index}",
                style: const TextStyle(
                  color: ColorConstants.custBlue2AC4EF,
                ),
              ),
              IconButton(
                onPressed: widget.onDelete,
                //onRemoveForm,
                icon: SvgPicture.asset(ImgName.delete),
              )
            ],
          ),
        const SizedBox(
          height: 10,
        ),
        _buildGuarantorname(StaticString.guarantorName),
        const SizedBox(
          height: 20,
        ),
        _buildGuarantorMobileNumber(StaticString.guarantorMobileNumber),
        const SizedBox(
          height: 20,
        ),
        _buildGuarantorAddress(StaticString.guarantorCurrentAddress)
      ],
    );
  }

  ///form validator
  bool validate() {
    final valid = form.currentState!.validate();
    if (valid) form.currentState!.save();
    return valid;
  }

  TextFormField _buildGuarantorname(String lable) {
    return TextFormField(
      controller: widget.guarantorNameController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateYourName,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: commonInputdecoration(
        labletext: lable,
      ),
    );
  }

  TextFormField _buildGuarantorMobileNumber(String lable) {
    return TextFormField(
      controller: widget.guarantorMobileNumberController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validatePhoneNumber,
      keyboardType: TextInputType.phone,
      maxLength: 10,
      textInputAction: TextInputAction.next,
      decoration: commonInputdecoration(
        labletext: lable,
      ),
    );
  }

  TextFormField _buildGuarantorAddress(String lable) {
    return TextFormField(
      controller: widget.guarantorAddressController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateYourName,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: commonInputdecoration(
        labletext: lable,
      ),
    );
  }

  // ---------------------- Helper widgets ----------------------

  InputDecoration commonInputdecoration({required String labletext}) {
    return InputDecoration(
      counterText: "",
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstants.borderColorACB4B0,
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorConstants.borderColorACB4B0,
        ),
      ),
      labelText: labletext,
      labelStyle: const TextStyle(
        fontSize: 16,
        color: ColorConstants.custDarkBlue160935,
      ),
      floatingLabelStyle: const TextStyle(
        fontSize: 20,
        color: ColorConstants.custDarkBlue160935,
      ),
    );
  }
}
