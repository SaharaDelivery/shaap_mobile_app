import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shaap_mobile_app/features/home/widgets/item_card_widget.dart';
import 'package:shaap_mobile_app/features/restaurants/controllers/restaurants_comtroller.dart';
import 'package:shaap_mobile_app/features/restaurants/models/cuisine_filter_model.dart';
import 'package:shaap_mobile_app/models/restaurant_model.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/error_text.dart';
import 'package:shaap_mobile_app/utils/loader.dart';
import 'package:shaap_mobile_app/utils/snack_bar.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class SearchRestaurantsView extends ConsumerStatefulWidget {
  const SearchRestaurantsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchRestaurantsViewState();
}

class _SearchRestaurantsViewState extends ConsumerState<SearchRestaurantsView> {
  ValueNotifier<bool> isFilterTapped = ValueNotifier(false);
  // ValueNotifier<int> selectedCuisineIndex = ValueNotifier(0);
  ValueNotifier<List<String>> selectedCuisineIdList = ValueNotifier([]);
  CuisineFilterModel cuisineFilterModel = const CuisineFilterModel('', [], '0.0');

  void toggleFilterState() {
    isFilterTapped.value = !isFilterTapped.value;
    log(selectedCuisineIdList.value.toString());
  }

  @override
  Widget build(BuildContext context) {
    // final allRestaurants =
    //     ref.watch(getFilteredRestaurantsProvider(cuisineFilterModel));
    return Scaffold(
      body: Column(
        children: [
          60.sbH,
          ValueListenableBuilder(
              valueListenable: isFilterTapped,
              child: const SizedBox.shrink(),
              builder: (context, value, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.fastOutSlowIn,
                  height: isFilterTapped.value == true ? 110.h : 40.h,
                  width: double.infinity,
                  // padding: 15.padH,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: 15.padH,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(Icons.arrow_back_ios),
                              ),
                              SizedBox(
                                height: 40.h,
                                width: 270.w,
                                child: TextField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    prefixIconConstraints:
                                        BoxConstraints(maxHeight: 20.h),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(
                                          left: 18.w, right: 10.w),
                                      child: SvgPicture.asset('search'.svg),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Pallete.dividerGreyColor),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: const BorderSide(
                                          color: Pallete.dividerGreyColor),
                                    ),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 17.w,
                                backgroundColor: isFilterTapped.value == true
                                    ? Pallete.yellowColor
                                    : Colors.transparent,
                                child: InkWell(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onTap: toggleFilterState,
                                  child: Icon(
                                    PhosphorIcons.funnelSimpleBold,
                                    color: isFilterTapped.value == true
                                        ? Pallete.whiteColor
                                        : Pallete.yellowColor,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.sbH,
                        SizedBox(
                          height: 32.h,
                          width: double.infinity,
                          child: ValueListenableBuilder(
                            valueListenable: selectedCuisineIdList,
                            child: const SizedBox.shrink(),
                            builder: (context, value, child) {
                              return ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                scrollDirection: Axis.horizontal,
                                itemCount: cuisine.length,
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 16.w),
                                    child: TransparentButton(
                                      onTap: () {
                                        switch (index) {
                                          // case 0:
                                          //   selectedCuisineIdList.value = [];
                                          //   break;

                                          case 0:
                                            if (selectedCuisineIdList.value
                                                .contains('1')) {
                                              selectedCuisineIdList.value
                                                  .remove('1');
                                            } else if (selectedCuisineIdList
                                                    .value.length <
                                                3) {
                                              selectedCuisineIdList.value
                                                  .add('1');
                                            } else {
                                              showSnackBar(context,
                                                  'You can only select three categories at most');
                                            }
                                            break;

                                          case 1:
                                            if (selectedCuisineIdList.value
                                                .contains('2')) {
                                              selectedCuisineIdList.value
                                                  .remove('2');
                                            } else if (selectedCuisineIdList
                                                    .value.length <
                                                3) {
                                              selectedCuisineIdList.value
                                                  .add('2');
                                            } else {
                                              showSnackBar(context,
                                                  'You can only select three categories at most');
                                            }
                                            break;

                                          case 2:
                                            if (selectedCuisineIdList.value
                                                .contains('3')) {
                                              selectedCuisineIdList.value
                                                  .remove('3');
                                            } else if (selectedCuisineIdList
                                                    .value.length <
                                                3) {
                                              selectedCuisineIdList.value
                                                  .add('3');
                                            } else {
                                              showSnackBar(context,
                                                  'You can only select three categories at most');
                                            }
                                            break;

                                          case 3:
                                            if (selectedCuisineIdList.value
                                                .contains('4')) {
                                              selectedCuisineIdList.value
                                                  .remove('4');
                                            } else if (selectedCuisineIdList
                                                    .value.length <
                                                3) {
                                              selectedCuisineIdList.value
                                                  .add('4');
                                            } else {
                                              showSnackBar(context,
                                                  'You can only select three categories at most');
                                            }
                                            break;
                                          case 4:
                                            if (selectedCuisineIdList.value
                                                .contains('5')) {
                                              selectedCuisineIdList.value
                                                  .remove('5');
                                            } else if (selectedCuisineIdList
                                                    .value.length <
                                                3) {
                                              selectedCuisineIdList.value
                                                  .add('5');
                                            } else {
                                              showSnackBar(context,
                                                  'You can only select three categories at most');
                                            }
                                            break;
                                          case 5:
                                            if (selectedCuisineIdList.value
                                                .contains('6')) {
                                              selectedCuisineIdList.value
                                                  .remove('6');
                                            } else if (selectedCuisineIdList
                                                    .value.length <
                                                3) {
                                              selectedCuisineIdList.value
                                                  .add('6');
                                            } else {
                                              showSnackBar(context,
                                                  'You can only select three categories at most');
                                            }
                                            break;
                                          case 6:
                                            if (selectedCuisineIdList.value
                                                .contains('7')) {
                                              selectedCuisineIdList.value
                                                  .remove('7');
                                            } else if (selectedCuisineIdList
                                                    .value.length <
                                                3) {
                                              selectedCuisineIdList.value
                                                  .add('7');
                                            } else {
                                              showSnackBar(context,
                                                  'You can only select three categories at most');
                                            }
                                            break;
                                          case 7:
                                            if (selectedCuisineIdList.value
                                                .contains('8')) {
                                              selectedCuisineIdList.value
                                                  .remove('8');
                                            } else if (selectedCuisineIdList
                                                    .value.length <
                                                3) {
                                              selectedCuisineIdList.value
                                                  .add('8');
                                            } else {
                                              showSnackBar(context,
                                                  'You can only select three categories at most');
                                            }
                                            break;
                                        }
                                        setState(() {});
                                        log(selectedCuisineIdList.value
                                            .toString());
                                      },
                                      height: 32.h,
                                      width: 82.w,
                                      color: selectedCuisineIdList.value
                                              .contains((index + 1).toString())
                                          ? Pallete.yellowColor
                                          : Pallete.dividerGreyColor,
                                      backgroundColor: selectedCuisineIdList
                                              .value
                                              .contains((index + 1).toString())
                                          ? Pallete.yellowColor
                                          : null,
                                      textColor: selectedCuisineIdList.value
                                              .contains((index + 1).toString())
                                          ? Pallete.whiteColor
                                          : Pallete.textGrey,
                                      text: cuisine[index],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          20.sbH,
          Expanded(
            child: ref
                .watch(getFilteredRestaurantsProvider(cuisineFilterModel))
                .when(
                  data: (filteredRestaurants) {
                    if (filteredRestaurants.isEmpty) {
                      return const ErrorText(
                          error: 'Could not find any restaurants');
                    }

                    return ListView.builder(
                      padding: 24.padH,
                      physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      itemCount: filteredRestaurants.length,
                      itemBuilder: (context, index) {
                        RestaurantModel filteredRestaurant =
                            filteredRestaurants[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 25.h),
                          child: ItemCardWidget(
                            isFeatured: true,
                            image: filteredRestaurant.cover_photo,
                            name: filteredRestaurant.name,
                            stars: filteredRestaurant.rating,
                          ),
                        );
                      },
                    );
                  },
                  error: (error, stackTrace) =>
                      ErrorText(error: error.toString()),
                  loading: () => const Loader(),
                ),
          ),
        ],
      ),
    );
  }
}

const cuisine = [
  // 'All', // clear the list
  'Chicken', // id 1
  'Seafood', // 2
  'Vegetarian', // 3
  'Beef', // 4
  'Pizza', // 5
  'Western', // 6
  'Northern', // 7
];
