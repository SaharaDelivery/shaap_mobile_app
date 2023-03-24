import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class SearchRestaurantsView extends ConsumerStatefulWidget {
  const SearchRestaurantsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchRestaurantsViewState();
}

class _SearchRestaurantsViewState extends ConsumerState<SearchRestaurantsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            60.sbH,
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
                    child: Icon(Icons.arrow_back_ios),
                  ),
                  SizedBox(
                    height: 40.h,
                    width: 300.w,
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIconConstraints: BoxConstraints(maxHeight: 20.h),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 18.w, right: 10.w),
                          child: SvgPicture.asset('search'.svg),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
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
                ],
              ),
            ),
            20.sbH,
            Expanded(
              child: Container(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
