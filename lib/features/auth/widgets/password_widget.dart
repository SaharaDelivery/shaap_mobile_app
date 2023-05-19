import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class PasswordWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? colorUppercase;
  final Color? colorLowercase;
  final Color? colorSymbol;
  final Color? colorNumbers;
  final Color? colorLength;
  final IconData? iconUppercase;
  final IconData? iconLowercase;
  final IconData? iconSymbol;
  final IconData? iconNumbers;
  final IconData? iconLength;
  final FontWeight? fontWeightUppercase;
  final FontWeight? fontWeightLowercase;
  final FontWeight? fontWeightSymbol;
  final FontWeight? fontWeightNumbers;
  final FontWeight? fontWeightLength;
  const PasswordWidget(
      {super.key,
      this.height,
      this.width,
      this.colorUppercase,
      this.colorLowercase,
      this.colorSymbol,
      this.colorNumbers,
      this.iconUppercase,
      this.iconLowercase,
      this.iconSymbol,
      this.iconNumbers,
      this.fontWeightUppercase,
      this.fontWeightLowercase,
      this.fontWeightSymbol,
      this.fontWeightNumbers,
      this.colorLength,
      this.iconLength,
      this.fontWeightLength});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      height: height,
      width: width,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            8.sbH,
            Row(
              children: [
                SizedBox(
                  width: 100.w,
                  child: Row(
                    children: [
                      Icon(
                        iconLowercase,
                        size: 15.sp,
                        color: colorLowercase,
                      ),
                      3.sbW,
                      Text(
                        'Lowercase',
                        style: TextStyle(
                          color: colorLowercase,
                          fontSize: 12.sp,
                          fontWeight: fontWeightLowercase,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100.w,
                  child: Row(
                    children: [
                      Icon(
                        iconUppercase,
                        size: 15.sp,
                        color: colorUppercase,
                      ),
                      3.sbW,
                      Text(
                        'Uppercase',
                        style: TextStyle(
                          color: colorUppercase,
                          fontSize: 12.sp,
                          fontWeight: fontWeightUppercase,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      iconLength,
                      size: 15.sp,
                      color: colorLength,
                    ),
                    3.sbW,
                    Text(
                      '8 or more *',
                      style: TextStyle(
                        color: colorLength,
                        fontSize: 12.sp,
                        fontWeight: fontWeightLength,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            8.sbH,
            Row(
              children: [
                SizedBox(
                  width: 100.w,
                  child: Row(
                    children: [
                      Icon(
                        iconNumbers,
                        size: 15.sp,
                        color: colorNumbers,
                      ),
                      3.sbW,
                      Text(
                        'Numbers',
                        style: TextStyle(
                          color: colorNumbers,
                          fontSize: 12.sp,
                          fontWeight: fontWeightNumbers,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      iconSymbol,
                      size: 15.sp,
                      color: colorSymbol,
                    ),
                    3.sbW,
                    Text(
                      'Symbols',
                      style: TextStyle(
                        color: colorSymbol,
                        fontSize: 12.sp,
                        fontWeight: fontWeightSymbol,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
