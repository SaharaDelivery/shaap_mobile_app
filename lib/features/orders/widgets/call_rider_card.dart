import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class CallRiderCard extends ConsumerWidget {
  const CallRiderCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: 24.padH,
      padding: EdgeInsets.all(14.w),
      height: 72.h,
      decoration: BoxDecoration(
        color: Pallete.trackOrdersGrey,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.w,
          ),
          8.sbW,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Cancelled',
                style: TextStyle(
                  color: Pallete.textBlack,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              4.sbH,
              Text(
                'Rider',
                style: TextStyle(
                  color: Pallete.textGrey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const Spacer(),
          CircleAvatar(
            radius: 16.w,
            backgroundColor: Pallete.yellowColor,
            child: SvgPicture.asset('phone'.svg),
          ),
        ],
      ),
    );
  }
}
