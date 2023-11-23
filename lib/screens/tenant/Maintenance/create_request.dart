import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/string_constants.dart';
import 'package:zungu_mobile/screens/tenant/Maintenance/maintenance_select_property.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../../../../utils/custom_extension.dart';
import '../../../cards/selected_property_card.dart';
import '../../../constant/color_constants.dart';
import '../../../constant/img_constants.dart';
import '../../../utils/cust_eums.dart';
import '../../../widgets/common_elevated_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/image_upload_widget.dart';
import '../../../widgets/lenear_container.dart';

class TenantMaintenanceCreateRequest extends StatefulWidget {
  const TenantMaintenanceCreateRequest({super.key});

  @override
  State<TenantMaintenanceCreateRequest> createState() =>
      _TenantMaintenanceCreateRequestState();
}

class _TenantMaintenanceCreateRequestState
    extends State<TenantMaintenanceCreateRequest> {
  //String _currentSelection = StaticString.currentTenancy;
  final urlImages = [
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
  ];

  TextEditingController headlineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool serviceModel = false;
  int selectedTool = -1;
  bool _showNotificationAlert = true;
  final ValueNotifier _notificationAlertNotifier = ValueNotifier(true);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              // ignore: avoid_redundant_argument_values
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                // _buildInfo1(),
                //  _buildInfo(),
                //_dialogBuilder(context),
                if (_showNotificationAlert)
                  ValueListenableBuilder(
                    valueListenable: _notificationAlertNotifier,
                    builder: (context, value, child) {
                      return _buildNotification();
                    },
                  ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSubTitle(StaticString.selectProperty),
                          LinearContainer(
                            width: MediaQuery.of(context).size.width / 8,
                            color: ColorConstants.custDarkPurple662851,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          LinearContainer(
                            width: MediaQuery.of(context).size.width / 12,
                            color: ColorConstants.custDarkYellow838500,
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  const MaintenanceSelectProperty(),
                            ),
                          );
                        },
                        child: CustomText(
                          txtTitle: StaticString.viewAll,
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstants.custDarkYellow838500,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CarouselSlider.builder(
                  itemCount: urlImages.length,
                  options: CarouselOptions(
                    height: 290,
                    enableInfiniteScroll: false,
                    viewportFraction: 0.9,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return _buildImage(urlImages[index], index);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSubTitle(StaticString.sendMaintenanceRequest),
                      LinearContainer(
                        width: MediaQuery.of(context).size.width / 7,
                        color: ColorConstants.custDarkPurple662851,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      LinearContainer(
                        width: MediaQuery.of(context).size.width / 10,
                        color: ColorConstants.custDarkYellow838500,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      _buildheadline("${StaticString.headLine}*"),
                      const SizedBox(
                        height: 22,
                      ),
                      _buildDescription("${StaticString.description}*"),
                      const SizedBox(
                        height: 25,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            txtTitle: StaticString.urgentRequest,
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstants.custDarkBlue150934,
                                    ),
                          ),
                          Switch.adaptive(
                            activeColor: Colors.white,
                            activeTrackColor:
                                ColorConstants.custDarkPurple662851,
                            value: serviceModel,
                            // _switchValue,
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {
                                  serviceModel = value;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      _uploadPhotosVideos(),
                      const SizedBox(height: 40),
                      _buildSendCodeButton(),
                      const SizedBox(height: 30),
                      // const TextField(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String urlImage, int index) {
    return GestureDetector(
      onTap: () {
        if (mounted) {
          setState(() {
            selectedTool = index;
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 6),
        child: SelectedPropertyCard(
          icon: selectedTool == index
              ? const CustImage(
                  imgURL: ImgName.tenantCheckmarkCircleFilled,
                  width: 36,
                )
              : Container(),
          imageUrl: urlImage,
          propertyTitle: "24 Oxford Street",
          propertySubtitle: "London Paddington SE1 4ER",
          color: ColorConstants.custDarkPurple500472,
          border: Border.all(
            color: selectedTool == index
                ? ColorConstants.custDarkYellow838500
                : Colors.white.withOpacity(0),
            width: 1.5,
          ),
        ),
      ),
    );
  }

  //------------Notification-----------/

  Widget _buildNotification() {
    return Stack(
      // clipBehavior: Clip.none,
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            //color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: const [
              CustImage(
                imgURL: ImgName.commonInformation,
                imgColor: ColorConstants.custDarkYellow838500,
                width: 36,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                  style: TextStyle(
                    color: ColorConstants.custGrey8F8F8F,
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 15,
          child: CircleAvatar(
            backgroundColor: Colors.grey.withOpacity(0.2),
            child: IconButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    _showNotificationAlert = false;

                    _notificationAlertNotifier.notifyListeners();
                  });
                }
              },
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //--------upload Photosvideos--------/

  Widget _uploadPhotosVideos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          txtTitle: StaticString.uploadPhotosVideos,
        ),
        const SizedBox(height: 20),
        UploadMediaWidget(
          images: const [],
          image: ImgName.tenantCamera,
          userRole: UserRole.TENANT,
          imageList: (images) {
            debugPrint(images.toString());
          },
        ),
      ],
    );
  }

// Generate Lease button
  Widget _buildSendCodeButton() {
    return CommonElevatedButton(
      color: ColorConstants.custDarkYellow838500,
      bttnText: StaticString.sendToLandlord.toUpperCase(),
      onPressed: sendCodeButtonAction,
    );
  }

  //------------------------- Button action -------------------------

  void sendCodeButtonAction() {
    if (_formKey.currentState!.validate()) {}
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (ctx) => const TenantMaintenanceSentRequest(),
    //   ),
    // );
  }

  //----------subTitle Name---------------------
  Widget _buildSubTitle(text) {
    return CustomText(
      txtTitle: text,
      style: Theme.of(context).textTheme.headline1?.copyWith(
            fontWeight: FontWeight.w500,
          ),
    );
  }

  InputDecoration commonInputDecoration(String lable) {
    return InputDecoration(
      labelText: lable,
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
      labelStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
            color: ColorConstants.custDarkBlue160935,
          ),
      floatingLabelStyle: Theme.of(context).textTheme.headline2?.copyWith(
            color: ColorConstants.custDarkBlue160935,
          ),
    );
  }

  TextFormField _buildheadline(String lable) {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      controller: headlineController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.emptyHeadline,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: commonInputDecoration(lable),
    );
  }

  TextFormField _buildDescription(String lable) {
    return TextFormField(
      autovalidateMode: _autovalidateMode,
      controller: descriptionController,
      cursorColor: ColorConstants.custDarkBlue160935,
      validator: (value) => value?.emptyTenantDescription,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      textInputAction: TextInputAction.next,
      decoration: commonInputDecoration(lable),
    );
  }
}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Basic dialog title'),
        content: const Text('A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Disable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Enable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
