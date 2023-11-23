import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/models/settings/personal_profile/contact_us_attribute_model.dart';
import 'package:zungu_mobile/providers/auth/personal_profile_provider/personal_provider.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../../utils/custom_extension.dart';
import '../../widgets/common_elevated_button.dart';
import '../../widgets/custom_text.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  //------------------------------- Variables-----------------------------//

  //Text editing Controller
  final TextEditingController regardingController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  //Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //Submit Value Notifier
  final ValueNotifier _submitInNotifier = ValueNotifier(true);
  //auto Validate Mode
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  bool selectedItem = false;
  String regardingString = "";
  String attributeType = "";
  String? id;
  List<ContactUsAttributeModel> contactAttrinuteList = [];

  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  // Providers...
  PersonalProfileProvider get getPersonalProfileProvider =>
      Provider.of<PersonalProfileProvider>(context, listen: false);

  @override
  void initState() {
    fetchcontactAttributevalue();
    super.initState();
  }

  //------------------------------- UI-----------------------------//
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: keyboardHideOnTapaction,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  //------------------------------- Widgets-----------------------------//
  //  appBar...
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        StaticString.contactUs,
      ),
    );
  }

  //  body...
  Widget _buildBody() {
    return SafeArea(
      child: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: ValueListenableBuilder(
            valueListenable: _submitInNotifier,
            builder: (context, value, child) => Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                children: [
                  const CustomTitleWithLine(
                    title: StaticString.messageUs,
                    primaryColor: ColorConstants.custDarkBlue150934,
                    secondaryColor: ColorConstants.custgreen19B445,
                  ),
                  const SizedBox(height: 30),
                  _selectAttributeTextformField(),
                  const SizedBox(height: 30),
                  _nameTextformfield(),
                  const SizedBox(height: 30),
                  _mobileTextformfield(),
                  const SizedBox(height: 30),
                  _messageTextFormfield(),
                  const SizedBox(height: 30),
                  const CustomTitleWithLine(
                    title: StaticString.chatwithUs,
                    primaryColor: ColorConstants.custDarkBlue150934,
                    secondaryColor: ColorConstants.custgreen19B445,
                  ),
                  const SizedBox(height: 30),
                  _buildCardInfo(),
                  const SizedBox(height: 50),
                  CommonElevatedButton(
                    color: ColorConstants.custskyblue22CBFE,
                    bttnText: StaticString.submit,
                    fontSize: 14,
                    onPressed: () {
                      conatctUsApiCall(conatctattributeType: attributeType);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Select attribute textformfield...
  Widget _selectAttributeTextformField() {
    return TextFormField(
      onTap: selectAttributeOnTap,
      controller: regardingController,
      readOnly: true,
      validator: (value) => value?.validateEmptyregarding,
      autovalidateMode: _autovalidateMode,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        labelText: StaticString.whatisThisRegarding,
        suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
      ),
    );
  }

//  nameTextFormField...
  Widget _nameTextformfield() {
    return TextFormField(
      controller: _nameController,
      autovalidateMode: _autovalidateMode,
      textInputAction: TextInputAction.next,
      validator: (value) => value?.validateEmptyName,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        labelText: StaticString.name,
      ),
    );
  }

  // mobille textFormfield...
  Widget _mobileTextformfield() {
    return TextFormField(
      controller: _mobileNumController,
      autovalidateMode: _autovalidateMode,
      keyboardType: TextInputType.number,
      maxLength: 10,
      validator: (value) => value?.validatePhoneNumber,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        counterText: "",
        labelText: StaticString.mobileNumber,
      ),
    );
  }

//  messageTextFormField...
  Widget _messageTextFormfield() {
    return TextFormField(
      controller: _messageController,
      autovalidateMode: _autovalidateMode,
      keyboardType: TextInputType.text,
      validator: (value) => value?.validateMessage,
      maxLines: 4,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        labelText: StaticString.message,
      ),
    );
  }

  Widget _buildCardInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorConstants.backgroundColorFFFFFF,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.custGrey7A7A7A.withOpacity(0.20),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.transparent,
            child: CustImage(
              imgURL: ImgName.chatIcon,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  txtTitle: StaticString.zunguLtd,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 1),
                CustomText(
                  txtTitle: StaticString.supportChat,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: ColorConstants.custGrey7A7A7A,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ButtonAction---//
  void keyboardHideOnTapaction() {
    final FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

// Select contact attribute textformfield ontap...
  void selectAttributeOnTap() {
    showAlert(
      hideButton: true,
      context: context,
      showCustomContent: true,
      showIcon: false,
      singleBtnTitle: StaticString.submit,
      singleBtnColor: ColorConstants.custskyblue22CBFE,
      title: StaticString.whatisThisRegarding,
      content: FeedBackRegardingPoppup(
        contactattributeValueList: contactAttrinuteList,
        selectedvalue: attributeType,
        onSubmit: (contactUsAttributeModel, contactList) {
          if (mounted) {
            setState(() {
              regardingController.text =
                  contactUsAttributeModel?.attributeValue ?? "";
              attributeType = contactUsAttributeModel?.id ?? "";

              contactAttrinuteList = contactList;
            });
          }
        },
      ),
    );
  }

  Future<void> conatctUsApiCall({
    String? conatctattributeType,
  }) async {
    try {
      if (!(_formKey.currentState?.validate() ?? true)) {
        _autovalidateMode = AutovalidateMode.always;

        _submitInNotifier.notifyListeners();
      }
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.overlay,
      );

      await Provider.of<PersonalProfileProvider>(context, listen: false)
          .addContactUsData(
        _nameController.text,
        _mobileNumController.text,
        _messageController.text,
        conatctattributeType,
      );
      // Navigator.of(context).pop();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }

  Future<void> fetchcontactAttributevalue() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );

      await getPersonalProfileProvider.contactUsAtribute();
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}

class FeedBackRegardingPoppup extends StatefulWidget {
  final List<ContactUsAttributeModel> contactattributeValueList;
  final void Function(
    ContactUsAttributeModel? contactAttribute,
    List<ContactUsAttributeModel> contactattributeValueList,
  ) onSubmit;
  final String? selectedvalue;

  const FeedBackRegardingPoppup({
    super.key,
    required this.contactattributeValueList,
    required this.onSubmit,
    this.selectedvalue,
  });

  @override
  State<FeedBackRegardingPoppup> createState() =>
      _FeedBackRegardingPoppupState();
}

class _FeedBackRegardingPoppupState extends State<FeedBackRegardingPoppup> {
  // int? selectedIndex;
  ContactUsAttributeModel? contactUsAttributeModel;
  List<ContactUsAttributeModel> contactAttributeList = [];

  @override
  void initState() {
    if (widget.contactattributeValueList.isNotEmpty) {
      contactAttributeList = widget.contactattributeValueList;
    }
    print(contactAttributeList);
    print(widget.contactattributeValueList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<PersonalProfileProvider>(
            builder: (context, contactAttributeValue, child) {
              contactAttributeList = contactAttributeValue.contactAttributeList;

              return contactAttributeList.isEmpty
                  ? const NoContentLabel(title: StaticString.nodataFound)
                  : ListView.builder(
                      itemCount: contactAttributeList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                for (final element in contactAttributeList) {
                                  if (element.id ==
                                      contactAttributeList[index].id) {
                                    element.isSelected = true;
                                  } else {
                                    element.isSelected = false;
                                  }
                                }
                                // contactAttributeList[index].isSelected =
                                //     !contactAttributeList[index].isSelected;

                                contactUsAttributeModel =
                                    contactAttributeList[index];
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustImage(
                                        imgURL: ImgName.greyCheckImage,
                                        imgColor: contactAttributeList[index]
                                                .isSelected
                                            ? ColorConstants.custgreen19B445
                                            : ColorConstants.custGrey707070,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: CustomText(
                                        txtTitle: contactAttributeList[index]
                                            .attributeValue,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                              color: contactAttributeList[index]
                                                      .isSelected
                                                  ? ColorConstants
                                                      .custskyblue22CBFE
                                                  : ColorConstants
                                                      .custGrey707070,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Divider(
                                  color: ColorConstants.custGrey707070
                                      .withOpacity(0.7)
                                      .withOpacity(0.5),
                                  thickness: 0.5,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            },
          ),
          const SizedBox(height: 15),
          CommonElevatedButton(
            color: ColorConstants.custskyblue22CBFE,
            bttnText: StaticString.submit,
            fontSize: 14,
            onPressed: () {
              Navigator.of(context).pop();
              widget.onSubmit(
                contactUsAttributeModel,
                contactAttributeList,
              );
            },
          )
        ],
      ),
    );
  }
}
