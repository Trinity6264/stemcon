import 'dart:convert';

import 'package:sms_autofill/sms_autofill.dart';
import 'package:stemcon/models/country_codes_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';
import 'package:stemcon/models/new_user.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stemcon/views/authentication/otp_verify.dart';

import '../utils/code/country_code.dart';

class AuthenticationViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();

  final _apiService = locator<ApiService>();
  final _snackbarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();

  // get app signature
  void getSignature() {
    SmsAutoFill().getAppSignature.then((signature) {
      appSignature = signature;
    });
  }

  String? appSignature;

  CountryCodesModel? countryCode = countryCodeDatas[0];

  void toOtpView({
    required String? companyCode,  
    required int? number,
  }) async {
    if (number == null || countryCode == null || appSignature == null) {
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Entry can\'t be empty');
    } else if (number.toString().length < 9) {
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(
          message: 'Number is less than 9 characters');
    } else {
      setBusy(true);
      final userModel = NewUser(
        companyCode: companyCode,
        number: number,
        countryCode: countryCode!.callingCode!,
        appSignature: appSignature,
      );
      final response = await _apiService.createAccount(userModel: userModel);
      if (response.statusCode == 200) {
        setBusy(false);
        final data = jsonDecode(response.body);
        if (data['res_code'] == "1") {
          _navService.navigateToView(
            OtpVerify(
              countryCode: countryCode!.callingCode!,
              countryNumber: number,
            ),
          );
          return;
        } else {
          _dialogService.showDialog(
              title: 'Authentication', description: data['res_message']);
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
  }

  void getCountryCode(CountryCodesModel country) {
    countryCode = country;
    notifyListeners();
  }
}
