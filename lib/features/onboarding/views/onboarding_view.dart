import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/features/auth/views/login_view.dart';
import 'package:shaap_mobile_app/features/auth/views/sign_up_view.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  final ValueNotifier<double> _currentPageValue = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPageValue.value = _controller.page!;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToSignUp() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SignUpView(),
    ));
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginView(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            // page view
            SizedBox(
              height: 570.h,
              child: PageView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                controller: _controller,
                children: [
                  // onboarding 1
                  Column(
                    children: [
                      Container(
                        height: 398.h,
                        width: width(context),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('onboarding-image-1'.png),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      39.sbH,
                      Text(
                        AppTexts.onboardingTitle1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Pallete.textBlack,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      17.sbH,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Text(
                          AppTexts.onboardingSub1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Pallete.textGrey,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // onboarding 2
                  Column(
                    children: [
                      Container(
                        height: 398.h,
                        width: width(context),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('onboarding-image-2'.png),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      39.sbH,
                      Text(
                        AppTexts.onboardingTitle2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Pallete.textBlack,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      17.sbH,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Text(
                          AppTexts.onboardingSub2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Pallete.textGrey,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SmoothPageIndicator(
                controller: _controller,
                count: 2,
                effect: ExpandingDotsEffect(
                  expansionFactor: 5,
                  dotWidth: 8.w,
                  dotHeight: 8.h,
                  dotColor: Pallete.dotGreyColor,
                  activeDotColor: Pallete.yellowColor,
                ),
              ),
            ),
            // create account/login
            SizedBox(
              height: 231.h,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  40.sbH,
                  BButton(
                    width: 327.w,
                    onTap: navigateToSignUp,
                    text: AppTexts.createAnAccount,
                  ),
                  20.sbH,
                  TextButton(
                    onPressed: navigateToLogin,
                    child: Text(
                      AppTexts.loginInstead,
                      style: TextStyle(
                        color: Pallete.textGrey,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
