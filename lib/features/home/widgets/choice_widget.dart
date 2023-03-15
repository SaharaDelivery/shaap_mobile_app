// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shaap_mobile_app/theme/palette.dart';

class ChoiceWidget extends ConsumerWidget {
  final void Function()? onTap;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  const ChoiceWidget({
    super.key,
    this.onTap,
    required this.borderColor,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        margin: EdgeInsets.only(right: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
    ;
  }
}
