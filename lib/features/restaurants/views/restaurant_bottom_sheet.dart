import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shaap_mobile_app/features/home/views/home_view.dart';
import 'package:shaap_mobile_app/features/home/widgets/choice_widget.dart';
import 'package:shaap_mobile_app/features/items/views/items_details_bottom_sheet.dart';
import 'package:shaap_mobile_app/features/restaurants/widgets/restaurant_dummy_model.dart';
import 'package:shaap_mobile_app/features/restaurants/widgets/restaurant_list_tile.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class RestaurantBottomSheet extends ConsumerStatefulWidget {
  const RestaurantBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RestaurantBottomSheetState();
}

class _RestaurantBottomSheetState extends ConsumerState<RestaurantBottomSheet> {
  ValueNotifier<int> selectedCategoryIndex = ValueNotifier(0);
  final itemController = ItemScrollController();

  Future _scrollToIndex(int index) async {
    itemController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic);
  }

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
              child: NestedScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.transparent,
                    floating: true,
                    snap: true,
                    expandedHeight: 172.h,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                            ),
                            child: Image.asset(
                              'food-1'.png,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0, -0.6),
                          child: Padding(
                            padding: 24.padH,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // leave
                                InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    clipBehavior: Clip.antiAlias,
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 3, sigmaY: 3),
                                      child: Container(
                                        height: 32.h,
                                        width: 32.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          color: Colors.white.withOpacity(0.2),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: Pallete.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                //! search
                                InkWell(
                                  onTap: () {},
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    clipBehavior: Clip.antiAlias,
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        height: 32.h,
                                        width: 32.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          color: Colors.white.withOpacity(0.4),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            PhosphorIcons.magnifyingGlassBold,
                                            color: Pallete.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 16.h,
                        ),
                        height: 134.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! name - location
                            Text(
                              'KFC Nigeria - Ikeja',
                              style: TextStyle(
                                color: Pallete.textBlack,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            //! opens
                            Text(
                              'Opens today at 8 am',
                              style: TextStyle(
                                color: Pallete.textBlack,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            //! stars
                            Row(
                              children: [
                                Image.asset('star'.png, height: 14.h),
                                4.sbW,
                                RichText(
                                  text: TextSpan(
                                    text: '4.5 ',
                                    style: TextStyle(
                                      color: Pallete.textGrey,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '(2.4k)',
                                        style: TextStyle(
                                          color: Pallete.textGreylighter,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // price - delivery
                            Row(
                              children: [
                                Icon(
                                  PhosphorIcons.clockBold,
                                  size: 16.sp,
                                ),
                                4.sbW,
                                Text(
                                  '10-20 min',
                                  style: TextStyle(
                                    color: Pallete.textBlack,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                9.5.sbW,
                                Icon(
                                  PhosphorIcons.bicycleBold,
                                  size: 16.sp,
                                ),
                                4.sbW,
                                Text(
                                  '${AppTexts.naira} 1000 Delivery fee',
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
                      Divider(
                        color: Pallete.dividerGreyColor,
                        thickness: 2,
                        endIndent: 11.w,
                      ),
                      16.sbH,
                      SizedBox(
                        height: 32.h,
                        //! TODO:
                        child: ValueListenableBuilder(
                            valueListenable: selectedCategoryIndex,
                            child: const SizedBox.shrink(),
                            builder: (context, value, child) {
                              return ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                scrollDirection: Axis.horizontal,
                                itemCount: foodCategories.length,
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                itemBuilder: (context, index) {
                                  return ChoiceWidget(
                                    onTap: () async {
                                      selectedCategoryIndex.value = index;
                                      _scrollToIndex(index);
                                    },
                                    borderColor:
                                        selectedCategoryIndex.value == index
                                            ? Pallete.yellowColor
                                            : Pallete.dividerGreyColor,
                                    backgroundColor:
                                        selectedCategoryIndex.value == index
                                            ? Pallete.yellowColor
                                            : Colors.transparent,
                                    textColor:
                                        selectedCategoryIndex.value == index
                                            ? Pallete.whiteColor
                                            : Pallete.textGrey,
                                    text: foodCategories[index].title,
                                  );
                                },
                              );
                            }),
                      ),
                      16.sbH,
                      Divider(
                        color: Pallete.dividerGreyColor,
                        thickness: 2,
                        endIndent: 11.w,
                      ),
                      16.sbH,
                      SizedBox(
                        height: 516.h,
                        child: ScrollablePositionedList.builder(
                            physics: ClampingScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 400.h),
                            itemScrollController: itemController,
                            itemCount: foodCategories.length,
                            itemBuilder: (context, index) {
                              return Container(
                                // color: Colors.red,
                                padding: EdgeInsets.symmetric(horizontal: 24.w)
                                    .copyWith(bottom: 24.h),
                                child: Column(
                                  children: [
                                    //! Top Sellers
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        foodCategories[index].title,
                                        style: TextStyle(
                                          color: Pallete.textBlack,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    19.sbH,
                                    Column(
                                      children: foodCategories[index]
                                          .food
                                          .map(
                                            (Food food) => RestaurantListTile(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  // barrierColor:
                                                  //     Pallete.blackColor,
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) => Wrap(
                                                    children: [
                                                      ItemDetailsBottomSheet(
                                                        name: food.name,
                                                        image: food.image,
                                                        price: food.price,
                                                        description: food.description,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              image: food.image,
                                              name: food.name,
                                              description: food.description,
                                              price: food.price,
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

const restCategories = [
  'Top Sellers',
  'Main',
  'Wings And Chicken',
];
