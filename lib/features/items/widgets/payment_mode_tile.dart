// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class PaymentModeTile extends ConsumerWidget {
  final String icon;
  final String method;
  final Color color;
  final Color borderColor;
  final void Function()? onTap;
  const PaymentModeTile({
    super.key,
    required this.icon,
    required this.method,
    required this.color,
    required this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 36.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 10.5.w,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Pallete.borderGrey)),
      child: Row(
        children: [
          SvgPicture.asset(icon.svg),
          10.5.sbW,
          Text(
            method,
            style: TextStyle(
              color: Pallete.textBlack,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: Container(
              height: 20.h,
              width: 20.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: borderColor,
                ),
              ),
              child: Center(
                child: Icon(
                  PhosphorIcons.checkBold,
                  size: 15.sp,
                  color: Pallete.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
