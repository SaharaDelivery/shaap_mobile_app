import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaap_mobile_app/features/items/widgets/amount_details_widget.dart';
import 'package:shaap_mobile_app/features/items/widgets/order_summary_tile.dart';
import 'package:shaap_mobile_app/features/items/widgets/payment_mode_tile.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class CheckoutBottomSheet extends ConsumerWidget {
  const CheckoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<int> selected = ValueNotifier(0);

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
      child: Column(
        children: [
          //! header, go back
          Container(
            height: 70.h,
            width: width(context),
            padding: 24.padH,
            child: Center(
              child: Row(
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
                    'Checkout',
                    style: TextStyle(
                      color: Pallete.textBlack,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  32.sbW,
                ],
              ),
            ),
          ),
          //! body
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  10.sbH,
                  //! delivery location
                  Padding(
                    padding: 24.padH,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppTexts.deliveryLocation,
                          style: TextStyle(
                            color: Pallete.textBlack,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          AppTexts.edit,
                          style: TextStyle(
                            color: Pallete.yellowColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  17.sbH,
                  // for address
                  Container(
                    height: 56.h,
                    width: double.infinity,
                    margin: 24.padH,
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Pallete.borderGrey)),
                    child: Row(
                      children: [
                        SvgPicture.asset('llocation'.svg),
                        12.sbW,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '15,anthony,oregun,ikeja,lagos nigeria',
                              style: TextStyle(
                                color: Pallete.textBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '15,anthony,oregun,ikeja,lagos nigeria',
                              style: TextStyle(
                                color: Pallete.textGreylighter,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  17.sbH,

                  //! delivery time
                  Container(
                    height: 56.h,
                    width: double.infinity,
                    margin: 24.padH,
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Pallete.borderGrey)),
                    child: Row(
                      children: [
                        SvgPicture.asset('bike'.svg),
                        12.sbW,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppTexts.deliveryTime,
                              style: TextStyle(
                                color: Pallete.textGreylighter,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '10-20 mims',
                              style: TextStyle(
                                color: Pallete.textBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  30.sbH,

                  //! order summary
                  Padding(
                    padding: 24.padH,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppTexts.orderSum,
                          style: TextStyle(
                            color: Pallete.textBlack,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          AppTexts.addItems,
                          style: TextStyle(
                            color: Pallete.yellowColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  17.sbH,
                  Padding(
                    padding: 24.padH,
                    child: const OrderSummaryTile(),
                  ),
                  24.sbH,

                  //! promo code
                  Container(
                    height: 36.h,
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 9.6.w, right: 15.w),
                    margin: 24.padH,
                    decoration: BoxDecoration(
                      color: Pallete.newGrey,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset('promo'.svg),
                        17.sbW,
                        Text(
                          AppTexts.promoCode,
                          style: TextStyle(
                            color: Pallete.textBlack,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),

                  23.sbH,
                  //! dotted line
                  const DottedLine(
                    dashColor: Pallete.dividerGreyColor,
                  ),
                  //! payment details
                  AmountDetailsWidget(),
                  const DottedLine(
                    dashColor: Pallete.dividerGreyColor,
                  ),

                  16.sbH,
                  //! paymemt method
                  ValueListenableBuilder(
                      valueListenable: selected,
                      child: const SizedBox.shrink(),
                      builder: (context, value, child) {
                        return Padding(
                          padding: 24.padH,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    AppTexts.paymentMethod,
                                    style: TextStyle(
                                      color: Pallete.textBlack,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              15.sbH,
                              PaymentModeTile(
                                icon: 'card',
                                method: AppTexts.onlinepayment,
                                onTap: () {
                                  selected.value = 1;
                                },
                                color: selected.value == 1
                                    ? Pallete.yellowColor
                                    : Pallete.whiteColor,
                                borderColor: selected.value == 2
                                    ? Pallete.yellowColor
                                    : Pallete.dividerGreyColor,
                              ),
                              15.sbH,
                              PaymentModeTile(
                                icon: 'cash',
                                method: AppTexts.cash,
                                onTap: () {
                                  selected.value = 2;
                                },
                                color: selected.value == 2
                                    ? Pallete.yellowColor
                                    : Pallete.whiteColor,
                                borderColor: selected.value == 2
                                    ? Pallete.yellowColor
                                    : Pallete.dividerGreyColor,
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),

          // check out button
          Container(
            height: 90.h,
            width: width(context),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Pallete.dividerGreyColor,
                  width: 1.5,
                ),
              ),
            ),
            child: Center(
              child: BButton(
                onTap: () {},
                width: 327.w,
                text: 'Place order for ${AppTexts.naira}4500',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
