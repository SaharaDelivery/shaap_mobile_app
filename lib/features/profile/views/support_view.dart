import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/features/profile/views/faqs_view.dart';
import 'package:shaap_mobile_app/features/profile/widgets/profile_tile.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  void navigateToFaqs(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const FaqsView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: 24.padH,
        color: Pallete.whiteColor,
        child: Column(
          children: [
            50.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TransparentButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  height: 32.h,
                  width: 32.h,
                  isText: false,
                  item: Icon(
                    Icons.arrow_back,
                    color: Pallete.textBlack,
                    size: 20.sp,
                  ),
                ),
                Text(
                  AppTexts.support,
                  style: TextStyle(
                    color: Pallete.textBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                32.sbW,
              ],
            ),
            28.sbH,
            Column(
              children: supportItems
                  .map(
                    (e) => ProfileTile(
                      onTap: () {
                        switch (e.title) {
                          case AppTexts.faqs:
                            navigateToFaqs(context);
                            break;
                          default:
                        }
                      },
                      icon: e.icon,
                      title: e.title,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class SupportItem {
  final String icon;
  final String title;
  const SupportItem({
    required this.icon,
    required this.title,
  });
}

const supportItems = [
  SupportItem(
    icon: 'faqs',
    title: AppTexts.faqs,
  ),
  SupportItem(
    icon: 'mail',
    title: AppTexts.email,
  ),
  SupportItem(
    icon: 'twitter',
    title: AppTexts.twitter,
  ),
  SupportItem(
    icon: 'insta',
    title: AppTexts.instagram,
  ),
];
