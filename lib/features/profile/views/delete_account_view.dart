import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class DeleteAccountView extends ConsumerStatefulWidget {
  const DeleteAccountView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeleteAccountViewState();
}

class _DeleteAccountViewState extends ConsumerState<DeleteAccountView> {
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
                  AppTexts.deleteAcc,
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
            //! disclaimer
            Container(
              height: 52.h,
              width: double.infinity,
              padding: EdgeInsets.all(8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(
                  color: Pallete.pink,
                ),
              ),
              child: Text(
                AppTexts.thisAction,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Pallete.red,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacer(),
            BButton(
              onTap: () {},
              color: Pallete.red,
              text: AppTexts.deleteAcc,
            ),
            81.sbH,
          ],
        ),
      ),
    );
  }
}
