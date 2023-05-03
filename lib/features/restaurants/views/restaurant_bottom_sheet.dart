// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:shaap_mobile_app/features/home/views/home_view.dart';
import 'package:shaap_mobile_app/features/home/widgets/choice_widget.dart';
import 'package:shaap_mobile_app/features/items/views/checkout_bottom_sheet_view.dart';
import 'package:shaap_mobile_app/features/items/views/items_details_bottom_sheet.dart';
import 'package:shaap_mobile_app/features/orders/controllers/order_controller.dart';
import 'package:shaap_mobile_app/features/restaurants/controllers/restaurants_comtroller.dart';
import 'package:shaap_mobile_app/features/restaurants/widgets/restaurant_dummy_model.dart';
import 'package:shaap_mobile_app/features/restaurants/widgets/restaurant_list_tile.dart';
import 'package:shaap_mobile_app/models/food_model.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/error_text.dart';
import 'package:shaap_mobile_app/utils/loader.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class RestaurantBottomSheet extends ConsumerStatefulWidget {
  final String restauranstId;
  const RestaurantBottomSheet({
    super.key,
    required this.restauranstId,
  });

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
    final restaurantDetailsFuture =
        ref.watch(getRestaurantDetailsProvider(widget.restauranstId));
    final checkForOrdersFuture =
        ref.watch(checkIfOrderExistsInRestaurantProvider(widget.restauranstId));
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
              child: restaurantDetailsFuture.when(
                data: (restaurant) {
                  return NestedScrollView(
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
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: restaurant.cover_photo,
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
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.r),
                                        topRight: Radius.circular(16.r),
                                      ),
                                    ),
                                  )
                                      .animate(
                                          onPlay: (controller) =>
                                              controller.repeat())
                                      .shimmer(duration: 1200.ms),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const Alignment(0, -0.6),
                              child: Padding(
                                padding: 24.padH,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // leave
                                    InkWell(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          color: Pallete.yellowColor,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.arrow_back,
                                            color: Pallete.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),

                                    //! search

                                    checkForOrdersFuture.when(
                                      data: (orderId) {
                                        return InkWell(
                                          onTap: () {
                                            if (orderId != 'notfound') {
                                              showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                barrierColor: Colors.black
                                                    .withOpacity(0.25),
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) => Wrap(
                                                  children: [
                                                    CheckoutBottomSheet(
                                                      orderId: orderId,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                          child: SizedBox(
                                            height: 60.h,
                                            width: 60.w,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: 50.h,
                                                  width: 50.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.r),
                                                    color: Pallete.yellowColor,
                                                  ),
                                                  child: const Center(
                                                    child: Icon(
                                                      PhosphorIcons
                                                          .shoppingCartBold,
                                                      color: Pallete.whiteColor,
                                                    ),
                                                  ),
                                                ),

                                                //! check if orders exist
                                                if (orderId != 'notfound')
                                                  Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Pallete.whiteColor,
                                                      radius: 10.w,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Pallete.red,
                                                        radius: 8.w,
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      error: (error, stactrace) {
                                        log(error.toString());
                                        // return ErrorText(
                                        //     error: error.toString());
                                        return const SizedBox.shrink();
                                      },
                                      // loading: () => const Loader(),
                                      loading: () => SizedBox(
                                        height: 60.h,
                                        width: 60.w,
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: 50.h,
                                              width: 50.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                                color: Pallete.yellowColor,
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  PhosphorIcons
                                                      .shoppingCartBold,
                                                  color: Pallete.whiteColor,
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
                                  '${restaurant.name} - ${restaurant.address}',
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
                                        text: '${restaurant.rating} ',
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
                                    physics:
                                        const AlwaysScrollableScrollPhysics(
                                            parent: BouncingScrollPhysics()),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: restCategories.length,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
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
                                        text: restCategories[index],
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
                            // height: 516.h,
                            child: ref
                                .watch(getRestaurantsMenuItemsProvider(
                                    widget.restauranstId))
                                .when(
                                  data: (menu) {
                                    List<FoodModel> mainCourseFoods = menu
                                        .where((food) =>
                                            food.menu == 'Main Course')
                                        .toList();
                                    List<FoodModel> sideDishes = menu
                                        .where((food) =>
                                            food.menu == 'Side Dishes')
                                        .toList();
                                    List<FoodModel> wraps = menu
                                        .where((food) => food.menu == 'Wraps')
                                        .toList();
                                    List<FoodModel> appetizers = menu
                                        .where(
                                            (food) => food.menu == 'Appetizers')
                                        .toList();
                                    List<FoodModel> dessert = menu
                                        .where((food) => food.menu == 'Dessert')
                                        .toList();

                                    if (menu.isEmpty) {
                                      return ErrorText(
                                          error: 'No menu available');
                                    }

                                    return Column(
                                      children: [
                                        //! main course category
                                        if (mainCourseFoods.isNotEmpty)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24.w),
                                            child: Column(
                                              children: [
                                                //! title
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    restCategories[0],
                                                    style: TextStyle(
                                                      color: Pallete.textBlack,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                19.sbH,
                                                Column(
                                                  children: List.generate(
                                                      mainCourseFoods.length,
                                                      (index) {
                                                    return mainCourseFoods
                                                            .isEmpty
                                                        ? const SizedBox
                                                            .shrink()
                                                        : RestaurantListTile(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                // barrierColor:
                                                                //     Pallete.blackColor,
                                                                isScrollControlled:
                                                                    true,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Wrap(
                                                                  children: [
                                                                    ItemDetailsBottomSheet(
                                                                      restaurantId:
                                                                          restaurant
                                                                              .id,
                                                                      food: mainCourseFoods[
                                                                          index],
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            food:
                                                                mainCourseFoods[
                                                                    index],
                                                          );
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ),

                                        //! side dishes category
                                        if (sideDishes.isNotEmpty)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24.w),
                                            child: Column(
                                              children: [
                                                //! title
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    restCategories[1],
                                                    style: TextStyle(
                                                      color: Pallete.textBlack,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                23.sbH,
                                                Column(
                                                  children: List.generate(
                                                      sideDishes.length,
                                                      (index) {
                                                    return mainCourseFoods
                                                            .isEmpty
                                                        ? const SizedBox
                                                            .shrink()
                                                        : RestaurantListTile(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                // barrierColor:
                                                                //     Pallete.blackColor,
                                                                isScrollControlled:
                                                                    true,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Wrap(
                                                                  children: [
                                                                    ItemDetailsBottomSheet(
                                                                      restaurantId:
                                                                          restaurant
                                                                              .id,
                                                                      food: sideDishes[
                                                                          index],
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            food: sideDishes[
                                                                index],
                                                          );
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ),

                                        //! wraps category
                                        if (wraps.isNotEmpty)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24.w),
                                            child: Column(
                                              children: [
                                                //! title
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    restCategories[2],
                                                    style: TextStyle(
                                                      color: Pallete.textBlack,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                23.sbH,
                                                Column(
                                                  children: List.generate(
                                                      wraps.length, (index) {
                                                    return mainCourseFoods
                                                            .isEmpty
                                                        ? const SizedBox
                                                            .shrink()
                                                        : RestaurantListTile(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                // barrierColor:
                                                                //     Pallete.blackColor,
                                                                isScrollControlled:
                                                                    true,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Wrap(
                                                                  children: [
                                                                    ItemDetailsBottomSheet(
                                                                      restaurantId:
                                                                          restaurant
                                                                              .id,
                                                                      food: wraps[
                                                                          index],
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            food: wraps[index],
                                                          );
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ),

                                        //! appetizers category
                                        if (appetizers.isNotEmpty)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24.w),
                                            child: Column(
                                              children: [
                                                //! title
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    restCategories[3],
                                                    style: TextStyle(
                                                      color: Pallete.textBlack,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                23.sbH,
                                                Column(
                                                  children: List.generate(
                                                      appetizers.length,
                                                      (index) {
                                                    return appetizers.isEmpty
                                                        ? const SizedBox
                                                            .shrink()
                                                        : RestaurantListTile(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                // barrierColor:
                                                                //     Pallete.blackColor,
                                                                isScrollControlled:
                                                                    true,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Wrap(
                                                                  children: [
                                                                    ItemDetailsBottomSheet(
                                                                      restaurantId:
                                                                          restaurant
                                                                              .id,
                                                                      food: wraps[
                                                                          index],
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            food: appetizers[
                                                                index],
                                                          );
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ),

                                        //! dessert category
                                        if (dessert.isNotEmpty)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24.w),
                                            child: Column(
                                              children: [
                                                //! title
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    restCategories[4],
                                                    style: TextStyle(
                                                      color: Pallete.textBlack,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                23.sbH,
                                                Column(
                                                  children: List.generate(
                                                      dessert.length, (index) {
                                                    return dessert.isEmpty
                                                        ? const SizedBox
                                                            .shrink()
                                                        : RestaurantListTile(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                // barrierColor:
                                                                //     Pallete.blackColor,
                                                                isScrollControlled:
                                                                    true,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Wrap(
                                                                  children: [
                                                                    ItemDetailsBottomSheet(
                                                                      restaurantId:
                                                                          restaurant
                                                                              .id,
                                                                      food: wraps[
                                                                          index],
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                            food:
                                                                dessert[index],
                                                          );
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ],
                                    );
                                    // Container(
                                    //   padding:
                                    //       EdgeInsets.symmetric(horizontal: 24.w)
                                    //           .copyWith(bottom: 24.h),
                                    //   child: Column(
                                    //     children: ,
                                    //   ),
                                    // );
                                    // ---------//

                                    // return ScrollablePositionedList.builder(
                                    //   physics: NeverScrollableScrollPhysics(),
                                    //   padding: EdgeInsets.only(bottom: 40.h),
                                    //   itemScrollController: itemController,
                                    //   itemCount: restCategories.length,
                                    //   itemBuilder: (context, index) {
                                    //     return Container(
                                    //       padding: EdgeInsets.symmetric(
                                    //               horizontal: 24.w)
                                    //           .copyWith(bottom: 24.h),
                                    //       child: Column(
                                    //         children: [
                                    //           //! title
                                    //           Align(
                                    //             alignment: Alignment.centerLeft,
                                    //             child: Text(
                                    //               restCategories[index],
                                    //               style: TextStyle(
                                    //                 color: Pallete.textBlack,
                                    //                 fontSize: 14.sp,
                                    //                 fontWeight: FontWeight.w500,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //           19.sbH,
                                    //           Column(
                                    //             children: [],
                                    //  restCategories[
                                    //                 index] ==
                                    //             'Main course' &&
                                    //         menu.mainCourses
                                    //             .isNotEmpty
                                    //     ? menu.mainCourses
                                    //         .map((food) {
                                    //         if (food != null) {
                                    //           return RestaurantListTile(
                                    //             onTap: () {
                                    //               showModalBottomSheet(
                                    //                 backgroundColor:
                                    //                     Colors
                                    //                         .transparent,
                                    //                 // barrierColor:
                                    //                 //     Pallete.blackColor,
                                    //                 isScrollControlled:
                                    //                     true,
                                    //                 context:
                                    //                     context,
                                    //                 builder:
                                    //                     (context) =>
                                    //                         Wrap(
                                    //                   children: [
                                    //                     ItemDetailsBottomSheet(
                                    //                       name: food
                                    //                           .name,
                                    //                       image: food
                                    //                           .image,
                                    //                       price: double
                                    //                           .tryParse(
                                    //                               food.price)!,
                                    //                       description:
                                    //                           food.description,
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               );
                                    //             },
                                    //             image: food.image,
                                    //             name: food.name,
                                    //             description: food
                                    //                 .description,
                                    //             price:
                                    //                 double.tryParse(
                                    //                     food.price),
                                    //           );
                                    //         }
                                    //         return SizedBox();
                                    //       }).toList()
                                    //     : restCategories[index] ==
                                    //                 'Side Dishes' &&
                                    //             menu.sideDishes
                                    //                 .isNotEmpty
                                    //         ? menu.sideDishes
                                    //             .map(
                                    //               (food) =>
                                    //                   RestaurantListTile(
                                    //                 onTap: () {
                                    //                   showModalBottomSheet(
                                    //                     backgroundColor:
                                    //                         Colors
                                    //                             .transparent,
                                    //                     // barrierColor:
                                    //                     //     Pallete.blackColor,
                                    //                     isScrollControlled:
                                    //                         true,
                                    //                     context:
                                    //                         context,
                                    //                     builder:
                                    //                         (context) =>
                                    //                             Wrap(
                                    //                       children: [
                                    //                         ItemDetailsBottomSheet(
                                    //                           name:
                                    //                               food.name,
                                    //                           image:
                                    //                               food.image,
                                    //                           price:
                                    //                               double.tryParse(food.price)!,
                                    //                           description:
                                    //                               food.description,
                                    //                         ),
                                    //                       ],
                                    //                     ),
                                    //                   );
                                    //                 },
                                    //                 image:
                                    //                     food!.image,
                                    //                 name: food.name,
                                    //                 description: food
                                    //                     .description,
                                    //                 price: double
                                    //                     .tryParse(food
                                    //                         .price),
                                    //               ),
                                    //             )
                                    //             .toList()
                                    //         : restCategories[
                                    //                         index] ==
                                    //                     'Wraps' &&
                                    //                 menu.wraps
                                    //                     .isNotEmpty
                                    //             ? menu.wraps
                                    //                 .map(
                                    //                   (food) =>
                                    //                       RestaurantListTile(
                                    //                     onTap: () {
                                    //                       showModalBottomSheet(
                                    //                         backgroundColor:
                                    //                             Colors.transparent,
                                    //                         // barrierColor:
                                    //                         //     Pallete.blackColor,
                                    //                         isScrollControlled:
                                    //                             true,
                                    //                         context:
                                    //                             context,
                                    //                         builder:
                                    //                             (context) =>
                                    //                                 Wrap(
                                    //                           children: [
                                    //                             ItemDetailsBottomSheet(
                                    //                               name: food.name,
                                    //                               image: food.image,
                                    //                               price: double.tryParse(food.price)!,
                                    //                               description: food.description,
                                    //                             ),
                                    //                           ],
                                    //                         ),
                                    //                       );
                                    //                     },
                                    //                     image: food!
                                    //                         .image,
                                    //                     name: food
                                    //                         .name,
                                    //                     description:
                                    //                         food.description,
                                    //                     price: double
                                    //                         .tryParse(
                                    //                             food.price),
                                    //                   ),
                                    //                 )
                                    //                 .toList()
                                    //             : const [],

                                    // ------------- //

                                    // children: foodCategories[index]
                                    //     .food
                                    //     .map(
                                    //       (Food food) =>
                                    //           RestaurantListTile(
                                    //         onTap: () {
                                    //           showModalBottomSheet(
                                    //             backgroundColor:
                                    //                 Colors
                                    //                     .transparent,
                                    //             // barrierColor:
                                    //             //     Pallete.blackColor,
                                    //             isScrollControlled:
                                    //                 true,
                                    //             context: context,
                                    //             builder:
                                    //                 (context) =>
                                    //                     Wrap(
                                    //               children: [
                                    //                 ItemDetailsBottomSheet(
                                    //                   name:
                                    //                       food.name,
                                    //                   image: food
                                    //                       .image,
                                    //                   price: food
                                    //                       .price,
                                    //                   description: food
                                    //                       .description,
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           );
                                    //         },
                                    //         image: food.image,
                                    //         name: food.name,
                                    //         description:
                                    //             food.description,
                                    //         price: food.price,
                                    //       ),
                                    //     )
                                    //     .toList(),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     );
                                    //   },
                                    // );
                                  },
                                  error: (error, stactrace) {
                                    log(error.toString());
                                    return ErrorText(error: error.toString());
                                  },
                                  loading: () => const Loader(),
                                ),
                            // child: ScrollablePositionedList.builder(
                            //     physics: ClampingScrollPhysics(),
                            //     padding: EdgeInsets.only(bottom: 400.h),
                            //     itemScrollController: itemController,
                            //     itemCount: foodCategories.length,
                            //     itemBuilder: (context, index) {
                            //       return Container(
                            //         // color: Colors.red,
                            //         padding:
                            //             EdgeInsets.symmetric(horizontal: 24.w)
                            //                 .copyWith(bottom: 24.h),
                            //         child: Column(
                            //           children: [
                            //             //! Top Sellers
                            //             Align(
                            //               alignment: Alignment.centerLeft,
                            //               child: Text(
                            //                 foodCategories[index].title,
                            //                 style: TextStyle(
                            //                   color: Pallete.textBlack,
                            //                   fontSize: 14.sp,
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ),
                            //             19.sbH,
                            //             Column(
                            //               children: foodCategories[index]
                            //                   .food
                            //                   .map(
                            //                     (Food food) =>
                            //                         RestaurantListTile(
                            //                       onTap: () {
                            //                         showModalBottomSheet(
                            //                           backgroundColor:
                            //                               Colors.transparent,
                            //                           // barrierColor:
                            //                           //     Pallete.blackColor,
                            //                           isScrollControlled: true,
                            //                           context: context,
                            //                           builder: (context) =>
                            //                               Wrap(
                            //                             children: [
                            //                               ItemDetailsBottomSheet(
                            //                                 name: food.name,
                            //                                 image: food.image,
                            //                                 price: food.price,
                            //                                 description: food
                            //                                     .description,
                            //                               ),
                            //                             ],
                            //                           ),
                            //                         );
                            //                       },
                            //                       image: food.image,
                            //                       name: food.name,
                            //                       description: food.description,
                            //                       price: food.price,
                            //                     ),
                            //                   )
                            //                   .toList(),
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //     }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                error: (error, stactrace) => ErrorText(error: error.toString()),
                loading: () => const Loader(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

const restCategories = [
  'Main course',
  'Side Dishes',
  'Wraps',
  'Appetizers',
  'Dessert',
];

// RestaurantListTile(
//                                                         onTap: () {
//                                                           showModalBottomSheet(
//                                                             backgroundColor:
//                                                                 Colors
//                                                                     .transparent,
//                                                             // barrierColor:
//                                                             //     Pallete.blackColor,
//                                                             isScrollControlled:
//                                                                 true,
//                                                             context: context,
//                                                             builder:
//                                                                 (context) =>
//                                                                     Wrap(
//                                                               children: [
//                                                                 ItemDetailsBottomSheet(
//                                                                   name:
//                                                                       food.name,
//                                                                   image: food
//                                                                       .image,
//                                                                   price: food
//                                                                       .price,
//                                                                   description: food
//                                                                       .description,
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           );
//                                                         },
//                                                         image: food.image,
//                                                         name: food.name,
//                                                         description:
//                                                             food.description,
//                                                         price: food.price,
//                                                       ),
