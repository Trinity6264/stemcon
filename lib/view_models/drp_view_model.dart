import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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

  Future<void> loadData(String projectId) async {
    setBusy(true);
    try {
      await reload();
      id = userId;
      tok = token;
      final data = await _apiService.fetchDprList(userId: id!, token: tok!);
      setBusy(false);
      if (data.isNotEmpty) {
        data.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        final taskData = data.reversed.toList();
        datas = taskData.where((dpr) => dpr.projectId == projectId).toList();
      } else {
        datas = [];
        errorMessage =
            'No Data Found\n Please check your internet connectivity';
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: 'Something went wrong!');
      }
    } on SocketException catch (e) {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Connection Failed',
        description: 'Check your internet connection',
      );
      return;
    } on PlatformException catch (e) {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Connection Failed',
        description: e.message,
      );
      return;
    } on Exception catch (e) {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Connection Failed',
        description: e.toString(),
      );
      return;
    }
  }

  // to cat

  void toEditDpr({
    required String projectId,
    required String? taskname,
    required String? dprImage,
    required String? todayTask,
    required String? tomorrowTask,
    required String? dprTime,
    required int id,
  }) {
    if (userId == null || token == null) return;
    _navService.navigateTo(
      Routes.addNewDprView,
      arguments: AddNewDprViewArguments(
        isEditting: true,
        projectId: projectId,
        taskName: '',
        token: token!,
        userId: userId!,
        dprImage: dprImage,
        dprtime: dprTime,
        id: id,
        todayTask: todayTask,
        tommorowTask: tomorrowTask,
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
}
