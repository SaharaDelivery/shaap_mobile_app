import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/app_fade_animation.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/text_input.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class ProfileDetailsFormView extends ConsumerStatefulWidget {
  const ProfileDetailsFormView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileDetailsFormViewState();
}

class _ProfileDetailsFormViewState
    extends ConsumerState<ProfileDetailsFormView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<String> typedFirstName = ValueNotifier('');
  final ValueNotifier<String> typedLastName = ValueNotifier('');
  final ValueNotifier<String> typedUserName = ValueNotifier('');
  final ValueNotifier<String> typedPhone = ValueNotifier('');
  String phoneNumberWithCountryCode = '';

// pop page
  void leavePage() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _phoneController.dispose();
    typedFirstName.dispose();
    typedLastName.dispose();
    typedUserName.dispose();
    typedPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
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
                  AppTexts.letsgettoknow,
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
                hintText: AppTexts.firstNameHint,
                inputTitle: AppTexts.firstName,
                controller: _firstNameController,
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
            24.sbH,
            AppFadeAnimation(
              delay: 1.8,
              child: TextInputWidget(
                hintText: AppTexts.lastNameHint,
                inputTitle: AppTexts.lastName,
                controller: _lastNameController,
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
            24.sbH,
            AppFadeAnimation(
              delay: 2,
              child: TextInputWidget(
                hintText: AppTexts.userNameHint,
                inputTitle: AppTexts.userName,
                controller: _userNameController,
                inputFormatters: [
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
            24.sbH,
            AppFadeAnimation(
              delay: 2.2,
              child: SizedBox(
                height: 74.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.phone,
                      style: TextStyle(
                          color: Pallete.textGreydarker,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 48.h,
                      child: IntlPhoneField(
                        controller: _phoneController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          // LengthLimitingTextInputFormatter(10)
                        ],
                        initialCountryCode: 'NG',
                        flagsButtonMargin: EdgeInsets.only(left: 10.w),
                        // disableLengthCheck: true,
                        dropdownIconPosition: IconPosition.leading,
                        dropdownIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Pallete.textGreylighter,
                        ),
                        decoration: InputDecoration(
                          helperText: " ",
                          helperStyle: const TextStyle(fontSize: 0.0005),
                          errorStyle: const TextStyle(fontSize: 0.0005),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Pallete.borderGrey),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Pallete.borderGrey),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Pallete.borderGrey),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Pallete.borderGrey),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onChanged: (phone) {
                          String phoneNumber = phone.number.substring(1);

                          setState(() => phoneNumberWithCountryCode =
                              '${phone.countryCode}$phoneNumber');
                        },
                        onCountryChanged: (country) {
                          log('Country changed to: ${country.name}');
                          log(_phoneController.text);
                        },
                        validator: (val) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),

            180.sbH,
            // continue button
            AppFadeAnimation(
              delay: 2.4,
              child: BButton(
                onTap: () {},
                text: AppTexts.continueButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
