import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class StatusStackedCard extends ConsumerWidget {
  const StatusStackedCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: 24.padH,
      // color: Colors.grey,
      height: 85.h,
      child: Stack(
        children: [
          // base
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 66.8.h,
              width: 297.w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Pallete.dividerGreyColor),
                borderRadius: BorderRadius.circular(4.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2.w, 2.h),
                    color: Pallete.shadowGrey.withOpacity(0.1),
                    blurRadius: 2.r,
                  ),
                ],
              ),
            ),
          ),

          //! 2nd to last
          Positioned(
            bottom: 6.h,
            left: 11.w,
            right: 11.w,
            child: Container(
              height: 66.8.h,
              // width: 305.w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Pallete.dividerGreyColor),
                borderRadius: BorderRadius.circular(4.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2.w, 2.h),
                    color: Pallete.shadowGrey.withOpacity(0.1),
                    blurRadius: 2.r,
                  ),
                ],
              ),
            ),
          ),

          //! 2ND
          Positioned(
            bottom: 12.h,
            left: 7.w,
            right: 7.w,
            child: Container(
              height: 66.8.h,
              // width: 305.w,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Pallete.dividerGreyColor),
                borderRadius: BorderRadius.circular(4.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2.w, 2.h),
                    color: Pallete.shadowGrey.withOpacity(0.1),
                    blurRadius: 2.r,
                  ),
                ],
              ),
            ),
          ),

          //! content card
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 66.8.h,
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Pallete.dividerGreyColor),
                borderRadius: BorderRadius.circular(4.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2.w, 2.h),
                    color: Pallete.shadowGrey.withOpacity(0.1),
                    blurRadius: 2.r,
                  ),
                ],
              ),
              child: Row(
                children: [

                  // TODO: implement glowing feature
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 12.w,
                  ),
                  16.sbW,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cancelled',
                        style: TextStyle(
                          color: Pallete.textBlack,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Your order has been cancelled',
                        style: TextStyle(
                          color: Pallete.textGrey,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
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
