import 'dart:convert';
import 'dart:io';

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

  void initDate({required bool isEditting,required String start,required String end,}) {
    final data = DateTime.now();
    
    startDate =isEditting ? start:'${data.year}-${data.month}-${data.day}';
    endDate =isEditting ? end: '${data.year}-${data.month}-${data.day}';
  }

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

  //todo Edit project
  Future<bool> editProject(
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
    required int token,
    required int userId,
  }) async {
    try {
      setBusy(true);
      final _data = await _apiService.editProject1(
        userId: userId,
        token: token,
        projectCode: projectCode,
        projectName: projectName,
        projectPhotoPath: image,
        projectStartDate: projectStartTime,
        projectEndDate: projectEndTime,
        id: id.toString(),
      );
      setBusy(false);

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
            adminStatus: projectAdmin ?? '',
            projectAddress: projectAddress ?? '',
            projectAdmin: projectAdmin ?? '',
            projectCode: projectCode ?? '',
            projectKeyPoint: projectKeyPoint ?? '',
            projectManHour: projectManHour ?? '',
            projectPurpose: projectPurpose ?? '',
            projectStatus: projectStatus ?? '',
            projectTimeZone: projectTimezone ?? '',
            projectUnit: projectUnit ?? '',
          );
          return true;
        } else {
          _dialogService.showDialog(
            title: 'Error',
            description: response['res_message'],
          );
          return false;
        }
      } else {
        _dialogService.showDialog(
          title: 'Error',
          description: 'Please try again',
        );
        return false;
      }
    } on SocketException catch (e) {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Connection failed',
        description: 'Check your internet connection',
      );
      return false;
    } on HttpException catch (e) {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
      return false;
    }
  }

  Future<bool> editProjectOnly(
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
    required int token,
    required int userId,
  }) async {
    try {
      setBusy(true);
      final _data = await _apiService.editProject1Only(
        userId: userId,
        token: token,
        projectCode: projectCode,
        projectName: projectName,
        projectStartDate: projectStartTime,
        projectEndDate: projectEndTime,
        id: id.toString(),
      );
      setBusy(false);

      if (_data.statusCode == 200) {
        final response = jsonDecode(_data.body);
        if (response['res_code'] == '1') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on HttpException catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: e.message,
      );
      return false;
    }
  }

  Future<void> requestProjectEdit(
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
    required int token,
    required int userId,
  }) async {
    setBusy(true);
    if (image != null) {
      final data = await editProject(
        state,
        token: token,
        userId: userId,
        id: id,
        projectAddress: projectAddress,
        projectAdmin: projectAdmin,
        projectCode: projectCode,
        projectEndTime: projectEndTime,
        projectKeyPoint: projectKeyPoint,
        projectManHour: projectManHour,
        projectName: projectName,
        projectPurpose: projectPurpose,
        projectStartTime: projectStartTime,
        projectStatus: projectStatus,
        projectTimezone: projectTimezone,
        projectUnit: projectUnit,
        image: image,
      );
      if (data) {
        final data2 = await editProjectOnly(
          state,
          token: token,
          userId: userId,
          id: id,
          projectAddress: projectAddress,
          projectAdmin: projectAdmin,
          projectCode: projectCode,
          projectEndTime: projectEndTime,
          projectKeyPoint: projectKeyPoint,
          projectManHour: projectManHour,
          projectName: projectName,
          projectPurpose: projectPurpose,
          projectStartTime: projectStartTime,
          projectStatus: projectStatus,
          projectTimezone: projectTimezone,
          projectUnit: projectUnit,
        );
        setBusy(false);
        if (data2) {
          _snackbarService.registerSnackbarConfig(SnackbarConfig(
            messageColor: whiteColor,
          ));
          _snackbarService.showSnackbar(message: 'Project updated succesfully');
          toAddProject2View(
            id: id!,
            state: CheckingState.editting,
            token: token,
            userId: userId,
            adminStatus: projectAdmin ?? '',
            projectAddress: projectAddress ?? '',
            projectAdmin: projectAdmin ?? '',
            projectCode: projectCode ?? '',
            projectKeyPoint: projectKeyPoint ?? '',
            projectManHour: projectManHour ?? '',
            projectPurpose: projectPurpose ?? '',
            projectStatus: projectStatus ?? '',
            projectTimeZone: projectTimezone ?? '',
            projectUnit: projectUnit ?? '',
          );
          return;
        } else {
          _dialogService.showDialog(
            title: 'Error',
            description: 'Please try again',
          );
          return;
        }
      }
    } else {
      final data2 = await editProjectOnly(
        state,
        token: token,
        userId: userId,
        id: id,
        projectAddress: projectAddress,
        projectAdmin: projectAdmin,
        projectCode: projectCode,
        projectEndTime: projectEndTime,
        projectKeyPoint: projectKeyPoint,
        projectManHour: projectManHour,
        projectName: projectName,
        projectPurpose: projectPurpose,
        projectStartTime: projectStartTime,
        projectStatus: projectStatus,
        projectTimezone: projectTimezone,
        projectUnit: projectUnit,
      );
      setBusy(false);
      if (data2) {
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: 'Project updated succesfully');
        toAddProject2View(
          id: id!,
          state: CheckingState.editting,
          token: token,
          userId: userId,
          adminStatus: projectAdmin ?? '',
          projectAddress: projectAddress ?? '',
          projectAdmin: projectAdmin ?? '',
          projectCode: projectCode ?? '',
          projectKeyPoint: projectKeyPoint ?? '',
          projectManHour: projectManHour ?? '',
          projectPurpose: projectPurpose ?? '',
          projectStatus: projectStatus ?? '',
          projectTimeZone: projectTimezone ?? '',
          projectUnit: projectUnit ?? '',
        );
        return;
      } else {
        _dialogService.showDialog(
          title: 'Error',
          description: 'Please try again',
        );
        return;
      }
    }
  }

  void toAddProject2View({
    required int? userId,
    required int? token,
    required String? adminStatus,
    final int? id,
    required CheckingState state,
    final String? projectName,
    final File? projectPicture,
    final String? projectStartDate,
    final String? projectEndDate,
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
      if (projectCode!.isEmpty ||
          projectName!.isEmpty ||
          imageSelected == null ||
          token == null ||
          userId == null ||
          startDate!.isEmpty ||
          endDate!.isEmpty) {
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: 'Entry can\'t be empty');
        return;
      }
      _navService.navigateTo(
        Routes.addProject2View,
        arguments: AddProject2ViewArguments(
          userId: userId,
          token: token,
          adminStatus: adminStatus,
          state: state,
          projectCode: projectCode,
          projectPicture: projectPicture,
          projectName: projectName,
          projectStartDate: projectStartDate,
          projectEndDate: projectEndDate,
        ),
      );
    } else {
      _navService.navigateTo(
        Routes.addProject2View,
        arguments: AddProject2ViewArguments(
          userId: userId!,
          token: token!,
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
