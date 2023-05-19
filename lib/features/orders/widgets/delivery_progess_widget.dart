import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class DeliveryProgressWidget extends ConsumerWidget {
  const DeliveryProgressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: 24.padH,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! step 1 bar
          Container(
            height: 4.h,
            width: 58.w,
            decoration: BoxDecoration(
              color: Pallete.borderGrey,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          //! step 1 completion
          Container(
            height: 14.h,
            width: 14.w,
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: Pallete.dividerGreyColor,
              ),
            ),
            child: Center(
              child: Icon(
                PhosphorIcons.checkBold,
                size: 10.sp,
                color: Pallete.whiteColor,
              ),
            ),
          ),

          //! step 2 bar
          Container(
            height: 4.h,
            width: 58.w,
            decoration: BoxDecoration(
              color: Pallete.borderGrey,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          //! step 2 completion
          Container(
            height: 14.h,
            width: 14.w,
            decoration: BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: Pallete.dividerGreyColor,
              ),
            ),
            child: Center(
              child: Icon(
                PhosphorIcons.checkBold,
                size: 10.sp,
                color: Pallete.whiteColor,
              ),
            ),
          ),

          //! step 3 bar
          Container(
            height: 4.h,
            width: 58.w,
            decoration: BoxDecoration(
              color: Pallete.borderGrey,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          //! step 3 bike completion
          SvgPicture.asset('bikee'.svg),

          //! step 4 bar
          Container(
            height: 4.h,
            width: 58.w,
            decoration: BoxDecoration(
              color: Pallete.borderGrey,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          //! step 4 delivery box completion
          SvgPicture.asset('deliveryBox'.svg),
        ],
      ),
    );
  }
}
