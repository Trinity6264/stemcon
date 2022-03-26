import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';
import 'package:stemcon/models/add_project2_model.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stemcon/utils/color/color_pallets.dart';

class NewProjectViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _snackbarService = locator<SnackbarService>();

  String selectedTimeZone = '';

  List<String> listOfselectedTimeZone = [];

  List<int> manWorkingHour = [];

  List<String> listOfunits = ['MM', 'Ft', 'CM'];
  String? unit;
  String manHour = '1';

  Future<void> requestTime() async {
    try {
      selectedTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    } catch (e) {
      if (kDebugMode) {
        print('Could not get the local timezone');
      }
    }
    try {
      listOfselectedTimeZone =
          await FlutterNativeTimezone.getAvailableTimezones();
      listOfselectedTimeZone.sort();
    } catch (e) {
      if (kDebugMode) {
        print('Could not get available timezones');
      }
    }
    notifyListeners();
  }

  void generatingManWorkingHour() {
    List.generate(12, (index) => manWorkingHour.add(index));
  }

  void onChangedUnit(String? value) {
    unit = value!;
    notifyListeners();
  }
  //

  void back() {
    _navService.back();
  }

  void onChangedTime(dynamic selected) {
    selectedTimeZone = selected;
    notifyListeners();
  }

  void onChangedManHour(dynamic selected) {
    manHour = selected;
    notifyListeners();
  }

  Future<void> submitData({
    required int userId,
    required int token,
    required int id,
    required String adminStatus,
    required String workingHour,
    required String purpose,
    required String keyPoints,
    required String address,
    required String timeZone,
  }) async {
    print('userId: $userId');
    print('Token: $token');
    print('Id: $id');
    print('AdminS: $adminStatus');
    print('Working: $workingHour');
    print('purpose: $purpose');
    print('KeyPoints: $keyPoints');
    print('Address: $address');
    print('time: $timeZone');
    if (workingHour == '' ||
        purpose == '' ||
        keyPoints == '' ||
        address == '' ||
        unit == null ||
        selectedTimeZone == '') {
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Entry can\'t be empty');
      return;
    } else {
      setBusy(true);
      final projectContent = AddProject2Model(
        id: id,
        token: token,
        userId: userId,
        projectAddress: address,
        projectAdmin: adminStatus,
        projectKeyPoint: keyPoints,
        projectManHour: workingHour,
        projectPurpose: purpose,
        projectStatus: 'active',
        projectTimezone: timeZone,
        projectUnit: unit,
      );
      final response =
          await _apiService.addProject2(postContent: projectContent);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['res_code'] == '1') {
          setBusy(false);
          _snackbarService.registerSnackbarConfig(SnackbarConfig(
            messageColor: whiteColor,
          ));
          _snackbarService.showSnackbar(message: 'Project add successfully');
          _navService.replaceWith(Routes.homeView);
          return;
        }
        {
          setBusy(false);
          _snackbarService.registerSnackbarConfig(SnackbarConfig(
            messageColor: whiteColor,
          ));
          _snackbarService.showSnackbar(message: 'Project add unsuccessfully');
          return;
        }
      } else {
        setBusy(false);
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: 'Error occurred!');
      }
    }
  }
}
