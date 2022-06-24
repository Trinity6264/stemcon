import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../models/dpr_list_model.dart';
import '../services/api_service.dart';
import '../services/file_selector_service.dart';
import '../services/shared_prefs_service.dart';
import '../utils/color/color_pallets.dart';

class AddNewDprViewModel extends BaseViewModel {
  final _navservice = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final _apiService = locator<ApiService>();
  final _navService = locator<NavigationService>();
  final _prefService = locator<SharedPrefsservice>();
  final _dialogService = locator<DialogService>();
  final _imagePicker = locator<FileSelectorService>();
  String? dateTime;
  File? imageSelected;

  void initDate() async {
    final data = DateTime.now();
    dateTime = '${data.year}-${data.month}-${data.day}';
  }

  Future<void> picImage() async {
    final data = await _imagePicker.pickFile();
    if (data != null) {
      imageSelected = File(data.path);
      notifyListeners();
    }
  }

  void onChanged({String? text}) {
    dateTime = text;
    notifyListeners();
    return;
  }

  void back() {
    _navservice.back(id: 2);
  }

  Future<void> backHome() async {
    _navservice.pushNamedAndRemoveUntil(Routes.homeView,
        predicate: (_) => false);
  }

  Future<void> addDpr({
    required String projectId,
    required String todayTask,
    required String tomorrowTask,
    required int? token,
    required int? userId,
  }) async {
    if (projectId == '' ||
        todayTask == '' ||
        tomorrowTask == '' ||
        imageSelected == null ||
        token == null ||
        userId == null ||
        dateTime == null) {
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Entry can\'t be empty');
    } else {
      setBusy(true);
      try {
        final response = await _apiService.addDpr(
          userId: userId,
          token: token,
          dprTime: dateTime!,
          dprImage: imageSelected!,
          todayTask: todayTask,
          tomorrowTask: tomorrowTask,
          projectId: projectId,
        );
        debugPrint(response.statusCode.toString());
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['res_code'] == "1") {
            _snackbarService.registerSnackbarConfig(SnackbarConfig(
              messageColor: whiteColor,
            ));
            _snackbarService.showSnackbar(message: 'Dpr added Succesfully');
            setBusy(false);
            await _navservice.pushNamedAndRemoveUntil(Routes.dprView,
                predicate: (_) => false,
                arguments: DprViewArguments(projectId: projectId));
            return;
          } else {
            setBusy(false);
            _snackbarService.registerSnackbarConfig(SnackbarConfig(
              messageColor: whiteColor,
            ));
            _snackbarService.showSnackbar(message: 'Error occurred!');
            return;
          }
        } else {
          setBusy(false);
          return;
        }
      } on Exception catch (e) {
        setBusy(false);
        debugPrint(e.toString());
        return;
      }
    }
  }

  // TOdo: Editting dpr pov
  int? id;
  int? tok;

  List<DprListModel> datas = [];
  String errorMessage = '';

  int? userId;
  int? token;

  Future<void> reload() async {
    userId = await _prefService.loadUserId();
    token = await _prefService.loadUserAuthenticationToken();
    await _prefService.reloadData();
  }

  Future<bool> editDprImage({
    required int? userId,
    required int? token,
    required int? id,
    required File dprPdf,
  }) async {
    try {
      final response = await _apiService.editDprImage(
        userId: userId!,
        token: token!,
        id: id.toString(),
        dprPdf: dprPdf,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['res_code'] == '1') {
          return true;
        } else {
          _dialogService.showDialog(
            title: 'Error Message',
            description: data['res_message'],
          );
          return false;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _dialogService.showDialog(
        title: 'Error Message',
        description: 'Connection Failed',
      );
      return false;
    }
    return false;
  }

  Future<bool> editTask({
    required String? projectId,
    required String? dprTime,
    required String? todayTask,
    required String? tomrrowTask,
    required int? userId,
    required int? token,
    File? dprPdf,
    required int? id,
  }) async {
    try {
      setBusy(true);
      final response = await _apiService.editDpr(
        userId: userId!,
        token: token!,
        id: id.toString(),
        todayTask: todayTask,
        tomorrowTask: tomrrowTask,
        dprTime: dprTime,
        projectId: projectId,
      );
      setBusy(false);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['res_code'] == '1') {
          return true;
        } else {
          _dialogService.showDialog(
            title: 'Error Message',
            description: data['res_message'],
          );
          return false;
        }
      }
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error Message',
        description: e.toString(),
      );
      return false;
    }
    return false;
  }

  // edit request

  Future<void> editRequest({
    required String? todayTask,
    required String? tomrrowTask,
    required String? projectId,
    required String? dprTime,
    required int? userId,
    required int? token,
    File? dprPdf,
    required int? id,
  }) async {
    if (dprPdf != null) {
      setBusy(true);
      try {
        final data = await editDprImage(
          userId: userId,
          token: token,
          id: id,
          dprPdf: dprPdf,
        );

        if (data) {
          final data2 = await editTask(
            projectId: projectId,
            todayTask: todayTask,
            tomrrowTask: tomrrowTask,
            dprTime: dprTime,
            userId: userId,
            token: token,
            id: id,
          );
          if (data2) {
            setBusy(false);
            _navService.back();
            _snackbarService.registerSnackbarConfig(SnackbarConfig(
              messageColor: whiteColor,
            ));
            _snackbarService.showSnackbar(message: 'Task Editted successfully');
            return;
          } else {
            setBusy(false);
            return;
          }
        } else {
          setBusy(false);
          return;
        }
      } catch (e) {
        _dialogService.showDialog(
          title: 'Error Message',
          description: e.toString(),
        );
        setBusy(false);
        return;
      }
    } else {
      await editTask(
        projectId: projectId,
        dprTime: dprTime,
        todayTask: todayTask,
        tomrrowTask: tomrrowTask,
        userId: userId,
        token: token,
        id: id,
      );
      _navService.back();
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Task Editted successfully');
    }
  }
}
