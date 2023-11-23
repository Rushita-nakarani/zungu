import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/providers/auth/auth_provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  //------------------------------Variables---------------------------------//

  //Introduction Globle key
  final introKey = GlobalKey<IntroductionScreenState>();

  int _index = 0;

  //------------------------------UI---------------------------------//

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    final pageDecoration = PageDecoration(
      titleTextStyle: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: StaticString.landlordSmall,
          body: StaticString.landlordDescription,
          image: _buildImage(ImgName.zunguFloating),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: StaticString.tenant,
          body: StaticString.tenant1Description,
          image: _buildImage(ImgName.zunguFloating),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: StaticString.tradsemanSmall,
          body: StaticString.tradesPersonDescription,
          image: _buildImage(ImgName.zunguFloating),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipOrBackFlex: _index == 2 ? 1 : 0,
      nextFlex: _index == 2 ? 1 : 0,
      dotsFlex: 2,
      back: const Icon(Icons.arrow_back),
      skip: const Text(
        StaticString.skip,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
      ),
      next: const Icon(Icons.arrow_forward),
      done: const Text(
        StaticString.done,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      onChange: (val) => skipBtnAction(val),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }

  //-----------------------------Widgets-------------------------------//

  // Onboarding Image
  Widget _buildImage(String assetName, [double width = 250]) {
    return SvgPicture.asset(assetName, width: width);
  }

  //-----------------------------Helper Function---------------------------//

  // On Intro End
  void _onIntroEnd(context) {
    Provider.of<AuthProvider>(context, listen: false).isShowedOnBoarding = true;
  }

  void skipBtnAction(int val) {
    if (mounted) {
      setState(() {
        _index = val;
      });
    }
  }
}
