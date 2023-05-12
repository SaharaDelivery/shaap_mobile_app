// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/features/auth/controllers/auth_controller.dart';
import 'package:shaap_mobile_app/features/profile/views/delete_account_view.dart';
import 'package:shaap_mobile_app/features/profile/widgets/profile_details_widget.dart';
import 'package:shaap_mobile_app/features/profile/widgets/profile_tile.dart';

import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/loader.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileDetailsView extends ConsumerWidget {
  const ProfileDetailsView({super.key});

  void navigateToDeleteAcc(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const DeleteAccountView(),
      ),
    );
  }

  void logout(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: isLoading
          ? const Loader()
          : user == null
              ? const SizedBox.shrink()
              : Container(
                  color: Pallete.whiteColor,
                  padding: 24.padH,
                  child: Column(
                    children: [
                      50.sbH,
                      Row(
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
                            AppTexts.profiledetails,
                            style: TextStyle(
                              color: Pallete.textBlack,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          32.sbW,
                        ],
                      ),
                      40.sbH,

                      //! details
                      Padding(
                        padding: 4.padH,
                        child: Column(
                          children: [
                            ProfileDetailsWidget(
                              title: AppTexts.firstName,
                              content: user.firstName,
                            ),
                            16.sbH,
                            ProfileDetailsWidget(
                              title: AppTexts.lastName,
                              content: user.lastName,
                            ),
                            16.sbH,
                            ProfileDetailsWidget(
                              title: AppTexts.email,
                              content: user.email,
                            ),
                            16.sbH,
                            ProfileDetailsWidget(
                              title: AppTexts.phone,
                              content: user.phoneNumber,
                              color: Pallete.trackOrdersGrey,
                              contentColor: Pallete.textGreylighter,
                            ),
                          ],
                        ),
                      ),

                      220.sbH,
                      Column(
                        children: profileDetailsItem
                            .map(
                              (e) => ProfileTile(
                                onTap: () async {
                                  switch (e.title) {
                                    case AppTexts.deleteAcc:
                                      navigateToDeleteAcc(context);
                                      break;
                                    case AppTexts.logout:
                                      {
                                        // SharedPreferences preferences =
                                        //     await SharedPreferences.getInstance();
                                        // final res =
                                        //     await preferences.remove('x-auth-token');
                                        logout(context, ref);
                                      }
                                      break;
                                  }
                                },
                                icon: e.icon,
                                title: e.title,
                                arrowColor: Colors.transparent,
                                titleColor: Pallete.red,
                                borderColor: e.title == AppTexts.deleteAcc
                                    ? Colors.transparent
                                    : Pallete.lightRed,
                                fillColor: e.title == AppTexts.deleteAcc
                                    ? Pallete.lighterRed
                                    : null,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
    );
  }
}

class ProfileDetailsItem {
  final String icon;
  final String title;
  const ProfileDetailsItem({
    required this.icon,
    required this.title,
  });
}

const profileDetailsItem = [
  ProfileDetailsItem(
    icon: 'logout',
    title: AppTexts.logout,
  ),
  ProfileDetailsItem(
    icon: 'delete',
    title: AppTexts.deleteAcc,
  ),
];
