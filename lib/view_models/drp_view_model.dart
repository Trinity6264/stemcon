import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/models/dpr_list_model.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/services/file_selector_service.dart';

import '../app/app.router.dart';

import '../services/shared_prefs_service.dart';
import '../utils/color/color_pallets.dart';

class DprViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _prefService = locator<SharedPrefsservice>();
  final _navService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _snackbarService = locator<SnackbarService>();
  final _imagePicker = locator<FileSelectorService>();

  List<DprListModel> datas = [];
  String errorMessage = '';
  String? dateTime;
  int? id;
  int? tok;
  void onChanged({String? text}) {
    dateTime = text;
    notifyListeners();
    return;
  }

  Future<void> back() async {
    _navService.popRepeated(1);
  }

  bool? isEdittingTask;

  File? imageSelected;

  Future<void> picImage() async {
    final data = await _imagePicker.pickFile();
    if (data != null) {
      imageSelected = File(data.path);
      notifyListeners();
    }
  }

  int? userId;
  int? token;

  Future<void> reload() async {
    userId = await _prefService.loadUserId();
    token = await _prefService.loadUserAuthenticationToken();
    await _prefService.reloadData();
  }

  Future<void> loadData() async {
    setBusy(true);
    await reload();
    id = userId;
    tok = token;
    final data = await _apiService.fetchDprList(userId: id!, token: tok!);
    setBusy(false);
    if (data.isNotEmpty) {
      data.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      datas = data.reversed.toList();
    } else {
      datas = [];
      errorMessage = 'No Data Found\n Please check your internet connectivity';
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Something went wrong!');
    }
  }

  // to cat

  void toCategoryView(String projectId) {
    if (userId == null || token == null) return;
    _navService.navigateTo(
      Routes.addCategoryView,
      arguments: AddCategoryViewArguments(
        userId: userId,
        token: token,
        indes: 1,
        projectId: int.parse(projectId),
      ),
    );
  }

  Future<void> deleteDpr({
    required int token,
    required int userId,
    required int index,
    required int id,
  }) async {
    try {
      final _res = await _dialogService.showConfirmationDialog(
        title: '!',
        description: 'Do you want to delete?',
        confirmationTitle: 'Yes',
        cancelTitle: 'No',
      );
      if (_res!.confirmed) {
        datas.removeAt(index);
        notifyListeners();
        final res = await _apiService.deleteDpr(
          userId: userId,
          token: token,
          id: id,
        );
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          if (data['res_code'] == '1') {
            _snackbarService.registerSnackbarConfig(SnackbarConfig(
              messageColor: whiteColor,
            ));
            _snackbarService.showSnackbar(message: 'Dpr deleted successfully');
          } else {
            _dialogService.showDialog(
                title: 'Error Message', description: data['res_message']);
          }
        } else {
          _dialogService.showDialog(
            title: 'Error Message',
            description: 'Connection failed Please try again',
          );
        }
      } else {
        notifyListeners();
        return;
      }
    } on HttpException catch (e) {
      _dialogService.showDialog(
        title: 'Error Message',
        description: e.message,
      );
    }
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
    required String? description,
    required String? projectId,
    required String? dprTime,
    required int? userId,
    required int? token,
    File? dprPdf,
    required int? id,
  }) async {
    try {
      final response = await _apiService.editDpr(
        userId: userId!,
        token: token!,
        id: id.toString(),
        dprDescription: description,
        dprTime: dprTime,
        projectId: projectId,
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
      _dialogService.showDialog(
        title: 'Error Message',
        description: 'Connection Failed',
      );
      return false;
    }
    return false;
  }

  // edit request

  Future<void> editRequest({
    required String? description,
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
            description: description,
            projectId: projectId,
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
            loadData();
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
        description: description,
        projectId: projectId,
        dprTime: dprTime,
        userId: userId,
        token: token,
        id: id,
      );
      return;
    }
  }
}
