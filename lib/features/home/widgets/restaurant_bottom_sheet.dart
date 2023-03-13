import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class RestaurantBottomSheet extends ConsumerStatefulWidget {
  const RestaurantBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RestaurantBottomSheetState();
}

class _RestaurantBottomSheetState extends ConsumerState<RestaurantBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(context),
      width: width(context),
      child: Stack(
        children: [
          // simulating the back
          Align(
            alignment: const Alignment(0, -0.85),
            child: Container(
              height: 70.h,
              width: 338.w,
              decoration: BoxDecoration(
                color: Pallete.whiteColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),

          //! the content
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height(context) * 0.913,
              width: width(context),
              decoration: BoxDecoration(
                color: Pallete.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: NestedScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: Colors.transparent,
                          floating: true,
                          snap: true,
                          expandedHeight: 172.h,
                          flexibleSpace: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.r),
                                    topRight: Radius.circular(16.r),
                                  ),
                                  child: Image.asset(
                                    'food-1'.png,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const Alignment(0, -0.6),
                                child: Padding(
                                  padding: 24.padH,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // leave
                                      InkWell(
                                        onTap: () =>
                                            Navigator.of(context).pop(),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          clipBehavior: Clip.antiAlias,
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: Container(
                                              height: 32.h,
                                              width: 32.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                color: Colors.white
                                                    .withOpacity(0.4),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.arrow_back,
                                                  color: Pallete.whiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      //! search
                                      InkWell(
                                        onTap: () {},
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          clipBehavior: Clip.antiAlias,
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: Container(
                                              height: 32.h,
                                              width: 32.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                color: Colors.white
                                                    .withOpacity(0.4),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  PhosphorIcons.bicycle,
                                                  color: Pallete.whiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 16.h,
                          ),
                          height: 134.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //! name - location
                              Text(
                                'KFC Nigeria - Ikeja',
                                style: TextStyle(
                                  color: Pallete.textBlack,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              //! opens
                              Text(
                                'Opens today at 8 am',
                                style: TextStyle(
                                  color: Pallete.textBlack,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              //! stars
                              Row(
                                children: [
                                  Image.asset('star'.png, height: 14.h),
                                  4.sbW,
                                  RichText(
                                    text: TextSpan(
                                      text: '4.5 ',
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

                              // price - delivery
                              Row(
                                children: [
                                  Icon(
                                    PhosphorIcons.clockBold,
                                    size: 16.sp,
                                  ),
                                  4.sbW,
                                  Text(
                                    '10-20 min',
                                    style: TextStyle(
                                      color: Pallete.textBlack,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  9.5.sbW,
                                  Icon(
                                    PhosphorIcons.bicycleBold,
                                    size: 16.sp,
                                  ),
                                  4.sbW,
                                  Text(
                                    '${AppTexts.naira} 1000 Delivery fee',
                                    style: TextStyle(
                                      color: Pallete.textBlack,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Pallete.dividerGreyColor,
                          thickness: 2,
                          endIndent: 11.w,
                        ),
                        16.sbH,
                        SizedBox(
                          height: 32.h,
                          //! TODO:
                        ),
                        16.sbH,
                        Divider(
                          color: Pallete.dividerGreyColor,
                          thickness: 2,
                          endIndent: 11.w,
                        ),
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
