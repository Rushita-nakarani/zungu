import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/providers/auth/auth_provider.dart';
import 'package:zungu_mobile/widgets/cust_image.dart';

import '../utils/push_notification.dart';
import '../widgets/custom_text.dart';
import 'common_elevated_button.dart';

Future<bool?> showAlert({
  required BuildContext context,
  String title = APIErrorMsg.defaultErrorTitle,
  String icon = ImgName.error,
  dynamic message = APIErrorMsg.somethingWentWrong,
  void Function()? onRightAction,
  void Function()? onLeftAction,
  TextAlign contentAlign = TextAlign.center,
  String leftBttnTitle = StaticString.no,
  String rigthBttnTitle = StaticString.yes,
  String singleBtnTitle = StaticString.ok,
  Color? singleBtnColor,
  bool signleBttnOnly = true,
  bool barrierDismissible = true,
  bool disableDefaultPop = false,
  bool showCustomContent = false,
  bool hideButton = false,
  Widget? subScriptionBtn,
  bool showIcon = true,
  Widget? content,
  MainAxisAlignment buttonAlignmnet = MainAxisAlignment.end,
}) async {
  //Retry button...
  Widget retryButton(BuildContext ctx) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: CommonElevatedButton(
          onPressed: () {
            if (Navigator.of(ctx).canPop() && !disableDefaultPop) {
              Navigator.of(ctx).pop(true);
            }

            if (message is AppException &&
                message.type == ExceptionType.UnAuthorised) {
              Provider.of<AuthProvider>(context, listen: false).logout();
              Navigator.of(context).popUntil((route) => route.isFirst);
              PushNotification.instance.logout();
            }
            if (onRightAction == null) return;
            onRightAction();
          },
          bttnText: singleBtnTitle,
          color: singleBtnColor,
        ),
      );

  //Left Button...
  Widget leftButton(BuildContext ctx) => Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: CommonElevatedButton(
          onPressed: () {
            if (Navigator.of(ctx).canPop()) Navigator.of(ctx).pop(true);
            if (onLeftAction == null) return;
            onLeftAction();
          },
          bttnText: leftBttnTitle,
        ),
      );

  //Right Bttn...
  Widget rightButton(BuildContext ctx) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: CommonElevatedButton(
          onPressed: () {
            if (Navigator.of(ctx).canPop() && !disableDefaultPop) {
              Navigator.of(ctx).pop(true);
            }
            if (onRightAction == null) return;
            onRightAction();
          },
          bttnText: rigthBttnTitle,
        ),
      );

  // SetUp the AlertDialog
  Widget alert(BuildContext ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                  if (title.isEmpty)
                    Container()
                  else
                    Expanded(
                      flex: 5,
                      child: CustomText(
                        txtTitle: toBeginningOfSentenceCase(
                          message is AppException ? message.getTitle : title,
                        ),
                        align: TextAlign.center,
                        style: Theme.of(ctx).textTheme.headline2?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  Expanded(child: Container())
                ],
              ),
            ),
            if (showIcon)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CustImage(
                  imgURL: icon,
                  width: 150,
                ),
              ),
            const SizedBox(height: 20),
            if (showCustomContent)
              content ?? Container()
            else
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomText(
                  align: contentAlign,
                  txtTitle: message is AppException
                      ? message.getMessage
                      : (message?.toString() ?? APIErrorMsg.somethingWentWrong),
                  style: Theme.of(ctx)
                      .textTheme
                      .headline1
                      ?.copyWith(color: const Color(0xFFA4A4A4)),
                ),
              ),
            if (signleBttnOnly)
              hideButton
                  ? Container()
                  : Column(
                      mainAxisAlignment: buttonAlignmnet,
                      children: [
                        subScriptionBtn ?? retryButton(ctx),
                      ],
                    )
            else
              Column(
                mainAxisAlignment: buttonAlignmnet,
                children: [
                  leftButton(ctx),
                  rightButton(ctx),
                ],
              )
          ],
        ),
      );

  // show the dialog
  return showModalBottomSheet<bool>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(
          30,
        ),
        topRight: Radius.circular(
          30,
        ),
      ),
    ),
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    isDismissible:
        (message is AppException && message.type == ExceptionType.UnAuthorised)
            ? false
            : barrierDismissible,
    builder: alert,
  );
}
