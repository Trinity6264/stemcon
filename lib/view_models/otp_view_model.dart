import 'dart:convert';
import 'dart:math';

import 'package:sms_autofill/sms_autofill.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:telephony/telephony.dart';

import 'package:stemcon/main.dart';

import '../app/app.locator.dart';
import '../app/app.router.dart';
import '../models/new_user.dart';
import '../services/api_service.dart';
import '../services/shared_prefs_service.dart';

class OtpViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _apiService = locator<ApiService>();
  final _prefsService = locator<SharedPrefsservice>();
  String otpCode = '';
  int? token;
  final telephony = Telephony.instance;

  //
  void generateToken() {
    token = Random().nextInt(9999999);
  }

  onMessage(SmsMessage message) {
    if (message.address == 'YCloud') {
      final data = message.body!.split(':');
      otpCode = data[1];

      notifyListeners();
      return;
    }
  }

  void listenForIncomingMessage() {
    telephony.listenIncomingSms(
      listenInBackground: false,
      onNewMessage: onMessage,
    );
  }

  void matchingOtp({
    required int companyCode,
  }) async {
    setBusy(true);
    try {
      final cornfirmOtp = ConfirmOtp(
        companyCode: companyCode,
        otp: int.parse(otpCode),
        token: token,
      );
      final response = await _apiService.cornfirmOtp(cornfirmOtp: cornfirmOtp);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['res_code'] == "1") {
          // persist data to local storage
          await _prefsService.savedUserState(1);
          await _prefsService.savedUserData(
            key: 'id',
            value: data['res_data']['id'],
            index: 0,
          );
          await _prefsService.savedUserData(
            key: 'company_code',
            value: data['res_data']['company_code'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'country_code',
            value: data['res_data']['country_code'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'mobile_number',
            value: data['res_data']['mobile_number'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'otp',
            value: data['res_data']['otp'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'is_admin',
            value: data['res_data']['is_admin'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'status',
            value: data['res_data']['status'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'authentication_token',
            value: data['res_data']['authentication_token'],
            index: 0,
          );
          await _prefsService.savedUserData(
            key: 'created_at',
            value: data['res_data']['created_at'],
            index: 1,
          );
          await _prefsService.savedUserData(
            key: 'updated_at',
            value: data['res_data']['updated_at'],
            index: 1,
          );
          _navService.replaceWith(Routes.homeView);
          setBusy(false);
          return;
        } else {
          setBusy(false);
          _dialogService.showDialog(
            title: 'Authentication',
            description: data['res_message'],
          );
        }
      } else {
        setBusy(false);
        _dialogService.showDialog(
          title: 'Failed',
          description: "Something went wrong try again",
        );
      }
    } on Exception catch (e) {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Failed',
        description: e.toString(),
      );
    }
  }
}
