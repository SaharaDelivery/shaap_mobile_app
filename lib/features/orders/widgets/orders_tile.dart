// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class OrdersTile extends ConsumerWidget {
  final String restaurantName;
  final String orderID;
  final String image;
  final String status;
  final String details;
  final void Function()? onTap;
  const OrdersTile({
    super.key,
    required this.restaurantName,
    required this.orderID,
    required this.image,
    required this.status,
    required this.details,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80.h,
        width: double.infinity,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Pallete.borderGrey),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! image
            Container(
              height: double.infinity,
              width: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: DecorationImage(
                  image: AssetImage(image.png),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            10.sbW,

            //! details
            SizedBox(
              width: 170.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Pallete.textBlack,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Order Id - $orderID',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Pallete.textGrey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    details,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Pallete.textBlack,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // status
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: status == 'Completed'
                    ? Pallete.completeGreenContainer
                    : status == 'Cancelled'
                        ? Pallete.cancelledRedContainer
                        : Pallete.processingOrangeContainer,
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: status == 'Completed'
                      ? Pallete.completeGreen
                      : status == 'Cancelled'
                          ? Pallete.cancelledRed
                          : Pallete.processingOrange,
                  fontSize: 8.75.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
