// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class OrderSummaryTile extends ConsumerWidget {
  final String name;
  final int quantity;
  final String imageUrl;
  final String price;
  const OrderSummaryTile({
    super.key,
    required this.name,
    required this.quantity,
    required this.imageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: EdgeInsets.all(10.w),
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Pallete.borderGrey),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 37.h,
            width: 39.67.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black12.withOpacity(0.1),
                        Colors.black12.withOpacity(0.1),
                        Colors.black26,
                        Colors.black26,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .shimmer(duration: 1200.ms),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),

          15.sbW,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: Pallete.textBlack,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                '${AppTexts.naira} $price',
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
            height: 40.h,
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
                    height: 24.h,
                    width: 24.w,
                    isText: false,
                    radius: 3.r,
                    item: Icon(
                      PhosphorIcons.minusBold,
                      color: Colors.black,
                      size: 12.sp,
                    ),
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(
                      color: Pallete.blackColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TransparentButton(
                    onTap: () {},
                    height: 24.h,
                    width: 24.w,
                    isText: false,
                    radius: 3.r,
                    item: Icon(
                      PhosphorIcons.plusBold,
                      color: Colors.black,
                      size: 12.sp,
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
