// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:shaap_mobile_app/features/orders/controllers/order_controller.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/loader.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

import '../views/items_details_bottom_sheet.dart';

class OrderSummaryTile extends ConsumerStatefulWidget {
  final String orderId;
  final int cartItemId;
  final String name;
  final int quantity;
  final String imageUrl;
  final String price;
  final int menuItem;
  final void Function()? onTap;
  const OrderSummaryTile({
    super.key,
    required this.orderId,
    required this.cartItemId,
    required this.name,
    required this.quantity,
    required this.imageUrl,
    required this.price,
    required this.menuItem,
    this.onTap,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderSummaryTileState();
}

class _OrderSummaryTileState extends ConsumerState<OrderSummaryTile> {
  final ValueNotifier<int> _quantity = ValueNotifier(0);
  final ValueNotifier<int> _addCount = ValueNotifier(0);

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
    final isLoading = ref.watch(orderControllerProvider);
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 60.h,
        width: double.infinity,
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Pallete.borderGrey),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 37.h,
              width: 39.67.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.imageUrl,
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),

            15.sbW,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    color: Pallete.textBlack,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  '${AppTexts.naira} ${widget.price}',
                  style: TextStyle(
                    color: Pallete.textGrey,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(),
            //! add/remove
            isLoading
                ? Padding(
                  padding: EdgeInsets.only(right:20.w),
                  child: const NLoader(),
                )
                : ValueListenableBuilder(
                    valueListenable: _quantity,
                    builder: (context, value, child) {
                      _quantity.value = widget.quantity;
                      return Container(
                        height: 40.h,
                        width: 86.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.8.r),
                            border:
                                Border.all(color: Pallete.dividerGreyColor)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TransparentButton(
                                onTap: () {
                                  refreshProvider(
                                    ref,
                                    getAllCartItemsProvider(widget.orderId),
                                  );
                                  if (_quantity.value > 0) {
                                    reduceItemQuantityInCart(
                                      ref: ref,
                                      context: context,
                                      cartItemId: widget.cartItemId.toString(),
                                    );
                                    _quantity.value--;
                                    _addCount.value--;
                                  }
                                },
                                height: 24.h,
                                width: 24.w,
                                isText: false,
                                radius: 3.r,
                                item: Icon(
                                  PhosphorIcons.minusBold,
                                  color: Colors.black,
                                  size: 12.sp,
                                ),
                              ),
                              Text(
                                '${_quantity.value}',
                                style: TextStyle(
                                  color: Pallete.blackColor,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TransparentButton(
                                onTap: () {
                                  _quantity.value++;
                                  _addCount.value++;
                                  refreshProvider(ref,
                                      getAllCartItemsProvider(widget.orderId));

                                  increaseItemInCart(
                                    ref: ref,
                                    context: context,
                                    orderId: widget.orderId,
                                    menuItemId: widget.menuItem,
                                    quantity: 1,
                                  );
                                },
                                height: 24.h,
                                width: 24.w,
                                isText: false,
                                radius: 3.r,
                                item: Icon(
                                  PhosphorIcons.plusBold,
                                  color: Colors.black,
                                  size: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          ],
        ),
      ),
    );
  }
}
