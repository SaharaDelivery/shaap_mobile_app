import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaap_mobile_app/features/home/widgets/item_card_widget.dart';
import 'package:shaap_mobile_app/features/orders/views/track_orders_bottom_sheet.dart';
import 'package:shaap_mobile_app/features/orders/widgets/orders_tile.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class OrdersView extends ConsumerWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> orders = [''];
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: 24.padH,
          child: Column(
            children: [
              SizedBox(
                height: 60.h,
                child: Center(
                  child: Text(
                    AppTexts.orders,
                    style: TextStyle(
                      color: Pallete.textBlack,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              //! body
              Expanded(
                child: orders.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('no-orders'.svg),
                            24.sbH,
                            Text(
                              AppTexts.noOrders,
                              style: TextStyle(
                                color: Pallete.textBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            10.sbH,
                            Text(
                              AppTexts.youHaveNoOrder,
                              style: TextStyle(
                                color: Pallete.textBlack,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: OrdersTile(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  barrierColor: Pallete.blackColor,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => Wrap(
                                    children: const [
                                      TrackOrdersBottomSheet(),
                                    ],
                                  ),
                                );
                              },
                              restaurantName: 'kfc nigeria - ikeja ',
                              orderID: '1234ferw',
                              image: 'food-1',
                              status: 'Processing',
                              details: ' 1x zinger burger combo',
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
