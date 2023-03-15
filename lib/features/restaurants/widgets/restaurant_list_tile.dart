// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class RestaurantListTile extends StatelessWidget {
  final String? image;
  final String? name;
  final String? description;
  final double? price;
  final void Function()? onTap;
  const RestaurantListTile({
    Key? key,
    this.image,
    this.name,
    this.description,
    this.price,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: 99.h,
        width: double.infinity,
        padding: 10.padH,
        margin: EdgeInsets.only(bottom: 19.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Pallete.dividerGreyColor,
            )),
        child: Center(
          child: Row(
            children: [
              Container(
                height: 78.h,
                width: 83.6.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image ?? 'food-3'.png),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              8.sbW,
              SizedBox(
                height: 82.h,
                width: 210.w,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            name ?? 'Zinger Burger Combo',
                            style: TextStyle(
                              color: Pallete.textBlack,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            description ??
                                'zinger burger, 1 pc chicken, regular chips  and pepsi or water',
                            maxLines: 2,
                            style: TextStyle(
                              height: 1.2,
                              overflow: TextOverflow.ellipsis,
                              color: Pallete.textGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${AppTexts.naira} $price',
                            style: TextStyle(
                              color: Pallete.textBlack,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
