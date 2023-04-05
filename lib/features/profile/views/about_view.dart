import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/features/profile/views/terms_conditions_view.dart';
import 'package:shaap_mobile_app/features/profile/widgets/profile_tile.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  void navigateToTandC(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const TermsAndConditionsView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Pallete.whiteColor,
        padding: 24.padH,
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
                  AppTexts.about,
                  style: TextStyle(
                    color: Pallete.textBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                32.sbW,
              ],
            ),

            //! body
            28.sbH,
            Column(
              children: aboutItems
                  .map(
                    (aboutItem) => ProfileTile(
                      onTap: () {
                        switch (aboutItem.title) {
                          case AppTexts.tandc:
                            navigateToTandC(context);
                            break;
                          default:
                        }
                      },
                      icon: aboutItem.icon,
                      title: aboutItem.title,
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

class AboutItem {
  final String icon;
  final String title;
  const AboutItem({
    required this.icon,
    required this.title,
  });
}

const aboutItems = [
  AboutItem(
    icon: 'tandc',
    title: AppTexts.tandc,
  ),
  AboutItem(
    icon: 'privacy',
    title: AppTexts.privacy,
  ),
  AboutItem(
    icon: 'legalTerms',
    title: AppTexts.legalTerms,
  ),
];
