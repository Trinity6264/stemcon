import 'dart:convert';
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
import 'package:stemcon/view_models/home_view_model.dart';

class AddProjectViewModel extends BaseViewModel {
  final _imagePicker = locator<FileSelectorService>();
  final _snackbarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
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

  // Edit project

  Future<void> editProject(
    CheckingState state, {
    String? projectName,
    String? projectEndTime,
    int? id,
    String? projectStartTime,
    String? projectAddress,
    String? projectAdmin,
    String? projectCode,
    String? projectKeyPoint,
    String? projectManHour,
    String? projectPurpose,
    String? projectStatus,
    String? projectUnit,
    String? projectTimezone,
    File? image,
    required int? token,
    required int? userId,
  }) async {
    try {
      setBusy(true);
      final _data = await _apiService.editProject1(
        userId: userId!,
        token: token!,
        projectCode: projectCode!,
        projectName: projectName!,
        projectPhotoPath: image,
        projectStartDate: projectStartTime!,
        projectEndDate: projectEndTime!,
        id: id.toString(),
      );
      setBusy(false);
      print(_data.statusCode);
      if (_data.statusCode == 200) {
        final response = jsonDecode(_data.body);
        if (response['res_code'] == '1') {
          _snackbarService.registerSnackbarConfig(SnackbarConfig(
            messageColor: whiteColor,
          ));
          _snackbarService.showSnackbar(message: 'Project updated succesfully');
          toAddProject2View(
            id: id!,
            state: CheckingState.editting,
            token: token,
            userId: userId,
            adminStatus: projectAdmin,
            projectAddress: projectAddress,
            projectAdmin: projectAdmin,
            projectCode: projectCode,
            projectKeyPoint: projectKeyPoint,
            projectManHour: projectManHour,
            projectPurpose: projectPurpose,
            projectStatus: projectStatus,
            projectTimeZone: projectTimezone,
            projectUnit: projectUnit,
          );
          return;
        } else {
          _dialogService.showDialog(
              title: 'Error', description: response['res_message']);
        }
      } else {
        _dialogService.showDialog(
            title: 'Error', description: 'Please try again');
      }
    } on HttpException catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
    }
  }

  // add project
  Future<void> addProject(
      {required String projectCode,
      required String adminStatus,
      required String projectName,
      required int? token,
      required int? userId,
      required File? image}) async {
    if (projectCode.isEmpty ||
        projectName.isEmpty ||
        image == null ||
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
          projectPhotoPath: image,
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
              state: CheckingState.adding,
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
    required String? adminStatus,
    required int id,
    required CheckingState state,
    // op
    final String? projectAddress,
    final String? projectAdmin,
    final String? projectCode,
    final String? projectKeyPoint,
    final String? projectManHour,
    final String? projectPurpose,
    final String? projectStatus,
    final String? projectUnit,
    final String? projectTimeZone,
  }) {
    if (state.index == 1) {
      _navService.navigateTo(
        Routes.addProject2View,
        arguments: AddProject2ViewArguments(
          userId: userId,
          token: token,
          adminStatus: adminStatus,
          id: id,
          state: state,
        ),
      );
    } else {
      _navService.navigateTo(
        Routes.addProject2View,
        arguments: AddProject2ViewArguments(
          userId: userId,
          token: token,
          adminStatus: adminStatus,
          id: id,
          state: state,
          projectAddress: projectAddress,
          projectAdmin: projectAdmin,
          projectCode: projectCode,
          projectKeyPoint: projectKeyPoint,
          projectManHour: projectManHour,
          projectPurpose: projectPurpose,
          projectStatus: projectStatus,
          projectTimeZone: projectTimeZone,
          projectUnit: projectUnit,
        ),
      );
    }
  }
}
