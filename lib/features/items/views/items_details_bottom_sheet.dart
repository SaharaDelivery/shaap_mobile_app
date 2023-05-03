import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shaap_mobile_app/features/orders/controllers/order_controller.dart';
import 'package:shaap_mobile_app/models/food_model.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

import '../../../theme/palette.dart';

class ItemDetailsBottomSheet extends ConsumerWidget {
  final int restaurantId;
  final FoodModel food;
  const ItemDetailsBottomSheet({
    super.key,
    required this.restaurantId,
    required this.food,
  });

  void createOrder({
    required WidgetRef ref,
    required BuildContext context,
    required int menuItemId,
    required int quantity,
  }) {
    ref.read(orderControllerProvider.notifier).createAnOrder(
          context: context,
          restaurantId: restaurantId,
          menuItemId: menuItemId,
          quantity: quantity,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<int> selected = ValueNotifier(0);
    final double increase = 1200;

    // double priceInDouble = double.parse(price);

    return Container(
      height: 745.h,
      width: width(context),
      decoration: BoxDecoration(
        color: Pallete.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Padding(
        padding: 24.padH,
        child: Column(
          children: [
            15.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TransparentButton(
                  onTap: () {
                    Navigator.of(context).pop();
                    // int count = 0;
                    // Navigator.popUntil(context, (route) {
                    //   return count++ == 2;
                    // });
                  },
                  height: 32.h,
                  width: 32.h,
                  isText: false,
                  item: Icon(
                    Icons.arrow_back,
                    color: Pallete.textBlack,
                    size: 20.sp,
                  ),
                ),
                Text(
                  food.name,
                  style: TextStyle(
                    color: Pallete.textBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                32.sbW,
              ],
            ),
            25.sbH,

            // image
            Container(
              height: 170.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Pallete.grey,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
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
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  )
                      .animate(onPlay: (controller) => controller.repeat())
                      .shimmer(duration: 1200.ms),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            20.sbH,

            //! name
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                food.name,
                style: TextStyle(
                  color: Pallete.textBlack,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            5.sbH,

            //! price
            Align(
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

            19.5.sbH,
            //! description
            Container(
              height: 72.h,
              width: double.infinity,
              padding: 16.padH,
              decoration: BoxDecoration(
                color: Pallete.grey,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  food.description,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Pallete.textGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),

            19.5.sbH,
            //! CHOOSE
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Choose your ${food.name}',
                style: TextStyle(
                  color: Pallete.textGrey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            8.sbH,

            //! required
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Choose 1 item',
                  style: TextStyle(
                    color: Pallete.textGreylighter,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                12.sbW,

                //! tag
                ValueListenableBuilder(
                  valueListenable: selected,
                  child: const SizedBox.shrink(),
                  builder: (context, value, child) => selected.value != 0
                      ? Icon(
                          PhosphorIcons.checksBold,
                          color: Pallete.yellowColor,
                          size: 20.sp,
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Pallete.lightRed,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Required',
                            style: TextStyle(
                              color: Pallete.red,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                ),
              ],
            ),
            19.5.sbH,

            //! choose
            ValueListenableBuilder(
                valueListenable: selected,
                child: const SizedBox.shrink(),
                builder: (context, value, child) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w)
                        .copyWith(top: 16.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: Pallete.dividerGreyColor,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        //! 1
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  selected.value = 1;
                                },
                                child: Container(
                                  height: 24.h,
                                  width: 24.w,
                                  decoration: BoxDecoration(
                                    color: selected.value == 1
                                        ? Pallete.yellowColor
                                        : Pallete.whiteColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: selected.value == 1
                                          ? Pallete.yellowColor
                                          : Pallete.dividerGreyColor,
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
                              16.sbW,
                              Text(
                                'Zinger Burger',
                                style: TextStyle(
                                  color: Pallete.textBlack,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        //! 2
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  selected.value = 2;
                                },
                                child: Container(
                                  height: 24.h,
                                  width: 24.w,
                                  decoration: BoxDecoration(
                                    color: selected.value == 2
                                        ? Pallete.yellowColor
                                        : Pallete.whiteColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: selected.value == 2
                                          ? Pallete.yellowColor
                                          : Pallete.dividerGreyColor,
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
                              16.sbW,
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Zinger Burger',
                                      style: TextStyle(
                                        color: Pallete.textBlack,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' + ${AppTexts.naira}1200',
                                      style: TextStyle(
                                        color: Pallete.yellowColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),

            const Spacer(),
            //! cart
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //! add/remove
                Container(
                  height: 50.h,
                  width: 118.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Pallete.dividerGreyColor)),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TransparentButton(
                          onTap: () {},
                          height: 25.h,
                          width: 25.w,
                          isText: false,
                          item: Icon(
                            PhosphorIcons.minusBold,
                            color: Colors.black,
                            size: 13.sp,
                          ),
                        ),
                        Text(
                          '1',
                          style: TextStyle(
                            color: Pallete.blackColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TransparentButton(
                          onTap: () {},
                          height: 25.h,
                          width: 25.w,
                          isText: false,
                          item: Icon(
                            PhosphorIcons.plusBold,
                            color: Colors.black,
                            size: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //! add
                ValueListenableBuilder(
                    valueListenable: selected,
                    child: const SizedBox.shrink(),
                    builder: (context, value, child) {
                      return BButton(
                        onTap: () {
                          createOrder(
                            ref: ref,
                            context: context,
                            menuItemId: food.id,
                            quantity: 1,
                          );
                          // showModalBottomSheet(
                          //   backgroundColor: Colors.transparent,
                          //   barrierColor: Colors.black.withOpacity(0.25),
                          //   isScrollControlled: true,
                          //   context: context,
                          //   builder: (context) => Wrap(
                          //     children: [
                          //       CheckoutBottomSheet(),
                          //     ],
                          //   ),
                          // );
                        },
                        color: Pallete.yellowColor,
                        height: 50.h,
                        width: 178.w,
                        text: selected.value == 2
                            ? 'Add ${AppTexts.naira}${food.price} + increase}'
                            : 'Add ${AppTexts.naira}${food.price}',
                      );
                    }),
              ],
            ),
            40.sbH
          ],
        ),
      ),
    );
  }
}
