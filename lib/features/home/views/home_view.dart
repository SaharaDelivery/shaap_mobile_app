import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaap_mobile_app/features/auth/controllers/auth_controller.dart';
import 'package:shaap_mobile_app/features/home/widgets/item_card_widget.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/app_fade_animation.dart';
import 'package:shaap_mobile_app/utils/button.dart';
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

  @override
  Widget build(BuildContext context) {
    //? final user = ref.watch(userProvider)!;
    _height = 253.h;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        child: Column(
          // padding: EdgeInsets.zero,
          children: [
            //! spacer
            55.sbH,
            Padding(
              padding: 31
                  .padH, //? this a simpler way of doing vertical and horizontal paddings I deviced
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
            Padding(
              padding: 24.padH,
              child: AppFadeAnimation(
                delay: 1.4,
                child: Container(
                  height: 126.h,
                  width: 327.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('food-discount'.png),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
            ),
            24.sbH,

            //! search
            AppFadeAnimation(
              delay: 1.6,
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
                            child: TransparentButton(
                              onTap: () {
                                selectedCategoryIndex.value = index;
                              },
                              height: 32.h,
                              width: 82.w,
                              color: selectedCategoryIndex.value == index
                                  ? Pallete.yellowColor
                                  : Pallete.dividerGreyColor,
                              backgroundColor:
                                  selectedCategoryIndex.value == index
                                      ? Pallete.yellowColor
                                      : null,
                              textColor: selectedCategoryIndex.value == index
                                  ? Pallete.whiteColor
                                  : Pallete.textGrey,
                              text: categories[index],
                            ),
                          );
                        },
                      );
                    }),
              ),
            ),
            24.sbH,

            //! sliding/scaling widget for categories
            SizedBox(
              height: 253.h,
              child: PageView.builder(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _controller,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildPageItem(index);
                },
              ),
            ),
          ],
        ),
      ),
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
      child: const ItemCardWidget(),
    );
  }
}

const categories = [
  'All',
  'Popular',
  'Pizza',
  'Rice',
  'Ice-cream',
];
