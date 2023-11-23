import 'package:flutter/material.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class TenantAppDamageReport extends StatefulWidget {
  const TenantAppDamageReport({super.key});

  @override
  State<TenantAppDamageReport> createState() => _TenantAppDamageReportState();
}

class _TenantAppDamageReportState extends State<TenantAppDamageReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.damageReport,
        ),
      ),
      body: SafeArea(
        child: Column(),
      ),
    );
  }
}
