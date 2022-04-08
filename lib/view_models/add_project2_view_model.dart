import 'dart:convert';
import 'dart:io';
import 'package:contacts_service/contacts_service.dart';
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
  final _dialogService = locator<DialogService>();

  String selectedTimeZone = '';
  List<Contact> listOfContact = [];

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

  void gettingSelectedNumber(List<Contact> value) {
    listOfContact = value;
    notifyListeners();
  }

  void onChangedUnit(String? value) {
    unit = value!;
    debugPrint(listOfContact.toString());
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

  // Start contact implemtation

  void selectContact(Contact contact) {
    if (listOfContact.contains(contact)) {
      listOfContact.removeWhere((element) => element == contact);
      notifyListeners();
    } else {
      listOfContact.add(contact);
      notifyListeners();
    }
  }

  // End contact implemtation

  // Add project2
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
    } else if (listOfContact.isEmpty) {
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Add at least one member');
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
          for (Contact item in listOfContact) {
            final res = await _apiService.addMember(
              projectId: id.toString(),
              memberName: item.displayName ?? 'No name',
              memberMobileNumber: item.phones!.isEmpty
                  ? 'none'
                  : item.phones?.elementAt(0).value ?? '',
              token: token.toString(),
              userId: userId.toString(),
            );
            if (res.statusCode == 200) {
              _snackbarService.registerSnackbarConfig(SnackbarConfig(
                messageColor: whiteColor,
              ));
              _snackbarService.showSnackbar(
                  message: 'Members add successfully');
            }
          }
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

  // Edit project 2

  Future<void> editSubmitData({
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
    try {
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
          await _apiService.editProject2(postContent: projectContent);
      setBusy(false);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['res_code'] == '1') {
          _snackbarService.registerSnackbarConfig(SnackbarConfig(
            messageColor: whiteColor,
          ));
          _snackbarService.showSnackbar(
              message: 'Project Updated successfully');
          _navService.replaceWith(Routes.homeView);
          return;
        }
      } else {
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: 'Error occurred!');
      }
    } on HttpException catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
    }
  }
}
