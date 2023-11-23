import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/utils/cust_eums.dart';
import 'package:zungu_mobile/widgets/image_upload_widget.dart';

import '../../../constant/color_constants.dart';
import '../../../constant/img_constants.dart';
import '../../../main.dart';
import '../../../utils/custom_extension.dart';
import '../../../widgets/common_auto_textformfield.dart';
import '../../../widgets/common_elevated_button.dart';
import '../../../widgets/cust_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/date_selector.dart';
import '../../../widgets/time_selector.dart';

class AddPrivateJobScreen extends StatefulWidget {
  const AddPrivateJobScreen({super.key});

  @override
  State<AddPrivateJobScreen> createState() => _AddPrivateJobScreenState();
}

class _AddPrivateJobScreenState extends State<AddPrivateJobScreen> {
  //----------------------------Variable---------------------//
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidationMode = AutovalidateMode.disabled;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _clientNameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _clientMobileNumberController =
      TextEditingController();
  final TextEditingController _clientEmailAddressController =
      TextEditingController();
  final TextEditingController _dateOfJobController = TextEditingController();
  final TextEditingController _timeOfJobController = TextEditingController();
  final TextEditingController _jobHeadingController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  final TextEditingController _invoiceAmountController =
      TextEditingController();
  final TextEditingController _vatController = TextEditingController();

  bool urgentRequest = false;
  bool addVAT = false;

  List<String> photosVideoList = [];

  //----------------------------UI---------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.custDarkTeal017781,
        title: const Text(StaticString.addPrivateJob),
      ),
      body: _buildBody(context),
    );
  }

  //----------------------------Widget---------------------//

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Form(
            key: formKey,
            autovalidateMode: autoValidationMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Alert Message Card
                _alertMsgCard(),
                const SizedBox(height: 25),

                //Find address text
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 30),
                  child: CustomText(
                    txtTitle: StaticString.findAddress,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                const SizedBox(height: 10),

                //Find Address Textfield
                Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: SearchLocationautocomplete(
                    streetController: _searchController,
                    icon: ImgName.searchGreen,
                    onTap: () {
                      _scrollController
                          .jumpTo(_scrollController.position.maxScrollExtent);
                    },
                  ),
                ),
                const SizedBox(height: 30),

                //Client Name Text Field
                _clientNameTextfield(),
                const SizedBox(height: 30),

                //Client Mobile Number Text Field
                _clientNumberTextfield(),
                const SizedBox(height: 30),

                //Client Email Address Text Field
                _clientEmailAddressTextfield(),
                const SizedBox(height: 30),

                //Date Of Job Text Field
                _dateOfJobTextfield(),
                const SizedBox(height: 30),

                //Time Of Job Text Field
                _timeOfJobTextfield(),
                const SizedBox(height: 30),

                //Job Heading Text Field
                _jobHeadingTextfield(),
                const SizedBox(height: 30),

                //Job Description Text Field
                _jobDescriptionTextfield(),
                const SizedBox(height: 30),

                //Urgent Request text and switch
                _urgentRequestAndSwitchRow(),
                const SizedBox(height: 15),

                // Invoice Amount Textfield
                _invoiceAmountTextfield(),
                const SizedBox(height: 40),

                //Urgent Request text and switch
                _addVATAndSwitchRow(),
                const SizedBox(height: 35),

                // Vat Percentage textfield
                _vatTextfield(),
                const SizedBox(height: 25),

                // Summary Card
                summaryCard(),
                const SizedBox(height: 35),

                // Upload Photos/Videos
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomText(
                    txtTitle: StaticString.uploadPhotosVideo,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                const SizedBox(height: 15),

                //List of Image and camera option
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: UploadMediaWidget(
                    images: [],
                    image: ImgName.tradesmanCamera,
                    userRole: UserRole.TRADESPERSON,
                    imageList: (images) {
                      debugPrint(images.toString());
                    },
                  ),
                ),
                const SizedBox(height: 70),

                //Submit Private job ElavtedButton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CommonElevatedButton(
                    bttnText: StaticString.submitPrivateJob,
                    color: ColorConstants.custParrotGreenAFCB1F,
                    height: 40,
                    onPressed: submitPrivateJobBtnAction,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //------------------------Widget--------------------//

  // Alert Message card
  Widget _alertMsgCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstants.custGreyF8F8F8,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const CustImage(
                imgURL: ImgName.completedJob,
              ),
            ),
            Expanded(
              child: CustomText(
                txtTitle: StaticString.youCanAddYourPivateJobMsg,
                maxLine: 2,
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: ColorConstants.custGrey707070,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Client Name Textfield
  Widget _clientNameTextfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        autovalidateMode: autoValidationMode,
        validator: (value) => value?.validateClientName,
        controller: _clientNameController,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: "${StaticString.clientName}*",
        ),
      ),
    );
  }

  // Client Mobile Number Textfield
  Widget _clientNumberTextfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        maxLength: 10,
        autovalidateMode: autoValidationMode,
        validator: (value) => value?.validateClientMobileNumber,
        controller: _clientMobileNumberController,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: "${StaticString.clientMobilNumber}*",
          counterText: "",
        ),
      ),
    );
  }

  //Client Email Address Text Field
  Widget _clientEmailAddressTextfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        autovalidateMode: autoValidationMode,
        validator: (value) => value?.validateEmail,
        controller: _clientEmailAddressController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: "${StaticString.clientEmailAddress}*",
          helperText: StaticString.weWillEmailInvoicesToTheClient,
          helperStyle: TextStyle(
            color: ColorConstants.custParrotGreenAFCB1F,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  //Date Of Job Text Field
  Widget _dateOfJobTextfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        onTap: () => selectDate(
          controller: _dateOfJobController,
          color: ColorConstants.custDarkTeal017781,
        ),
        autovalidateMode: autoValidationMode,
        validator: (value) => value?.validateDateMessage,
        controller: _dateOfJobController,
        readOnly: true,
        keyboardType: TextInputType.datetime,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: "${StaticString.dateOfJob}*",
          suffixIcon: CustImage(
            imgURL: ImgName.greenCalender,
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
  }

  //Time Of Job Text Field
  Widget _timeOfJobTextfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        onTap: () => selectTime(
          controller: _timeOfJobController,
          color: ColorConstants.custDarkTeal017781,
        ),
        autovalidateMode: autoValidationMode,
        validator: (value) => value?.validateTimeMessage,
        controller: _timeOfJobController,
        readOnly: true,
        keyboardType: TextInputType.datetime,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: "${StaticString.timeOfJob}*",
          suffixIcon: CustImage(
            imgURL: ImgName.greenClock,
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
  }

  // Job Heading Text Field
  Widget _jobHeadingTextfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        autovalidateMode: autoValidationMode,
        validator: (value) => value?.validatejobHeading,
        controller: _jobHeadingController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: "${StaticString.jobHeading}*",
        ),
      ),
    );
  }

  // Job Description Text Field
  Widget _jobDescriptionTextfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        maxLines: 3,
        autovalidateMode: autoValidationMode,
        validator: (value) => value?.validatejobDescription,
        controller: _jobDescriptionController,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          labelText: "${StaticString.jobDescription}*",
        ),
      ),
    );
  }

  // Urgent request text and switch
  Widget _urgentRequestAndSwitchRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: StaticString.urgentRequest,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Switch.adaptive(
            activeColor: ColorConstants.custDarkTeal017781,
            value: urgentRequest,
            onChanged: (value) {
              if (mounted) {
                setState(() {
                  urgentRequest = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  // Invoice amount Text Field
  Widget _invoiceAmountTextfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        autovalidateMode: autoValidationMode,
        validator: (value) => value?.validateInvoiceAmount,
        controller: _invoiceAmountController,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: StaticString.invoiceAmount.addStarAfter,
          prefixText: StaticString.currency.addSpaceAfter,
        ),
      ),
    );
  }

  // Urgent request text and switch
  Widget _addVATAndSwitchRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: StaticString.addVat,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey707070,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Switch.adaptive(
            activeColor: ColorConstants.custDarkTeal017781,
            value: addVAT,
            onChanged: (value) {
              if (mounted) {
                setState(() {
                  addVAT = value;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  // VAT% Text Field
  Widget _vatTextfield() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        autovalidateMode: autoValidationMode,
        validator: (value) => value?.validatePercentageOfVAT,
        controller: _vatController,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          labelText: "${StaticString.vat1}%",
        ),
      ),
    );
  }

  // Summary Card
  Widget summaryCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: ColorConstants.custGreyCFCFCF,
              ),
            ),
            child: Column(
              children: [
                _custTitleAndAmountrow(
                  title: StaticString.subTotal,
                  amount: "£ 1500",
                ),
                _custTitleAndAmountrow(
                  title: StaticString.vat1,
                  amount: "£ 300",
                ),
                _custTitleAndAmountrow(
                  title: StaticString.total1,
                  amount: "£ 1800",
                )
              ],
            ),
          ),
          Positioned(
            left: 15,
            top: -2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              color: Colors.white,
              child: CustomText(
                txtTitle: StaticString.summary,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // //List of Image and camera option
  // Widget _imageListAndCameraImage() {
  //   return SizedBox(
  //     height: 80,
  //     child: ListView.builder(
  //       padding: const EdgeInsets.symmetric(horizontal: 30),
  //       scrollDirection: Axis.horizontal,
  //       itemCount: photosVideoList.length + 1,
  //       shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         if (index == (photosVideoList.length)) {
  //           return ImagePickerButton(
  //             onImageSelected: (images) {
  //               if (images.isNotEmpty && mounted) {
  //                 setState(() {
  //                   photosVideoList.addAll(images);
  //                 });
  //               }
  //             },
  //             child: Container(
  //               height: 70,
  //               width: 70,
  //               margin: const EdgeInsets.symmetric(
  //                 horizontal: 5,
  //                 vertical: 5,
  //               ),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(15),
  //                 color: ColorConstants.custlightwhitee,
  //                 border: Border.all(
  //                   color: ColorConstants.custGreyEBEAEA,
  //                   width: 0.2,
  //                 ),
  //               ),
  //               child: const Padding(
  //                 padding: EdgeInsets.all(10.0),
  //                 child: CustImage(
  //                   imgURL: ImgName.greenPdfCamera,
  //                 ),
  //               ),
  //             ),
  //           );
  //         }
  //         return ImageWithCrossIcon(
  //           padding: const EdgeInsets.only(right: 14, top: 5),
  //           imageIcon: ImgName.greenCrossIcon,
  //           onTap: () {
  //             setState(() {
  //               photosVideoList.removeAt(index);
  //             });
  //           },
  //           imgName: photosVideoList[index],
  //           top: 0,
  //           right: 10,
  //         );
  //       },
  //     ),
  //   );
  // }

  // Custom title and amount text row
  Widget _custTitleAndAmountrow({
    required String title,
    required String amount,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 12, bottom: 12, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            txtTitle: title,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey656567,
                ),
          ),
          CustomText(
            txtTitle: amount,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: ColorConstants.custGrey656567,
                ),
          )
        ],
      ),
    );
  }

  //-----------------------------Button Action----------------------//

  void submitPrivateJobBtnAction() {
    if (mounted) {
      setState(() {
        autoValidationMode = AutovalidateMode.always;
      });
    }
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      final FocusScopeNode currentFocus = FocusScope.of(context);

      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
  }
}
