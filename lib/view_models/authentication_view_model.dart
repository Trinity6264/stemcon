import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:stemcon/models/country_codes_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';
import 'package:stemcon/models/new_user.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stemcon/services/shared_prefs_service.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:telephony/telephony.dart';

import '../utils/code/country_code.dart';

class AuthenticationViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  final _prefsService = locator<SharedPrefsservice>();
  final _apiService = locator<ApiService>();
  final _snackbarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();

  final telephony = Telephony.instance;

  CountryCodesModel? countryCode = countryCodeDatas[0];

  void toOtpView({
    required int companyCode,
    required String number,
  }) async {
    bool? permissionsGranted = await telephony.requestPhoneAndSmsPermissions;
    if (permissionsGranted != null && permissionsGranted) {
      if (number == '' || countryCode == null) {
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: 'Entry can\'t be empty');
      } else if (number.length < 9) {
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(
            message: 'Number is less than 9 characters');
      } else {
        setBusy(true);
        final userModel = NewUser(
          company: companyCode,
          number: number,
          countryCode: countryCode!.callingCode,
        );
        final response = await _apiService.createAccount(userModel: userModel);
        if (response.statusCode == 200) {
          setBusy(false);
          final data = jsonDecode(response.body);
          if (data['res_code'] == "1") {
            _navService.navigateTo(
              Routes.otpView,
              arguments: OtpViewArguments(companyCode: companyCode),
            );
            return;
          } else {
            _dialogService.showDialog(
              title: 'Authentication',
              description: data['res_message'],
            );
            return;
          }
        } else {
          _dialogService.showDialog(
            title: 'Failed',
            description: "Something went wrong try again",
          );
        }
        setBusy(false);
        return;
      }
    } else {
      _snackbarService.registerSnackbarConfig(
        SnackbarConfig(
          messageColor: whiteColor,
        ),
      );
      _snackbarService.showSnackbar(
        message: 'Please grant permissions to continue',
        duration: const Duration(seconds: 3),
      );
    }
  }

  void getCountryCode(CountryCodesModel country) {
    countryCode = country;
    notifyListeners();
  }
}
