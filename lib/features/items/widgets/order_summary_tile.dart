import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class OrderSummaryTile extends ConsumerWidget {
  const OrderSummaryTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 56.h,
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Pallete.borderGrey),
      ),
      child: Row(
        children: [
          Image.asset('food-3'.png),
          15.sbW,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Zinger burger combo',
                style: TextStyle(
                  color: Pallete.textBlack,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '${AppTexts.naira} 4500',
                style: TextStyle(
                  color: Pallete.textGrey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          //! add/remove
          Container(
            height: 29.h,
            width: 86.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.8.r),
                border: Border.all(color: Pallete.dividerGreyColor)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TransparentButton(
                    onTap: () {},
                    height: 13.h,
                    width: 13.w,
                    isText: false,
                    radius: 3.r,
                    item: Icon(
                      PhosphorIcons.minusBold,
                      color: Colors.black,
                      size: 10.sp,
                    ),
                  ),
                  Text(
                    '1',
                    style: TextStyle(
                      color: Pallete.blackColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TransparentButton(
                    onTap: () {},
                    height: 13.h,
                    width: 13.w,
                    isText: false,
                    radius: 3.r,
                    item: Icon(
                      PhosphorIcons.plusBold,
                      color: Colors.black,
                      size: 8.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
