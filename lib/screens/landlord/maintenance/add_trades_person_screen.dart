import 'package:flutter/material.dart';
import 'package:zungu_mobile/cards/dotted_line_card.dart';
import 'package:zungu_mobile/constant/img_font_color_string.dart';
import 'package:zungu_mobile/widgets/common_elevated_button.dart';
import 'package:zungu_mobile/widgets/custom_text.dart';

class AddTradesPersonScreen extends StatefulWidget {
  const AddTradesPersonScreen({super.key});

  @override
  State<AddTradesPersonScreen> createState() => _AddTradesPersonScreenState();
}

class _AddTradesPersonScreenState extends State<AddTradesPersonScreen> {
  String? photo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          txtTitle: StaticString.addTradesmen,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: StaticString.contractorName,
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: StaticString.mobileNumber,
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: StaticString.tradesPersonProfession,
              ),
            ),
            const SizedBox(height: 40),
            DottedLineCard(
              title: StaticString.uploadProfilePhoto,
              imgUrl: ImgName.landlordCamera,
              onTap: (image) {
                if (mounted) {
                  setState(() {
                    photo = image[0];
                  });
                }
              },
            ),
            const CommonElevatedButton(
              bttnText: StaticString.addTradesmen,
              color: ColorConstants.custskyblue22CBFE,
            )
          ],
        ),
      ),
    );
  }
}
