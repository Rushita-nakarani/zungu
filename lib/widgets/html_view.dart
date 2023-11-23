import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/providers/auth/auth_provider.dart';
import 'package:zungu_mobile/widgets/custom_alert.dart';
import 'package:zungu_mobile/widgets/custom_title_with_line.dart';
import 'package:zungu_mobile/widgets/loading_indicator.dart';
import 'package:zungu_mobile/widgets/no_content_label.dart';

import '../models/settings/setting_content_model.dart';
import '../utils/cust_eums.dart';
import '../utils/custom_extension.dart';

class HtmlCommonView extends StatefulWidget {
  final String title;
  final HtmlViewType viewType;

  const HtmlCommonView({
    super.key,
    required this.title,
    required this.viewType,
  });

  @override
  State<HtmlCommonView> createState() => _HtmlCommonViewState();
}

class _HtmlCommonViewState extends State<HtmlCommonView> {
  final LoadingIndicatorNotifier _loadingIndicatorNotifier =
      LoadingIndicatorNotifier();

  SettingContentModel? _settingContent;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LoadingIndicator(
        loadingStatusNotifier: _loadingIndicatorNotifier,
        child: _settingContent == null
            ? const NoContentLabel(title: AlertMessageString.noDataFound)
            : ListView.separated(
                padding: const EdgeInsets.all(15),
                itemCount: _settingContent!.points.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomTitleWithLine(
                        title: _settingContent!.points[index].title ?? "",
                        primaryColor: ColorConstants.custPurple500472,
                        secondaryColor: ColorConstants.custskyblue22CBFE,
                      ),
                      const SizedBox(height: 15),
                      Html(
                        data: _settingContent!.points[index].description,
                        onLinkTap: (text, ctx, map, element) {
                          try {
                            text?.launchURL();
                          } catch (e) {
                            print(e);
                            showAlert(context: context, message: e);
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      _loadingIndicatorNotifier.show(
        loadingIndicatorType: LoadingIndicatorType.spinner,
      );
      _settingContent = await Provider.of<AuthProvider>(context, listen: false)
          .fetchSettingContent(widget.viewType);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      showAlert(context: context, message: e);
    } finally {
      _loadingIndicatorNotifier.hide();
    }
  }
}
