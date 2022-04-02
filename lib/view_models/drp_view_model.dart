import 'dart:convert';
import 'dart:io';

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
  final _navService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _snackbarService = locator<SnackbarService>();
  final _imagePicker = locator<FileSelectorService>();
  final _prefService = locator<SharedPrefsservice>();

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

  bool? isEdittingTask;

  File? imageSelected;

  Future<void> picImage() async {
    final data = await _imagePicker.pickFile();
    if (data != null) {
      imageSelected = File(data.path);
      notifyListeners();
    }
  }

  Future<void> loadData({
    required int userId,
    required int token,
  }) async {
    id = userId;
    tok = token;
    setBusy(true);
    final data = await _apiService.fetchDprList(userId: userId, token: token);
    if (data.isNotEmpty) {
      setBusy(false);
      datas = data;
    } else {
      setBusy(false);
      datas = [];
      errorMessage = 'No Data Found\n Please check your internet connectivity';
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Something went wrong!');
    }
  }

  // to cat

  void toCategoryView({
    required int? userId,
    required int? token,
    required String? projectId,
  }) {
    if (userId == null || token == null) return;
    _navService.navigateTo(
      Routes.addCategoryView,
      arguments: AddCategoryViewArguments(
        userId: userId,
        token: token,
        indes: 1,
        projectId: projectId,
      ),
    );
  }

  Future<void> deleteDpr({
    required int token,
    required int userId,
    required int index,
    required String id,
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

  Future<void> editTask({
    required String? description,
    required String? projectId,
    required String? dprTime,
    required int? userId,
    required int? token,
    File? dprPdf,
    required int? id,
  }) async {
    try {
      printInfo(info: 'Data Sent');
      isEdittingTask = true;
      notifyListeners();
      final response = await _apiService.editDpr(
        userId: userId!,
        token: token!,
        id: id.toString(),
        dprDescription: description,
        dprPdf: dprPdf!,
        dprTime: dprTime,
        projectId: projectId,
      );
      
      isEdittingTask = false;
      notifyListeners();
      if (response.statusCode == 200) {
        print('done');
        final data = jsonDecode(response.body);
        if (data['res_code'] == '1') {
          _navService.back();
          _snackbarService.registerSnackbarConfig(SnackbarConfig(
            messageColor: whiteColor,
          ));
          _snackbarService.showSnackbar(message: 'Task Editted successfully');
          loadData(userId: userId, token: token);
        } else {
          _dialogService.showDialog(
            title: 'Error Message',
            description: data['res_message'],
          );
        }
      }
    } catch (e) {
      print(e);
      isEdittingTask = false;
      notifyListeners();
      _dialogService.showDialog(
        title: 'Error Message',
        description: 'Connection Failed',
      );
    }
  }
}
