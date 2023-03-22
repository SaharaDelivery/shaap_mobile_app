import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/features/orders/widgets/delivery_progess_widget.dart';
import 'package:shaap_mobile_app/features/orders/widgets/order_cost_details_card.dart';
import 'package:shaap_mobile_app/features/orders/widgets/status_stacked_card.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class TrackOrdersBottomSheet extends ConsumerStatefulWidget {
  const TrackOrdersBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TrackOrdersBottomSheetState();
}

class _TrackOrdersBottomSheetState
    extends ConsumerState<TrackOrdersBottomSheet> {
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
              height: 743.h,
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
                  15.sbH,
                  Padding(
                    padding: 24.padH,
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
                          AppTexts.track,
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
                  19.sbH,

                  //! space for the maps
                  Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Pallete.borderGrey,
                      ),
                    ),
                    child: const Center(
                      child: Text('Map'),
                    ),
                  ),
                  32.sbH,
                  //! arrival time
                  Text(
                    'Calculating Arrival TIme',
                    style: TextStyle(
                      color: Pallete.textBlack,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  5.sbH,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Delivering To ',
                      style: TextStyle(
                        color: Pallete.textGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: 'Home',
                          style: TextStyle(
                            color: Pallete.yellowColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  25.5.sbH,

                  //! the progress widget!
                  DeliveryProgressWidget(),

                  20.5.sbH,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //! status stacked0
                          StatusStackedCard(),
                  
                          31.sbH,
                  
                          //! order cost details
                          OrderCostDetailsCard()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
