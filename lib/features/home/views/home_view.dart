import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaap_mobile_app/features/home/widgets/item_card_widget.dart';
import 'package:shaap_mobile_app/features/restaurants/controllers/restaurants_comtroller.dart';
import 'package:shaap_mobile_app/features/restaurants/views/restaurant_bottom_sheet.dart';
import 'package:shaap_mobile_app/features/restaurants/views/search_restaurants_view.dart';
import 'package:shaap_mobile_app/models/restaurant_model.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/app_fade_animation.dart';
import 'package:shaap_mobile_app/utils/error_text.dart';
import 'package:shaap_mobile_app/utils/loader.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  ValueNotifier<int> selectedCategoryIndex = ValueNotifier(0);
  final double _currentPageValue = 0.0;
  final double _scaleFactor = 0.7;
  double _height = 0;
  final PageController _controller = PageController(viewportFraction: 0.6);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // //! providers
    // final user = ref.watch(userProvider)!;
    final allRestaurants = ref.watch(getAllRestaurantsProvider);
    // final addressesFuture = ref.watch(getUsersSavedAddressProvider);

    //
    _height = 253.h;
    return Scaffold(
      // body: LiquidPullToRefresh(
      //   height: 100.h,
      //   showChildOpacityTransition: false,
      //   backgroundColor: Pallete.whiteColor,
      //   color: Pallete.yellowColor,
      //   springAnimationDurationInMilliseconds: 200,
      //   onRefresh: () async {
      //     ref.invalidate(getAllRestaurantsProvider);
      //   },
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Stack(
          children: [
            //! main body
            SizedBox(
              height: height(context),
              width: width(context),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: ClampingScrollPhysics(),
                ),
                child: Column(
                  // padding: EdgeInsets.zero,
                  children: [
                    //! spacer
                    160.sbH,

                    32.sbH,
                    //! choose category
                    AppFadeAnimation(
                      delay: 1.8,
                      child: SizedBox(
                        height: 32.h,
                        child: ValueListenableBuilder(
                            valueListenable: selectedCategoryIndex,
                            child: const SizedBox.shrink(),
                            builder: (context, value, child) {
                              return ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 16.w),
                                    child: InkWell(
                                      onTap: () {
                                        selectedCategoryIndex.value = index;
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 6.h),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: selectedCategoryIndex.value ==
                                                  index
                                              ? Pallete.yellowColor
                                              : null,
                                          border: Border.all(
                                            color:
                                                selectedCategoryIndex.value ==
                                                        index
                                                    ? Pallete.yellowColor
                                                    : Pallete.dividerGreyColor,
                                          ),
                                        ),
                                        child: Text(
                                          categories[index],
                                          style: TextStyle(
                                            color:
                                                selectedCategoryIndex.value ==
                                                        index
                                                    ? Pallete.whiteColor
                                                    : Pallete.textGrey,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // TransparentButton(
                                    //   onTap: () {
                                    //     selectedCategoryIndex.value = index;
                                    //   },
                                    //   height: 32.h,
                                    //   width: 82.w,
                                    //   color: selectedCategoryIndex.value == index
                                    //       ? Pallete.yellowColor
                                    //       : Pallete.dividerGreyColor,
                                    //   backgroundColor:
                                    //       selectedCategoryIndex.value == index
                                    //           ? Pallete.yellowColor
                                    //           : null,
                                    //   textColor: selectedCategoryIndex.value == index
                                    //       ? Pallete.whiteColor
                                    //       : Pallete.textGrey,
                                    //   text: categories[index],
                                    // ),
                                  );
                                },
                              );
                            }),
                      ),
                    ),
                    24.sbH,

                    //! sliding/scaling widget for categories
                    ValueListenableBuilder(
                        valueListenable: selectedCategoryIndex,
                        child: const SizedBox.shrink(),
                        builder: (context, value, child) {
                          return SizedBox(
                            height: 253.h,
                            child: selectedCategoryIndex.value != 0 &&
                                    selectedCategoryIndex.value != 1
                                ? ref
                                    .watch(getRestaurantBasedOnCuisineProvider(
                                        categories[
                                            selectedCategoryIndex.value]))
                                    .when(
                                      data: (chickenRestaurant) {
                                        if (chickenRestaurant.isEmpty) {
                                          return const ErrorText(
                                            error:
                                                'There are no restaurants available',
                                          );
                                        }

                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          padding: 24.padH,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(
                                                  parent:
                                                      BouncingScrollPhysics()),
                                          controller: _controller,
                                          itemCount: chickenRestaurant.length,
                                          itemBuilder: (context, index) {
                                            RestaurantModel restaurant =
                                                chickenRestaurant[index];
                                            return ItemCardWidget(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  barrierColor:
                                                      Pallete.blackColor,
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) => Wrap(
                                                    children: [
                                                      RestaurantBottomSheet(
                                                        restauranstId:
                                                            restaurant.id
                                                                .toString(),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              isFeatured: false,
                                              image: restaurant.cover_photo,
                                              name: restaurant.name,
                                              stars: restaurant.rating,
                                            );
                                            // return _buildPageItem(index);
                                          },
                                        );
                                      },
                                      error: (error, stackTrace) =>
                                          ErrorText(error: error.toString()),
                                      loading: () => const Loader(),
                                    )
                                : allRestaurants.when(
                                    data: (restaurants) {
                                      if (restaurants.isEmpty) {
                                        return const ErrorText(
                                            error:
                                                'There are no restaurants available');
                                      }

                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        padding: 24.padH,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(
                                                parent:
                                                    BouncingScrollPhysics()),
                                        controller: _controller,
                                        itemCount: restaurants.length,
                                        itemBuilder: (context, index) {
                                          RestaurantModel restaurant =
                                              restaurants[index];
                                          return ItemCardWidget(
                                            onTap: () {
                                              showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                barrierColor:
                                                    Pallete.blackColor,
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) => Wrap(
                                                  children: [
                                                    RestaurantBottomSheet(
                                                      restauranstId: restaurant
                                                          .id
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            isFeatured: false,
                                            image: restaurant.cover_photo,
                                            name: restaurant.name,
                                            stars: restaurant.rating,
                                          );
                                          // return _buildPageItem(index);
                                        },
                                      );
                                    },
                                    error: (error, stackTrace) =>
                                        ErrorText(error: error.toString()),
                                    loading: () => const Loader(),
                                  ),
                          );
                        }),
                    32.sbH,
                    Padding(
                      padding: 24.padH,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppTexts.featuredRestaurants,
                            style: TextStyle(
                              color: Pallete.textBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            AppTexts.seeAll,
                            style: TextStyle(
                              color: Pallete.textGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    24.sbH,
                    const ItemCardWidget(
                      isFeatured: true,
                      image:
                          'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60',
                      name: 'Dummy Restaurant',
                      stars: '4.5',
                    ),
                    40.sbH,
                  ],
                ),
              ),
            ),

            //! header, search
            Container(
              color: Pallete.whiteColor.withOpacity(0.88),
              height: 165.h,
              child: Column(
                children: [
                  55.sbH,
                  Padding(
                    padding: 31.padH,
                    child: AppFadeAnimation(
                      delay: 1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppTexts.deliveringTo,
                                style: TextStyle(
                                  color: Pallete.textGrey,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              7.sbH,
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'location'.svg,
                                    height: 13.3.h,
                                  ),
                                  6.3.sbW,
                                  Text(
                                    '15,anthony,oregun,ikeja,lagos',
                                    style: TextStyle(
                                      color: Pallete.textGrey,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  6.3.sbW,
                                  Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Pallete.yellowColor,
                                    size: 20.sp,
                                  )
                                ],
                              ),
                            ],
                          ),
            
                          // notification button
                          Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              border: Border.all(color: Pallete.dividerGreyColor),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: SizedBox(
                              height: 20.h,
                              child: SvgPicture.asset('bell'.svg),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  24.sbH,
            
                  //! discount image
                  // Padding(
                  //   padding: 24.padH,
                  //   child: AppFadeAnimation(
                  //     delay: 1.4,
                  //     child: Container(
                  //       height: 126.h,
                  //       width: 327.w,
                  //       decoration: BoxDecoration(
                  //           image: DecorationImage(
                  //             image: AssetImage('food-discount'.png),
                  //             fit: BoxFit.cover,
                  //           ),
                  //           borderRadius: BorderRadius.circular(12.r)),
                  //     ),
                  //   ),
                  // ),
                  // 24.sbH,
            
                  //! search
                  AppFadeAnimation(
                    delay: 1.6,
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const SearchRestaurantsView();
                          },
                        ));
                      },
                      child: Hero(
                        tag: 'search',
                        child: Container(
                          margin: 24.padH,
                          padding: 18.padH,
                          height: 40.h,
                          width: 327.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: Pallete.dividerGreyColor),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset('search'.svg),
                              10.7.sbW,
                              Text(
                                AppTexts.search,
                                style: TextStyle(
                                  color: Pallete.textGrey,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }

  //! widget for the slider
  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.7;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: const ItemCardWidget(
        isFeatured: false,
        image: '',
        name: '',
        stars: '',
      ),
    );
  }
}

const categories = [
  'All',
  'Popular',
  'Chicken',
  'Seafood',
  'Vegetarian',
  'Beef',
  'Pizza',
  'Western',
  'Northern Nigeria',
  'Fast Food',
];
