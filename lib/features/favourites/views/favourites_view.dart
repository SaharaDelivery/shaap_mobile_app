import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shaap_mobile_app/features/home/widgets/item_card_widget.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class FavouritesView extends ConsumerWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> faves = [];
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
                    AppTexts.favorites,
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
                child: faves.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('no-favourites'.svg),
                            24.sbH,
                            Text(
                              AppTexts.noFavourites,
                              style: TextStyle(
                                color: Pallete.textBlack,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            10.sbH,
                            Text(
                              AppTexts.youDoNotHaveFaves,
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
                            padding: EdgeInsets.only(bottom: 25.h),
                            child: const ItemCardWidget(
                              isFeatured: true,
                              image:
                                  'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&auto=format&fit=crop&w=900&q=60',
                              name: 'Dummy Restaurant',
                              stars: '4.5',
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
