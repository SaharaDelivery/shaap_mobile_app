import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shaap_mobile_app/features/profile/repositories/profile_repository.dart';
import 'package:shaap_mobile_app/models/address_model.dart';
import 'package:shaap_mobile_app/utils/nav.dart';
import 'package:shaap_mobile_app/utils/shared_prefs.dart';

// get saved addresses provider
final getUsersSavedAddressProvider = FutureProvider.autoDispose((ref) {
  final profileController = ref.watch(profileControllerProvider.notifier);
  return profileController.getUsersSavedAddress();
});

final profileControllerProvider =
    StateNotifierProvider<ProfileController, bool>((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return ProfileController(
    profileRepository: profileRepository,
    ref: ref,
  );
});

class ProfileController extends StateNotifier<bool> {
  final ProfileRepository _profileRepository;
  final Ref _ref;
  ProfileController({
    required ProfileRepository profileRepository,
    required Ref ref,
  })  : _profileRepository = profileRepository,
        _ref = ref,
        super(false);

  //! add and save addresses
  void addAndSaveAddress({
    required BuildContext context,
    required String address_1,
    required String address_2,
    required String phone_number,
    required String email,
  }) async {
    state = true;
    final res = await _profileRepository.addAndSaveAddress(
      address_1: address_1,
      address_2: address_2,
      phone_number: phone_number,
      email: email,
    );

    state = false;

    res.fold(
      (l) => log(l.message),
      (r) {
        goBack(context);
        log('Address saved');
        _ref.invalidate(getUsersSavedAddressProvider);
      },
    );
  }

  //! add and choose save addresses
  void addtemporaryAddress({
    required BuildContext context,
    required String address_1,
    required String address_2,
    required String phone_number,
    required String email,
  }) async {
    state = true;
    final res = await _profileRepository.addAndChooseAddress(
      saved: false,
      address_1: address_1,
      address_2: address_2,
      phone_number: phone_number,
      email: email,
    );

    state = false;

    res.fold(
      (l) => log(l.message),
      (r) {
        goBack(context);
        log('Address saved');
        _ref.invalidate(getUsersSavedAddressProvider);
      },
    );
  }

  //! get saved addresses
  Future<List<AddressModel>> getUsersSavedAddress() async {
    return _profileRepository.getUsersSavedAddress();
  }

  //! edit address
  void editAddress({
    required BuildContext context,
    required String address_1,
    required String address_2,
    required String phone_number,
    required String email,
    required String id,
    required bool saved,
  }) async {
    state = true;

    final res = await _profileRepository.editAddress(
      addressId: id,
      address_1: address_1,
      address_2: address_2,
      phone_number: phone_number,
      email: email,
      saved: saved,
    );

    state = false;

    res.fold(
      (l) => log(l.message),
      (r) {
        goBack(context);
        log('Address saved');
        _ref.invalidate(getUsersSavedAddressProvider);
      },
    );
  }
}
