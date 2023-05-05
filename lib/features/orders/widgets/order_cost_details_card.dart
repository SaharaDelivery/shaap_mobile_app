// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:shaap_mobile_app/models/order_model.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/type_defs.dart';
import 'package:shaap_mobile_app/utils/utils.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class OrderCostDetailsCard extends ConsumerWidget {
  final OrderModel order;
  const OrderCostDetailsCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: 24.padH,
      padding: EdgeInsets.all(14.w),
      height: 210.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Pallete.dividerGreyColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //! order id, copy
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Id',
                    style: TextStyle(
                      color: Pallete.textBlack,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  4.sbH,
                  SizedBox(
                    width: 250.w,
                    child: Text(
                      order.order_id,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Pallete.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),

              //! copy icon
              InkWell(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: order.order_id))
                      .then(
                    (value) => showSnackBar(
                      context,
                      'Your order ID has been copied to your clipboard',
                    ),
                  );
                },
                child: SvgPicture.asset('copy'.svg),
              ),
            ],
          ),

          //! order details
          Row(
            children: [
              Text(
                'Order Details',
                style: TextStyle(
                  color: Pallete.textBlack,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(
            height: 90.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTexts.subTotal,
                      style: TextStyle(
                        color: Pallete.textGreylighter,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '${AppTexts.naira} 4500',
                      style: TextStyle(
                        color: Pallete.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                //! vat
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTexts.vat,
                      style: TextStyle(
                        color: Pallete.textGreylighter,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '${AppTexts.naira} 4500',
                      style: TextStyle(
                        color: Pallete.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                //! delivery fee
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTexts.deliveryFee,
                      style: TextStyle(
                        color: Pallete.textGreylighter,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '${AppTexts.naira} 1000',
                      style: TextStyle(
                        color: Pallete.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                //! total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTexts.total,
                      style: TextStyle(
                        color: Pallete.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      '${AppTexts.naira} 4500',
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
        ],
      ),
    );
  }
}
