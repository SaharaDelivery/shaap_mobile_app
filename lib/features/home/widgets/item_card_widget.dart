// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class ItemCardWidget extends StatelessWidget {
  final bool isFeatured;
  final String name;
  final String stars;
  final String image;
  const ItemCardWidget({
    Key? key,
    required this.isFeatured,
    required this.name,
    required this.stars,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isFeatured == true ? 311.h : 253.h,
      width: isFeatured == true ? 327.w : 233.w,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(right: isFeatured == true ? 0 : 19.w),
      decoration: BoxDecoration(
        border: Border.all(color: Pallete.dividerGreyColor),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          Container(
            height: isFeatured == true ? 201.h : 143.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Pallete.blackColor,
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //! name - location
          Text(
            name,
            style: TextStyle(
              color: Pallete.textBlack,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

          //! stars
          Row(
            children: [
              Image.asset('star'.png, height: 14.h),
              4.sbW,
              RichText(
                text: TextSpan(
                  text: '$stars ',
                  style: TextStyle(
                    color: Pallete.textGrey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: '(2.4k)',
                      style: TextStyle(
                        color: Pallete.textGreylighter,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // price - fee
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: '${AppTexts.naira} 1000',
                  style: TextStyle(
                    color: Pallete.textGrey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: ' Delivery fee',
                      style: TextStyle(
                        color: Pallete.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              4.sbW,
              CircleAvatar(
                backgroundColor: Pallete.textGrey,
                radius: 2.r,
              ),
              4.sbW,
              Text(
                '10-20 min',
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
    );
  }
}
