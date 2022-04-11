import 'dart:convert';
import 'dart:io';

import 'package:stemcon/models/add_task_model.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stemcon/services/shared_prefs_service.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';

class TaskViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  final _apiService = locator<ApiService>();
  final _prefService = locator<SharedPrefsservice>();

  int? userId;
  int? token;
  String? projectId;

  Future<void> reload() async {
    userId = await _prefService.loadUserId();
    token = await _prefService.loadUserAuthenticationToken();
    projectId = await _prefService.loadProjectId();
    await _prefService.reloadData();
  }

  List<String> tasks = ['9'];

  List<AddTaskModel> datas = [];
  String errorMessage = '';
  Future<void> loadData() async {
    setBusy(true);
    await reload();
    final data = await _apiService.fetchTask(userId: userId!, token: token!);
    if (data.isNotEmpty) {
      setBusy(false);
      data.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      datas = data.reversed.toList();
    } else {
      setBusy(false);
      errorMessage = 'No Data Found\n Please check your internet connectivity';
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Something went wrong!');
    }
  }

  // delete task
  Future<void> deleteTask({
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
        final res = await _apiService.deleteTask(
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
            _snackbarService.showSnackbar(message: 'Task deleted successfully');
          } else {
            _dialogService.showDialog(
              title: 'Error Message',
              description: data['res_message'],
            );
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

  void toAddNewTaskView({
    required int? userId,
    required int? token,
  }) {
    if (userId == null || token == null) return;
    _navService.navigateTo(
      TaskWrapperViewRoutes.addCategoryView,
      id: 1,
      arguments: AddCategoryViewArguments(
        userId: userId,
        token: token,
        indes: 0,
        projectId: projectId,
      ),
    );
  }

  bool? isEdittingTask;

  Future<void> editTask({
    required String? taskName,
    required String? description,
    required String? projectId,
    required String? taskAssignedBy,
    required String token,
    required String userId,
    required int? id,
  }) async {
    try {
      isEdittingTask = true;
      final response = await _apiService.editNewTask(
        userId: userId,
        token: token,
        id: id.toString(),
        taskName: taskName,
        projectId: projectId,
        description: description,
        taskAssignedBy: taskAssignedBy,
      );
      isEdittingTask = false;
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['res_code'] == '1') {
          _navService.back();
          _snackbarService.registerSnackbarConfig(SnackbarConfig(
            messageColor: whiteColor,
          ));
          _snackbarService.showSnackbar(message: 'Task Editted successfully');
          reload();
          loadData();
        } else {
          _dialogService.showDialog(
            title: 'Error Message',
            description: data['res_message'],
          );
        }
      }
      notifyListeners();
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error Message',
        description: 'Connection Failed',
      );
    }
  }
}
