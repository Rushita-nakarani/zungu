import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/screens/settings/subscription/subscription_detail_screen.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';
import 'package:zungu_mobile/widgets/rounded_lg_shape_widget.dart';

class MySubScriptionScreen extends StatefulWidget {
  const MySubScriptionScreen({super.key});

  @override
  State<MySubScriptionScreen> createState() => _MySubScriptionScreenState();
}

class _MySubScriptionScreenState extends State<MySubScriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StaticString.subscriptions),
        backgroundColor: ColorConstants.custDarkPurple500472,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            _subscriptionCard(),
            const SizedBox(
              width: double.infinity,
              child: RoundedLgShapeWidget(
                color: ColorConstants.custDarkPurple500472,
                title: StaticString.subscriptions,
              ),
            ),
            const SizedBox(height: 32),
            _buildBusinessInfoCard(
              StaticString.landlord,
              StaticString.mONTHLYPLAN,
              StaticString.pERPROPERTY,
              "",
              () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const SubScriptionDetailScreen(),
                  ),
                );
              },
              ColorConstants.custDarkPurple500472,
              ColorConstants.custLightPupurle,
            ),
            const SizedBox(height: 30),
            _buildBusinessInfoCard(
              StaticString.tENANT,
              StaticString.fREEPLAN,
              StaticString.lIFETIMEFREE,
              "",
              () {},
              ColorConstants.custDarkYellow838500,
              ColorConstants.custpaleYellowA0A212,
            ),
            const SizedBox(height: 30),
            _buildBusinessInfoCard(
              StaticString.tRADESMAN,
              StaticString.mONTHLYPLAN,
              StaticString.billedMonthly,
              "",
              () {},
              ColorConstants.custDarkPurple662851,
              ColorConstants.custLight823969,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Container _subscriptionCard() {
    return Container(
      height: 20,
      color: ColorConstants.custDarkPurple500472,
    );
  }

  Widget _buildBusinessInfoCard(
    String title,
    String plan,
    String offer,
    String businessName,
    void Function()? onPressed,
    Color primaryColor,
    Color secColor,
  ) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: primaryColor,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                ),
                const SizedBox(height: 15),
                CustomText(
                  txtTitle: title,
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: ColorConstants.backgroundColorFFFFFF,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 11),
                CustomText(
                  txtTitle: plan,
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: ColorConstants.backgroundColorFFFFFF,
                      ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                color: secColor,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomText(
                    txtTitle: offer,
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 5),
                  CustomText(
                    txtTitle: "£20.00",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    txtTitle: StaticString.eMBERSINCE,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 5),
                  CustomText(
                    txtTitle: "15 Nov 2022",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: onPressed,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const StadiumBorder()),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      fixedSize: MaterialStateProperty.all(
                        const Size(double.infinity, 25),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CustomText(
                        txtTitle: "ACTIVE",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: secColor,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
