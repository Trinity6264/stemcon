import 'dart:convert';

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
  String selectedWorkingUnit = '';
  String selectedTimeZone = '';

  List<String> workingUnit = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];

  void back() {
    _navService.back();
  }

  void onChangedUnits(dynamic selected) {
    selectedWorkingUnit = selected;
    notifyListeners();
  }
  void onChangedTime(dynamic selected) {
     selectedTimeZone = selected;
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
  }) async {
    if (workingHour == '' ||
        purpose == '' ||
        keyPoints == '' ||
        address == '' ||
        selectedWorkingUnit == '' ||
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
        projectTimezone: selectedTimeZone,
        projectUnit: selectedWorkingUnit,
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
