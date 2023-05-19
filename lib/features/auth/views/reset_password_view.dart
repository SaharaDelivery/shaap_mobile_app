import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/app_fade_animation.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/text_input.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

import '../../../shared/app_texts.dart';

class ResetPasswordView extends ConsumerStatefulWidget {
  const ResetPasswordView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordViewState();
}

class _ResetPasswordViewState extends ConsumerState<ResetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // pop page
  void leavePage() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 24.w).copyWith(bottom: 48.h),
          child: Column(
            children: [
              // spacer
              65.sbH,

              // logo,
              AppFadeAnimation(
                delay: 1.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TransparentButton(
                      onTap: () => leavePage(),
                      height: 32.h,
                      width: 32.w,
                      isText: false,
                      item: Icon(
                        Icons.arrow_back,
                        color: Pallete.textBlack,
                        size: 17.sp,
                      ),
                    ),
                    Image.asset(
                      'shaap'.png,
                      height: 28.h,
                    ),
                    32.sbW,
                  ],
                ),
              ),
              24.sbH,

              AppFadeAnimation(
                delay: 1.8,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    AppTexts.resetPassword,
                    style: TextStyle(
                      color: Pallete.textBlack,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              32.sbH,

              // text inputs
             AppFadeAnimation(
              delay: 1.4,
                child: TextInputWidget(
                  hintText: AppTexts.emailHint,
                  inputTitle: AppTexts.email,
                  controller: _emailController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.deny(
                        RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                ),
              ),
              const Spacer(),

              // button
             AppFadeAnimation(
              delay: 1.8,
                child: BButton(
                  onTap: () {},
                  text: AppTexts.sendLink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
