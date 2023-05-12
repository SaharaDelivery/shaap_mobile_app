import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shaap_mobile_app/features/auth/controllers/auth_controller.dart';
import 'package:shaap_mobile_app/features/profile/controllers/profile_controller.dart';
import 'package:shaap_mobile_app/theme/palette.dart';
import 'package:shaap_mobile_app/utils/button.dart';
import 'package:shaap_mobile_app/utils/loader.dart';
import 'package:shaap_mobile_app/utils/text_input.dart';
import 'package:shaap_mobile_app/utils/widget_extensions.dart';

class AddAddressView extends ConsumerStatefulWidget {
  const AddAddressView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends ConsumerState<AddAddressView> {
  final TextEditingController _generalAreaController = TextEditingController();
  final TextEditingController _specificController = TextEditingController();

  @override
  void dispose() {
    _generalAreaController.dispose();
    _specificController.dispose();
    super.dispose();
  }

  void addAddress({
    required WidgetRef ref,
    required String address_1,
    required String address_2,
    required String phone_number,
    required String email,
  }) {
    ref.watch(profileControllerProvider.notifier).addAndSaveAddress(
          context: context,
          address_1: address_1,
          address_2: address_2,
          phone_number: phone_number,
          email: email,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileControllerProvider);
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallete.whiteColor,
        foregroundColor: Pallete.blackColor,
      ),
      backgroundColor: Pallete.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ).copyWith(bottom: 50.h),
        child: Column(
          children: [
            TextInputWidget(
              hintText: '15B, Jhn Street',
              inputTitle: 'Specific Area',
              controller: _specificController,
            ),
            24.sbH,
            TextInputWidget(
              hintText: ' Doe Estate, Lokogoma',
              inputTitle: 'General Area',
              controller: _generalAreaController,
            ),
            const Spacer(),
            isLoading
                ? const Loader()
                : BButton(
                    onTap: () => addAddress(
                      ref: ref,
                      address_1: _generalAreaController.text,
                      address_2: _specificController.text,
                      phone_number: user.phoneNumber,
                      email: user.email,
                    ),
                    text: 'Save Address',
                  ),
          ],
        ),
      ),
    );
  }
}
