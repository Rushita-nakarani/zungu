import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zungu_mobile/widgets/tenant.dart';

import '../../utils/custom_extension.dart';
import '../constant/color_constants.dart';
import '../constant/img_constants.dart';
import '../constant/string_constants.dart';
import 'custom_text.dart';

// ignore: always_declare_return_types
//typedef OnDelete();

class TenantForm extends StatefulWidget {
  TenantForm({
    super.key,
   required this.tenant,
    required this.onDelete,
    this.index,
    this.tenantAddressController,
    this.tenantMobileNumberController,
    this.tenantNameController,
  });

  int? index;
  final Tenants tenant;
  final Function() onDelete;
  final state = _TenantFormState();
 final TextEditingController? tenantNameController;
 final TextEditingController? tenantMobileNumberController;
 final TextEditingController? tenantAddressController;

  //final OnRemove remove;

  @override
  State<StatefulWidget> createState() => state;

  bool isValid() => state.validate();
  // List<TenantForm> users = [];
}

class _TenantFormState extends State<TenantForm> {
  //---------tenet form controller--------
  final TextEditingController tenantNameController = TextEditingController();
  final TextEditingController tenantMobileNumberController =
      TextEditingController();
  final TextEditingController tenantAddressController = TextEditingController();

  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // List<TenantForm> users = [];

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
                txtTitle: '${StaticString.tenant2} ${widget.index}',
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
        _buildTenantname("${StaticString.tenantName}*"),
        const SizedBox(
          height: 20,
        ),
        _buildTenantMobileNumber("${StaticString.tenantMobileNumber}*"),
        const SizedBox(
          height: 20,
        ),
        _buildTenantAddress("${StaticString.tenantCurrentAddress}*"),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  ///form validator
  bool validate() {
    final valid = _formKey.currentState!.validate();
    if (valid) _formKey.currentState!.save();
    return valid;
  }

//-----------Tenant Form TextFromField---------------
  TextFormField _buildTenantname(String lable) {
    return TextFormField(
      controller: tenantNameController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateYourName,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: commonInputdecoration(
        labletext: lable,
      ),
    );
  }

  TextFormField _buildTenantMobileNumber(String lable) {
    return TextFormField(
      controller: tenantMobileNumberController,
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

  TextFormField _buildTenantAddress(String lable) {
    return TextFormField(
      controller: tenantAddressController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.validateAddress,
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
      labelText: labletext,
    );
  }

  // ---------------------- Helper widgets ----------------------

  InputDecoration commonInputdecorationwithIcon({
    required String labletext,
    Widget? icon,
  }) {
    return InputDecoration(
      suffixIcon:
          icon, //IconButton(onPressed: () {}, icon: SvgPicture.asset(icon)),
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
      labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
            color: ColorConstants.custDarkBlue160935,
          ),
      floatingLabelStyle: Theme.of(context).textTheme.headline2?.copyWith(
            color: ColorConstants.custDarkBlue160935,
          ),
    );
  }
}
