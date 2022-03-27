
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';

import 'package:stemcon/services/api_service.dart';
import 'package:stemcon/services/file_selector_service.dart';
import 'package:stemcon/utils/color/color_pallets.dart';

class AddProjectViewModel extends BaseViewModel {
  final _imagePicker = locator<FileSelectorService>();
  final _snackbarService = locator<SnackbarService>();
  final _navService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  File? imageSelected;

  String? startDate;
  String? endDate;

  void onChanged({int? index, String? text}) {
    if (index! == 0) {
      startDate = text;
      notifyListeners();
      return;
    } else {
      endDate = text;
      notifyListeners();
      return;
    }
  }

  Future<void> picImage() async {
    final data = await _imagePicker.pickFile();
    if (data != null) {
      imageSelected = File(data.path);
      notifyListeners();
    }
  }

  // add task project

  Future<void> addProject({
    required String projectCode,
    required String adminStatus,
    required String projectName,
    required int? token,
    required int? userId,
  }) async {
    if (projectCode.isEmpty ||
        projectName.isEmpty ||
        imageSelected == null ||
        token == null ||
        userId == null ||
        startDate!.isEmpty ||
        endDate!.isEmpty) {
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Entry can\'t be empty');
    } else {
      setBusy(true);
      try {
        final response = await _apiService.addProject1(
          userId: userId,
          token: token,
          projectCode: projectCode,
          projectName: projectName,
          projectPhotoPath: imageSelected!,
          projectStartDate: startDate!,
          projectEndDate: endDate!,
        );
        if (response.statusCode == 200) {
          final data = response.data;
          if (data['res_code'] == "1") {
            setBusy(false);
            toAddProject2View(
              id: data['res_data']['id'],
              token: token,
              adminStatus: adminStatus,
              userId: userId,
            );
          } else {
            setBusy(false);
            _snackbarService.registerSnackbarConfig(SnackbarConfig(
              messageColor: whiteColor,
            ));
            _snackbarService.showSnackbar(message: 'Error occurred!');
          }
        } else {
          setBusy(false);
        }
      } on DioError catch (e) {
        setBusy(false);
        debugPrint(e.message);
        return;
      }
    }
  }

  void toAddProject2View({
    required int userId,
    required int token,
    required String adminStatus,
    required int id,
  }) {
    _navService.navigateTo(
      Routes.addProject2View,
      arguments: AddProject2ViewArguments(
        userId: userId,
        token: token,
        adminStatus: adminStatus,
        id: id,
      ),
    );
  }
}
