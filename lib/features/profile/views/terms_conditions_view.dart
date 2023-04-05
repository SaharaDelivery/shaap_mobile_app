import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class TermsAndConditionsView extends ConsumerWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        color: Pallete.whiteColor,
        child: Column(
          children: [
            50.sbH,
            Padding(
              padding: 24.padH,
              child: Row(
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
                    AppTexts.tandc,
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

            //! body
            28.sbH,
            Text(
              AppTexts.generalTerms,
              style: TextStyle(
                color: Pallete.textBlack,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            16.sbH,
            Expanded(
              child: SingleChildScrollView(
                padding: 19.padH,
                child: Text(
                  'Lorem ipsum dolor sit amet consectetur. Neque euismod porta integer amet quis nisi habitasse. Sagittis aliquam purus sapien praesent. Maecenas cursus elit lacinia amet sit euismod convallis a. Neque sem mi pretium vestibulum elementum eu id quis. Sit tincidunt eu varius habitant amet. Id ut bibendum sit ipsum convallis et purus. Id malesuada arcu consequat sed est tristique. Ultrices maecenas venenatis id nec ut viverra non. Id malesuada placerat lorem mauris massa eget aliquam. Facilisis velit posuere semper dui massa convallis. Eu sit malesuada viverra habitasse aliquet integer blandit lorem. A et quis pellentesque arcu elementum sed gravida ullamcorper duis. Tellus tortor cum massa tellus euismod mattis. Erat nulla ut fermentum sed vel vulputate. In augue cras risus aliquam. Semper nisl quam vestibulum amet. Semper condimentum a eget in id vulputate pharetra. Quis dolor sapien tellus enim volutpat. Lectus nulla dolor feugiat praesent orci id et fringilla condimentum. Lacinia nulla risus dictum consectetur duis sed vestibulum enim sit. Quam quis amet quisque mi rhoncus morbi sed at mauris. Duis orci vel sagittis pellentesque maecenas diam augue. Sed cursus ac massa aliquet sed purus. Urna mi donec tellus posuere orci et morbi sed amet. Vel est enim morbi tristique neque congue. Nunc id sed libero ut. Tellus egestas eget mauris aenean molestie in. At eget vestibulum morbi consectetur luctus eu sapien praesent. Hendrerit faucibus rhoncus orci vestibulum vestibulum ipsum et arcu. Sit sed sapien pellentesque venenatis tempus eleifend. Morbi turpis enim arcu in. Lorem eget orci platea sit vestibulum eget nibh. Fermentum platea sed volutpat orci sed. Penatibus vulputate mollis aliquet eu quisque ornare morbi sem ut. Orci pellentesque varius vestibulum vel pharetra neque. Fringilla varius nibh ligula eu arcu. Id ultricies sit molestie sed non in quisque. Ac amet aliquet arcu sed malesuada purus. Est id tincidunt a eget suspendisse turpis. Ut penatibus faucibus sed gravida aliquam blandit. Fermentum augue adipiscing amet facilisis. Est nunc posuere est aliquet sagittis tellus. Velit viverra tincidunt quis enim nec vel sapien varius semper. Porttitor ut ipsum ut ligula diam duis vehicula. Nulla porttitor iaculis nunc donec justo dolor felis mus dui. Nec ut dui vel fermentum morbi sit iaculis nisl. Dolor massa lacus eros faucibus consectetur scelerisque. Lorem ipsum dolor sit amet consectetur. Neque euismod porta integer amet quis nisi habitasse. Sagittis aliquam purus sapien praesent. Maecenas cursus elit lacinia amet sit euismod convallis a. Neque sem mi pretium vestibulum elementum eu id quis. Sit tincidunt eu varius habitant amet. Id ut bibendum sit ipsum convallis et purus. Id malesuada arcu consequat sed est tristique. Ultrices maecenas venenatis id nec ut viverra non. Id malesuada placerat lorem mauris massa eget aliquam. Facilisis velit posuere semper dui massa convallis. Eu sit malesuada viverra habitasse aliquet integer blandit lorem. A et quis pellentesque arcu elementum sed gravida ullamcorper duis. Tellus tortor cum massa tellus euismod mattis. Erat nulla ut fermentum sed vel vulputate. In augue cras risus aliquam. Semper nisl quam vestibulum amet. Semper condimentum a eget in id vulputate pharetra. Quis dolor sapien tellus enim volutpat. Lectus nulla dolor feugiat praesent orci id et fringilla condimentum. Lacinia nulla risus dictum consectetur duis sed vestibulum enim sit. Quam quis amet quisque mi rhoncus morbi sed at mauris. Duis orci vel sagittis pellentesque maecenas diam augue. Sed cursus ac massa aliquet sed purus. Urna mi donec tellus posuere orci et morbi sed amet. Vel est enim morbi tristique neque congue. Nunc id sed libero ut. Tellus egestas eget mauris aenean molestie in. At eget vestibulum morbi consectetur luctus eu sapien praesent. Hendrerit faucibus rhoncus orci vestibulum vestibulum ipsum et arcu. Sit sed sapien pellentesque venenatis tempus eleifend. Morbi turpis enim arcu in. Lorem eget orci platea sit vestibulum eget nibh. Fermentum platea sed volutpat orci sed. Penatibus vulputate mollis aliquet eu quisque ornare morbi sem ut. Orci pellentesque varius vestibulum vel pharetra neque. Fringilla varius nibh ligula eu arcu. Id ultricies sit molestie sed non in quisque. Ac amet aliquet arcu sed malesuada purus. Est id tincidunt a eget suspendisse turpis. Ut penatibus faucibus sed gravida aliquam blandit. Fermentum augue adipiscing amet facilisis. Est nunc posuere est aliquet sagittis tellus. Velit viverra tincidunt quis enim nec vel sapien varius semper. Porttitor ut ipsum ut ligula diam duis vehicula. Nulla porttitor iaculis nunc donec justo dolor felis mus dui. Nec ut dui vel fermentum morbi sit iaculis nisl. Dolor massa lacus eros faucibus consectetur scelerisque.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Pallete.textBlack,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
