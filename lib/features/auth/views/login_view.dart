// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shaap_mobile_app/features/auth/controllers/auth_controller.dart';

import 'package:shaap_mobile_app/features/auth/views/reset_password_view.dart';
import 'package:shaap_mobile_app/features/auth/views/sign_up_view.dart';
import 'package:shaap_mobile_app/features/auth/widgets/password_widget.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/app_fade_animation.dart';
import 'package:shaap_mobile_app/utils/app_multi_value_listenable_builder.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/loader.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/text_input.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class LoginView extends ConsumerStatefulWidget {
  final String? email;
  const LoginView({
    super.key,
    this.email,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final ValueNotifier<TextEditingController> _passwordController =
      ValueNotifier(TextEditingController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isPasswordInvisible = ValueNotifier(true);
  final ValueNotifier<String> typedPassword = ValueNotifier('');

  void passwordVisibility() =>
      isPasswordInvisible.value = !isPasswordInvisible.value;

// navigate to reset password
  void navigateToResetPassword() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ResetPasswordView(),
    ));
  }

  // navigate to sign up
  void navigateToSignUp() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SignUpView(),
    ));
  }

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email ?? '';
  }

  void loginUser() {
    ref.read(authControllerProvider.notifier).loginUser(
          context: context,
          email: _emailController.text,
          password: _passwordController.value.text,
        );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    isPasswordInvisible.dispose();
    typedPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: isLoading
            ? const Loader()
            : ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics()),
                children: [
                  // spacer
                  65.sbH,

                  // logo, create account
                  Align(
                    alignment: Alignment.center,
                    child: AppFadeAnimation(
                      delay: 1.8,
                      child: Image.asset(
                        'shaap'.png,
                        height: 28.h,
                      ),
                    ),
                  ),
                  24.sbH,

                  AppFadeAnimation(
                    delay: 1.4,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppTexts.loginButton,
                            style: TextStyle(
                              color: Pallete.textBlack,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        32.sbH,
                        TextInputWidget(
                          hintText: AppTexts.emailHint,
                          inputTitle: AppTexts.email,
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                        24.sbH,
                        AppMultiListenableProvider(
                            firstValue: _passwordController,
                            secondValue: isPasswordInvisible,
                            child: const SizedBox.shrink(),
                            builder: (context, firstValue, secondValue, child) {
                              return TextInputWidget(
                                obscuretext: isPasswordInvisible.value,
                                hintText: AppTexts.passwordHint,
                                inputTitle: AppTexts.password,
                                onChanged: (value) {
                                  typedPassword.value =
                                      _passwordController.value.text;
                                },
                                controller: _passwordController.value,
                                suffixIcon: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: passwordVisibility,
                                  child:
                                      // SizedBox(
                                      //   height: 10.h,
                                      //   width: 10.w,
                                      //   child: Image.asset(
                                      //     'eye'.png,
                                      //     color: isPasswordInvisible.value == true
                                      //         ? Pallete.textGreydarker
                                      //         : Pallete.yellowColor,
                                      //   ),
                                      // ),
                                      isPasswordInvisible.value == true
                                          ? Icon(PhosphorIcons.eyeSlash,
                                              size: 20.w,
                                              color: Pallete.textGreydarker)
                                          : Icon(
                                              PhosphorIcons.eyeBold,
                                              size: 20.w,
                                              color: Pallete.yellowColor,
                                            ),
                                ),
                                validator: (val) {
                                  if (val == null ||
                                      val.isEmpty ||
                                      val.length < 8 ||
                                      !val.contains(
                                          RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ||
                                      !val.contains(RegExp(r'[A-Z]')) ||
                                      !val.contains(RegExp(r'[a-z]')) ||
                                      !val.contains(RegExp(r'[0-9]'))) {
                                    return '';
                                  }
                                  return null;
                                },
                              );
                            }),

                        32.sbH,
                        //login button
                        BButton(
                          onTap: () {
                            if (_formKey.currentState!.validate() == true) {
                              loginUser();
                            }
                          },
                          text: AppTexts.loginButton,
                        ),

                        // forgot password
                        10.sbH,
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: navigateToResetPassword,
                            child: Text(
                              AppTexts.forgotPassword,
                              style: TextStyle(
                                color: Pallete.yellowColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  24.sbH,
                  // or divider
                  AppFadeAnimation(
                    delay: 2.4,
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Pallete.dividerGreyColor,
                            thickness: 2,
                            endIndent: 11.w,
                          ),
                        ),
                        Text(
                          'OR',
                          style: TextStyle(
                            color: Pallete.textGrey,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Pallete.dividerGreyColor,
                            thickness: 2,
                            indent: 11.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                  24.sbH,

                  // google button
                  AppFadeAnimation(
                    delay: 1.4,
                    child: Column(
                      children: [
                        TransparentButton(
                          onTap: () {},
                          isText: false,
                          item: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'google-icon'.png,
                                height: 21.8.h,
                              ),
                              11.sbW,
                              Text(
                                AppTexts.signInGoogle,
                                style: TextStyle(
                                  color: Pallete.textGreydarker,
                                  fontSize: 14.53.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        11.sbH,

                        // apple button
                        BButton(
                          onTap: () {},
                          color: Pallete.blackColor,
                          isText: false,
                          item: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'apple-icon'.png,
                                height: 21.8.h,
                              ),
                              11.sbW,
                              Text(
                                AppTexts.signInApple,
                                style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontSize: 14.53.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        23.7.sbH,
                        // already have account
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: AppTexts.dontHaveAccount,
                            style: TextStyle(
                              color: Pallete.textGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => navigateToSignUp(),
                                text: AppTexts.signUp,
                                style: TextStyle(
                                  color: Pallete.yellowColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  16.sbH,
                  // terms
                  AppFadeAnimation(
                    delay: 2.4,
                    child: RichText(
                      text: TextSpan(
                        text: AppTexts.proceeding,
                        style: TextStyle(
                          color: Pallete.textGrey,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: AppTexts.terms,
                            style: TextStyle(
                              color: Pallete.textGreydarker,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              color: Pallete.textGrey,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: AppTexts.privacy,
                            style: TextStyle(
                              color: Pallete.textGreydarker,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
