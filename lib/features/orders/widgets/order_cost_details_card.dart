import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class OrderCostDetailsCard extends ConsumerWidget {
  const OrderCostDetailsCard({super.key});

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
        children: [
          //! order id, copy
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
            ],
          ),

          //! order details
          Row(),

          //! food name
          Row(),

          //! vat
          Row(),

          //! delivery fee
          Row(),

          //! total
          Row(),
        ],
      ),
    );
  }
}
