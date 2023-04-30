import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shaap_mobile_app/features/auth/controllers/auth_controller.dart';
import 'package:shaap_mobile_app/features/profile/views/about_view.dart';
import 'package:shaap_mobile_app/features/profile/views/addresses_view.dart';
import 'package:shaap_mobile_app/features/profile/views/profile_details_view.dart';
import 'package:shaap_mobile_app/features/profile/views/support_view.dart';
import 'package:shaap_mobile_app/features/profile/widgets/profile_tile.dart';
import 'package:shaap_mobile_app/shared/app_texts.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/string_extensions.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  void navigateToAbout(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AboutView(),
      ),
    );
  }

  void navigateToProfileDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ProfileDetailsView(),
      ),
    );
  }

  void navigateToAddresses(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddressesView(),
      ),
    );
  }

  void navigateToSupport(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SupportView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      body: Container(
        padding: 24.padH,
        color: Pallete.whiteColor,
        child: Column(
          children: [
            52.sbH,
            Align(
              alignment: Alignment.center,
              child: Text(
                AppTexts.profile,
                style: TextStyle(
                  color: Pallete.textBlack,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            28.sbH,
            //! profile photo
            SizedBox(
              height: 64.h,
              width: 68.w,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: CircleAvatar(
                      radius: 32.h,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: SvgPicture.asset('changedp'.svg),
                  ),
                ],
              ),
            ),

            9.sbH,
            //! name
            Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(
                color: Pallete.textBlack,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            6.sbH,
            //! mail
            Text(
              user.email,
              style: TextStyle(
                color: Pallete.textGrey,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

            32.sbH,
            //! profile items
            Column(
              children: profileItems
                  .map(
                    (profileItem) => ProfileTile(
                      onTap: () {
                        switch (profileItem.title) {
                          case AppTexts.about:
                            navigateToAbout(context);
                            break;

                          case AppTexts.profiledetails:
                            navigateToProfileDetails(context);
                            break;

                          case AppTexts.addresses:
                            navigateToAddresses(context);
                            break;

                          case AppTexts.support:
                            navigateToSupport(context);
                            break;
                        }
                      },
                      icon: profileItem.icon,
                      title: profileItem.title,
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileItem {
  final String icon;
  final String title;
  const ProfileItem({
    required this.icon,
    required this.title,
  });
}

const profileItems = [
  ProfileItem(
    icon: 'promotions',
    title: AppTexts.promotions,
  ),
  ProfileItem(
    icon: 'about',
    title: AppTexts.about,
  ),
  ProfileItem(
    icon: 'profiledetails',
    title: AppTexts.profiledetails,
  ),
  ProfileItem(
    icon: 'addresses',
    title: AppTexts.addresses,
  ),
  ProfileItem(
    icon: 'support',
    title: AppTexts.support,
  ),
];
