import 'dart:developer' as log;
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shaap_mobile_app/features/orders/controllers/order_controller.dart';
import 'package:shaap_mobile_app/features/restaurants/controllers/restaurants_comtroller.dart';
import 'package:shaap_mobile_app/models/food_model.dart';
import 'package:shaap_mobile_app/models/order_item_model.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/utils/app_fade_animation.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/error_text.dart';
import 'package:shaap_mobile_app/utils/loader.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

import '../../../theme/palette.dart';

class ItemDetailsBottomSheet extends ConsumerStatefulWidget {
  final int restaurantId;
  final FoodModel food;
  const ItemDetailsBottomSheet({
    super.key,
    required this.restaurantId,
    required this.food,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ItemDetailsBottomSheetState();
}

class _ItemDetailsBottomSheetState extends ConsumerState<ItemDetailsBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final ValueNotifier<int> selected = ValueNotifier(0);
  final ValueNotifier<int> quantity = ValueNotifier(0);
  final ValueNotifier<int> addCount = ValueNotifier(0);
  int? cartItemId;
  final double increase = 1200;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void createOrder({
    required WidgetRef ref,
    required BuildContext context,
    required int menuItemId,
    required int quantity,
  }) {
    ref.read(orderControllerProvider.notifier).createAnOrder(
          context: context,
          restaurantId: widget.restaurantId,
          menuItemId: menuItemId,
          quantity: quantity,
        );
  }

  void increaseItemInCart({
    required WidgetRef ref,
    required BuildContext context,
    required String orderId,
    required int menuItemId,
    required int quantity,
  }) {
    ref
        .read(orderControllerProvider.notifier)
        .increaseItemInCartAddItemToExistingCart(
          context: context,
          orderId: orderId,
          menuItemId: menuItemId,
          quantity: quantity,
        );
  }

  void reduceItemQuantityInCart({
    required WidgetRef ref,
    required BuildContext context,
    required String cartItemId,
  }) {
    ref.read(orderControllerProvider.notifier).reduceItemInCart(
          context: context,
          cartItemId: cartItemId,
        );
  }

  @override
  Widget build(BuildContext context) {
    final checkForOrdersFuture = ref.watch(
        checkIfOrderExistsInRestaurantProvider(widget.restaurantId.toString()));
    final isLoading = ref.watch(orderControllerProvider);

    // if (isLoading) {
    //   _controller.repeat();
    // } else {
    //   _controller.stop();
    // }

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
        child:
            //  isLoading
            //     ? const Loader()
            //     :
            Column(
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
                  widget.food.name,
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
                  imageUrl: widget.food.image,
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
                widget.food.name,
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
                '${AppTexts.naira} ${widget.food.price}',
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
                  widget.food.description,
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
                'Choose your ${widget.food.name}',
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
                                widget.food.name,
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
                                      text: widget.food.name,
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
                checkForOrdersFuture.when(
                  data: (orderId) {
                    if (orderId != 'notfound') {
                      return ref.watch(getAllCartItemsProvider(orderId)).when(
                            data: (cartList) {
                              bool exists = false;
                              // log(cartList.toString());

                              for (OrderItemModel item in cartList) {
                                if (item.name == widget.food.name) {
                                  quantity.value = item.quantity;
                                  cartItemId = item.cartItemId;
                                  exists = true;
                                  break;
                                }
                              }

                              log.log(cartItemId.toString());

                              if (exists) {
                                return ValueListenableBuilder(
                                  valueListenable: quantity,
                                  builder: (context, value, child) {
                                    return AppFadeAnimation(
                                      delay: 0.5,
                                      child: Container(
                                        height: 65.h,
                                        width: 180.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            border: Border.all(
                                                color:
                                                    Pallete.dividerGreyColor)),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              TransparentButton(
                                                onTap: () {
                                                  if (quantity.value > 0) {
                                                    reduceItemQuantityInCart(
                                                      ref: ref,
                                                      context: context,
                                                      cartItemId: cartItemId!
                                                          .toString(),
                                                    );
                                                    refreshProvider(
                                                        ref,
                                                        getAllCartItemsProvider(
                                                            orderId));
                                                    quantity.value--;
                                                    addCount.value--;
                                                  }
                                                },
                                                height: 40.h,
                                                width: 40.w,
                                                isText: false,
                                                item: Icon(
                                                  PhosphorIcons.minusBold,
                                                  color: Colors.black,
                                                  size: 16.sp,
                                                ),
                                              ),
                                              isLoading
                                                  ? const NLoader()
                                                  : Text(
                                                      quantity.value.toString(),
                                                      style: TextStyle(
                                                        color:
                                                            Pallete.blackColor,
                                                        fontSize: 19.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ).animate().scale(
                                                      duration: 500.ms,
                                                      begin: 0,
                                                      end: 1),
                                              TransparentButton(
                                                onTap: () {
                                                  quantity.value++;
                                                  addCount.value++;
                                                  log.log(addCount.value
                                                      .toString());
                                                  increaseItemInCart(
                                                    ref: ref,
                                                    context: context,
                                                    orderId: orderId,
                                                    menuItemId: widget.food.id,
                                                    quantity: 1,
                                                  );
                                                  refreshProvider(
                                                      ref,
                                                      getAllCartItemsProvider(
                                                          orderId));
                                                },
                                                height: 40.h,
                                                width: 40.w,
                                                isText: false,
                                                item: Icon(
                                                  PhosphorIcons.plusBold,
                                                  color: Colors.black,
                                                  size: 16.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ).animate().fadeIn(),
                                    );
                                  },
                                  child: const SizedBox.shrink(),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                            error: (error, stactrace) {
                              log.log(error.toString());
                              return ErrorText(error: error.toString());
                            },
                            loading: () => const SizedBox.shrink(),
                            // loading: () => const Loader(),
                          );
                    }

                    return const SizedBox.shrink();
                  },
                  error: (error, stactrace) {
                    log.log(error.toString());
                    return ErrorText(error: error.toString());
                  },
                  loading: () => const Loader(),
                ),

                //! add
                checkForOrdersFuture.when(
                  data: (orderId) {
                    //! if there is an order open in the restaurant
                    // if (orderId != 'notfound') {
                    //   return const SizedBox.shrink();
                    // }

                    return ref.watch(getAllCartItemsProvider(orderId)).when(
                          data: (cartList) {
                            bool exists = false;
                            // log(cartList.toString());

                            for (OrderItemModel item in cartList) {
                              if (item.name == widget.food.name) {
                                quantity.value = item.quantity;
                                cartItemId = item.cartItemId;
                                exists = true;
                                break;
                              }
                            }

                            if (!exists) {
                              return AppFadeAnimation(
                                delay: 0.5,
                                child: isLoading
                                    ? SizedBox(
                                        height: 50.h,
                                        width: 178.w,
                                        child: const NLoader())
                                    : BButton(
                                        onTap: () {
                                          refreshProvider(ref,
                                              getAllCartItemsProvider(orderId));
                                          if (!exists) {
                                            increaseItemInCart(
                                              ref: ref,
                                              context: context,
                                              orderId: orderId,
                                              menuItemId: widget.food.id,
                                              quantity: 1,
                                            );
                                          } else {
                                            createOrder(
                                              ref: ref,
                                              context: context,
                                              menuItemId: widget.food.id,
                                              quantity: 1,
                                            );
                                          }
                                        },
                                        color: Pallete.yellowColor,
                                        height: 50.h,
                                        width: 178.w,
                                        text:
                                            'Add ${AppTexts.naira}${widget.food.price}',
                                      ),
                              );
                            }

                            return const SizedBox.shrink();
                          },
                          error: (error, stactrace) {
                            log.log(error.toString());
                            return ErrorText(error: error.toString());
                          },
                          loading: () => const SizedBox.shrink(),
                          // loading: () => const Loader(),
                        );

                    //! if there are is no order open in the restaurant
                  },
                  error: (error, stactrace) {
                    log.log(error.toString());
                    return ErrorText(error: error.toString());
                  },
                  loading: () => const Loader(),
                ),
                // ValueListenableBuilder(
                //     valueListenable: selected,
                //     child: const SizedBox.shrink(),
                //     builder: (context, value, child) {
                //       return BButton(
                //         onTap: () {
                //           createOrder(
                //             ref: ref,
                //             context: context,
                //             menuItemId: food.id,
                //             quantity: 1,
                //           );
                //           // showModalBottomSheet(
                //           //   backgroundColor: Colors.transparent,
                //           //   barrierColor: Colors.black.withOpacity(0.25),
                //           //   isScrollControlled: true,
                //           //   context: context,
                //           //   builder: (context) => Wrap(
                //           //     children: [
                //           //       CheckoutBottomSheet(),
                //           //     ],
                //           //   ),
                //           // );
                //         },
                //         color: Pallete.yellowColor,
                //         height: 50.h,
                //         width: 178.w,
                //         text: selected.value == 2
                //             ? 'Add ${AppTexts.naira}${food.price} + increase}'
                //             : 'Add ${AppTexts.naira}${food.price}',
                //       );
                //     }),
              ],
            ),
            40.sbH
          ],
        ),
      ),
    );
  }
}

void refreshProvider(WidgetRef ref, ProviderOrFamily provider) {
  ref.invalidate(provider);
}
