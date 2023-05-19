// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class NavBarWidget extends StatelessWidget {
  final String icon;
  final Color? color;
  final Color? iconColor;
  final String label;
  final FontWeight? fontWeight;
  final void Function()? onTap;
  const NavBarWidget({
    Key? key,
    required this.icon,
    this.color,
    this.iconColor,
    required this.label,
    this.fontWeight,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: SizedBox(
          width: 60.w,
          child: Column(
            children: [
              //! ICON
              SvgPicture.asset(
                icon.svg,
                color: iconColor,
                height: 22.h,
                width: 22.w,
              ),

              //! SPACER
              8.4.sbH,

              //! LABEL
              Text(
                label,
                style: TextStyle(
                  color: color ?? Pallete.blackColor,
                  fontWeight: fontWeight ?? FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      );
}
