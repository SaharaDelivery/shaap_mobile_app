// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

import '../../../theme/palette.dart';

class ProfileTile extends StatelessWidget {
  final String icon;
  final String title;
  final void Function()? onTap;
  final Color? borderColor;
  final Color? titleColor;
  final Color? fillColor;
  final Color? arrowColor;
  const ProfileTile({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
    this.borderColor,
    this.titleColor,
    this.fillColor,
    this.arrowColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 44.h,
        width: double.infinity,
        padding: EdgeInsets.only(left: 13.w, right: 20.w),
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: fillColor ?? Pallete.whiteColor,
          border: Border.all(
            color: borderColor ?? Pallete.tileBorderGrey,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon.svg),
            18.sbW,
            Text(
              title,
              style: TextStyle(
                color: titleColor ?? Pallete.textBlack,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: arrowColor ?? Pallete.textGrey,
              size: 17.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class FaqsTile extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const FaqsTile({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 44.h,
        width: double.infinity,
        padding: EdgeInsets.only(left: 13.w, right: 20.w),
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: Pallete.whiteColor,
          border: Border.all(
            color: Pallete.tileBorderGrey,
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Pallete.textBlack,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Pallete.textGrey,
              size: 17.sp,
            ),
          ],
        ),
      ),
    );
  }
}
