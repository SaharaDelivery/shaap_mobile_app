// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class ProfileDetailsWidget extends StatelessWidget {
  final String title;
  final String content;
  final Color? color;
  final Color? contentColor;
  const ProfileDetailsWidget({
    Key? key,
    required this.title,
    required this.content,
    this.color,
    this.contentColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Pallete.textGreydarker,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        6.sbH,
        Container(
          height: 40.h,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Pallete.tileBorderGrey,
            ),
            color: color ?? Pallete.whiteColor
          ),
          child: Text(
            content,
            style: TextStyle(
              color: contentColor ?? Pallete.textBlack,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
