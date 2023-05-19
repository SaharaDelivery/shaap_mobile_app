import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaap_mobile_app/features/auth/controllers/auth_controller.dart';
import 'package:shaap_mobile_app/features/items/widgets/amount_details_widget.dart';
import 'package:shaap_mobile_app/features/items/widgets/order_summary_tile.dart';
import 'package:shaap_mobile_app/features/items/widgets/payment_mode_tile.dart';
import 'package:shaap_mobile_app/features/orders/controllers/order_controller.dart';
import 'package:shaap_mobile_app/features/profile/controllers/profile_controller.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/app_multi_value_listenable_builder.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/error_text.dart';
import 'package:shaap_mobile_app/utils/loader.dart';
import 'package:shaap_mobile_app/utils/nav.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/text_input.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class CheckoutBottomSheet extends ConsumerStatefulWidget {
  final String orderId;
  const CheckoutBottomSheet({
    super.key,
    required this.orderId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends ConsumerState<CheckoutBottomSheet> {
  final ValueNotifier<String> address_1 = ValueNotifier('');
  final ValueNotifier<String> address_2 = ValueNotifier('');
  final TextEditingController _generalAreaController = TextEditingController();
  final TextEditingController _specificController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    // String address_1 = '';
    // String address_2 = '';
    final ValueNotifier<int> selected = ValueNotifier(0);
    final orderDetailsFuture =
        ref.watch(getOrderDetailsProvider(widget.orderId));
    final ValueNotifier<int> quantity = ValueNotifier(0);
    final ValueNotifier<int> addCount = ValueNotifier(0);
    int? cartItemId;
    final isLoading = ref.watch(orderControllerProvider);
    final addressesFuture = ref.watch(getUsersSavedAddressProvider);

    void addAddress({
      required WidgetRef ref,
      required String address_1,
      required String address_2,
      required String phone_number,
      required String email,
    }) {
      ref.watch(profileControllerProvider.notifier).addtemporaryAddress(
            context: context,
            address_1: address_1,
            address_2: address_2,
            phone_number: phone_number,
            email: email,
          );
    }

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
            child: orderDetailsFuture.when(
              data: (order) {
                return SingleChildScrollView(
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
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Wrap(
                                        children: [
                                          Container(
                                            // height: 250.h,
                                            // padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Pallete.whiteColor,
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                top: Radius.circular(30.r),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                30.sbH,
                                                addressesFuture.when(
                                                  data: (addresses) {
                                                    if (addresses.isEmpty) {
                                                      return const ErrorText(
                                                        error:
                                                            'You have no saved address',
                                                      );
                                                    }

                                                    return Column(
                                                        children: List.generate(
                                                            addresses.length,
                                                            (index) => InkWell(
                                                                onTap: () {
                                                                  address_2
                                                                      .value = addresses[
                                                                          index]
                                                                      .address_2;
                                                                  address_1
                                                                      .value = addresses[
                                                                          index]
                                                                      .address_1;

                                                                  address_1
                                                                      .notifyListeners();
                                                                  address_2
                                                                      .notifyListeners();

                                                                  log(address_1
                                                                      .value);
                                                                },
                                                                child:
                                                                    Container(
                                                                        height: 56
                                                                            .h,
                                                                        width: double
                                                                            .infinity,
                                                                        margin: EdgeInsets.symmetric(horizontal: 24.w).copyWith(
                                                                            bottom: 16
                                                                                .h),
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical: 8
                                                                                .h,
                                                                            horizontal: 12
                                                                                .w),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.r),
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
                                                                                  addresses[index].address_2,
                                                                                  style: TextStyle(
                                                                                    color: Pallete.textBlack,
                                                                                    fontSize: 14.sp,
                                                                                    fontWeight: FontWeight.w400,
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  addresses[index].address_1,
                                                                                  style: TextStyle(
                                                                                    color: Pallete.textGreylighter,
                                                                                    fontSize: 12.sp,
                                                                                    fontWeight: FontWeight.w400,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        )))));
                                                  },
                                                  error: (error, stactrace) {
                                                    log(error.toString());
                                                    return ErrorText(
                                                        error:
                                                            error.toString());
                                                  },
                                                  loading: () => const Loader(),
                                                ),
                                                10.sbH,

                                                //! add temporary address
                                                Text(
                                                  'Add temporary address',
                                                  style: TextStyle(
                                                    color: Pallete.textBlack,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                20.sbH,

                                                //! input fields
                                                Padding(
                                                  padding: 24.padH,
                                                  child: TextInputWidget(
                                                    hintText: '15B, Jhn Street',
                                                    inputTitle: 'Specific Area',
                                                    controller:
                                                        _specificController,
                                                  ),
                                                ),
                                                24.sbH,
                                                Padding(
                                                  padding: 24.padH,
                                                  child: TextInputWidget(
                                                    hintText:
                                                        ' Doe Estate, Lokogoma',
                                                    inputTitle: 'General Area',
                                                    controller:
                                                        _generalAreaController,
                                                  ),
                                                ),

                                                20.sbH,

                                                // isLoading
                                                //     ? const Loader()
                                                //     :
                                                Padding(
                                                  padding: 24.padH,
                                                  child: BButton(
                                                    onTap: () {
                                                      if (_specificController
                                                              .text
                                                              .isNotEmpty &&
                                                          _generalAreaController
                                                              .text
                                                              .isNotEmpty) {
                                                        address_2.value =
                                                            _specificController
                                                                .text;

                                                        address_1.value =
                                                            _generalAreaController
                                                                .text;

                                                        address_1
                                                            .notifyListeners();
                                                        address_2
                                                            .notifyListeners();
                                                        
                                                        _specificController.clear();
                                                        _generalAreaController.clear();
                                                        goBack(context);

                                                        log(address_1.value);
                                                      }
                                                    },
                                                    text: 'Use Address',
                                                  ),
                                                ),

                                                40.sbH,
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Text(
                                AppTexts.edit,
                                style: TextStyle(
                                  color: Pallete.yellowColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      17.sbH,
                      // for address
                      addressesFuture.when(
                        data: (addresses) {
                          if (addresses.isNotEmpty) {
                            address_1.value = addresses[0].address_1;
                            address_2.value = addresses[0].address_2;
                          }

                          if (addresses.isEmpty) {
                            return Container(
                              height: 56.h,
                              width: double.infinity,
                              margin: 24.padH,
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 12.w,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border:
                                      Border.all(color: Pallete.borderGrey)),
                              child: Row(
                                children: [
                                  SvgPicture.asset('llocation'.svg),
                                  12.sbW,
                                  Text(
                                    'You have no saved address',
                                    style: TextStyle(
                                      color: Pallete.textBlack,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return AppMultiListenableProvider(
                              firstValue: address_1,
                              secondValue: address_2,
                              child: const SizedBox.shrink(),
                              builder:
                                  (context, firstValue, secondValue, child) {
                                return Container(
                                  height: 56.h,
                                  width: double.infinity,
                                  margin: 24.padH,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8.h,
                                    horizontal: 12.w,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                          color: Pallete.borderGrey)),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset('llocation'.svg),
                                      12.sbW,
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            address_2.value,
                                            style: TextStyle(
                                              color: Pallete.textBlack,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            address_1.value,
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
                                );
                              });
                        },
                        error: (error, stactrace) {
                          log(error.toString());
                          return ErrorText(error: error.toString());
                        },
                        loading: () => const Loader(),
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
                            InkWell(
                              onTap: () {
                                goBack(context);
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Text(
                                AppTexts.addItems,
                                style: TextStyle(
                                  color: Pallete.yellowColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      17.sbH,
                      Padding(
                        padding: 24.padH,
                        child: ref
                            .watch(getAllCartItemsProvider(widget.orderId))
                            .when(
                              data: (cartList) {
                                return Column(
                                  children: List.generate(
                                    cartList.length,
                                    (index) => OrderSummaryTile(
                                      onTap: () {
                                        log(cartList[index]
                                            .cartItemId
                                            .toString());
                                      },
                                      menuItem:
                                          order.orderItem[index].cartItemId,
                                      orderId: widget.orderId,
                                      cartItemId: cartList[index].cartItemId,
                                      name: cartList[index].name,
                                      price: cartList[index].price,
                                      quantity: cartList[index].quantity,
                                      imageUrl: cartList[index].imageUrl,
                                    ),
                                  ),
                                );
                              },
                              error: (error, stactrace) {
                                log(error.toString());
                                return ErrorText(error: error.toString());
                              },
                              loading: () => const Loader(),
                            ),

                        // const OrderSummaryTile(),
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
                            const Icon(Icons.arrow_forward_ios_rounded)
                          ],
                        ),
                      ),

                      23.sbH,
                      //! dotted line
                      const DottedLine(
                        dashColor: Pallete.dividerGreyColor,
                      ),
                      //! payment details
                      const AmountDetailsWidget(),
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
                        },
                      ),
                      20.sbH,
                    ],
                  ),
                );
              },
              error: (error, stactrace) {
                log(error.toString());
                return ErrorText(error: error.toString());
              },
              loading: () => const Loader(),
            ),
          ),

          // check out button
          orderDetailsFuture.when(
            data: (data) {
              return Container(
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
              );
            },
            error: (error, stactrace) {
              log(error.toString());
              return ErrorText(error: error.toString());
            },
            loading: () => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
