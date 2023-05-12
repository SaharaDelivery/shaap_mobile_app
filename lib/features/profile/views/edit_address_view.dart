// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

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

class EditAddressView extends ConsumerStatefulWidget {
  final String specificAddress;
  final String generalAddress;
  final int id;
  const EditAddressView({
    super.key,
    required this.specificAddress,
    required this.generalAddress,
    required this.id,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditAddressViewState();
}

class _EditAddressViewState extends ConsumerState<EditAddressView> {
  TextEditingController _generalAreaController = TextEditingController();
  TextEditingController _specificController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _generalAreaController = TextEditingController(text: widget.generalAddress);
    _specificController = TextEditingController(text: widget.specificAddress);
  }

  @override
  void dispose() {
    _generalAreaController.dispose();
    _specificController.dispose();
    super.dispose();
  }

  void editAddress({
    required WidgetRef ref,
    required String address_1,
    required String address_2,
    required String phone_number,
    required String email,
    required bool saved,
  }) {
    ref.watch(profileControllerProvider.notifier).editAddress(
          id: widget.id.toString(),
          context: context,
          address_1: address_1,
          address_2: address_2,
          phone_number: phone_number,
          email: email,
          saved: saved,
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
        centerTitle: true,
        title: const Text('Edit'),
      ),
      backgroundColor: Pallete.whiteColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
        ).copyWith(bottom: 50.h, top: 20.h),
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
                    onTap: () {
                      log(widget.id.toString());
                      editAddress(
                        ref: ref,
                        address_1: _generalAreaController.text,
                        address_2: _specificController.text,
                        phone_number: user.phoneNumber,
                        email: user.email,
                        saved: true,
                      );
                    },
                    text: 'Save Address',
                  ),
          ],
        ),
      ),
    );
  }
}
