// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shaap_mobile_app/models/food_model.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class RestaurantListTile extends StatelessWidget {
  final FoodModel food;
  final void Function()? onTap;
  const RestaurantListTile({
    Key? key,
    required this.food,
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
                decoration: const BoxDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: food.image,
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
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
                            food.name,
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
                            food.description,
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
                            '${AppTexts.naira} ${food.price}',
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
