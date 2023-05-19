import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shaap_mobile_app/features/profile/controllers/profile_controller.dart';
import 'package:shaap_mobile_app/features/profile/views/add_address_view.dart';
import 'package:shaap_mobile_app/features/profile/views/edit_address_view.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/error_text.dart';
import 'package:shaap_mobile_app/utils/loader.dart';
import 'package:shaap_mobile_app/utils/nav.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class AddressesView extends ConsumerWidget {
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressesFuture = ref.watch(getUsersSavedAddressProvider);
    return Scaffold(
      body: Container(
        height: height(context),
        width: width(context),
        padding: 24.padH,
        child: Stack(
          children: [
            Column(
              children: [
                50.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TransparentButton(
                      onTap: () {
                        Navigator.of(context).pop();
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
                      AppTexts.addressDetails,
                      style: TextStyle(
                        color: Pallete.textBlack,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    32.sbW,
                  ],
                ),
                28.sbH,
                // for address
                Expanded(
                  child: addressesFuture.when(
                    data: (addresses) {
                      if (addresses.isEmpty) {
                        return const ErrorText(error: 'You have no saved addresses');
                      }

                      return ListView.builder(
                        itemCount: addresses.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => navigateToViews(
                              context,
                              EditAddressView(
                                specificAddress: addresses[index].address_2,
                                generalAddress: addresses[index].address_1,
                                id: addresses[index].id,
                              ),
                            ),
                            child: Container(
                              height: 56.h,
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 24.h),
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
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: (error, stactrace) {
                      log(error.toString());
                      return ErrorText(error: error.toString());
                    },
                    loading: () => const Loader(),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Opacity(
                    opacity: 0.8,
                    child: BButton(
                      width: 200.w,
                      onTap: () {
                        navigateToViews(context, const AddAddressView());
                      },
                      text: AppTexts.addNewAddress,
                    ),
                  ),
                  50.sbH,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
