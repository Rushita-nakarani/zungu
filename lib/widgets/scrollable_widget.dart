import 'package:flutter/material.dart';
import 'package:zungu_mobile/widgets/keyboard_with_done_button.dart';

//use this Scrollable widget when you need to use expanded in scrollview...
class BuildScrollableWidget extends StatelessWidget {
  final void Function()? onDoneClicked;
  final List<FocusNode> focusNodeList;
  final Widget? child;
  final bool disableScroll;
  final ScrollPhysics scrollPhysics;
  final EdgeInsetsGeometry? padding;

  const BuildScrollableWidget({
    this.child,
    this.onDoneClicked,
    this.focusNodeList = const [],
    this.disableScroll = false,
    this.scrollPhysics = const AlwaysScrollableScrollPhysics(),
    this.padding,
  });
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return focusNodeList.isNotEmpty
            ? KeyboardWithDoneButton(
                focusNodeList: focusNodeList,
                showNextButton: focusNodeList.length > 1,
                disableScroll: disableScroll,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: child,
                  ),
                ),
                onDoneClicked: () {
                  if (onDoneClicked != null) {
                    for (int i = 0; i < focusNodeList.length; i++) {
                      if (focusNodeList[i].hasFocus) {
                        FocusScope.of(context).requestFocus(
                          i + 1 < focusNodeList.length
                              ? focusNodeList[i + 1]
                              : FocusNode(),
                        );
                        break;
                      }
                    }
                    onDoneClicked!();
                  }
                },
              )
            : SingleChildScrollView(
                physics: scrollPhysics,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: padding ?? EdgeInsets.zero,
                      child: child,
                    ),
                  ),
                ),
              );
      },
    );
  }
}
