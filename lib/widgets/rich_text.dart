import 'package:flutter/material.dart';

import '../utils/custom_extension.dart';

class CustomRichText extends StatelessWidget {
  const CustomRichText({
    this.title = "",
    this.normalTextStyle,
    this.fancyTextStyle,
    this.textAlign = TextAlign.left,
    this.onTap,
    this.maxLines = 2,
  });
  final String title;
  final void Function(String)? onTap;
  final TextStyle? fancyTextStyle;
  final TextStyle? normalTextStyle;
  final TextAlign textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return RichText(
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      text: TextSpan(
        style: theme.bodyText2,
        children: title.processCaption(
          normalTextStyle: normalTextStyle ?? theme.bodyText1,
          fancyTextStyle: fancyTextStyle ??
              theme.bodyText1?.copyWith(
                color: Theme.of(context).buttonTheme.colorScheme?.background,
              ),
          onTap: onTap ?? (text) {},
        ),
      ),
    );
  }
}
