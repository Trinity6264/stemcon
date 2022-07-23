import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
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

  Future<void> reload() async {
    userId = await _prefService.loadUserId();
    token = await _prefService.loadUserAuthenticationToken();

    await _prefService.reloadData();
  }

  Future<void> back() async {
    _navService.popRepeated(1);
  }

  List<String> tasks = ['9'];

  List<AddTaskModel> datas = [];
  String errorMessage = '';
  Future<void> loadData(String projectId) async {
    setBusy(true);
    try {
      await reload();
      final data = await _apiService.fetchTask(userId: userId!, token: token!);
      if (data.isNotEmpty) {
        setBusy(false);
        print(data);
        data.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        final taskData = data.reversed.toList();
        datas = taskData.where((task) => task.projectId == projectId).toList();
      } else {
        setBusy(false);
        errorMessage =
            'No Data Found\n Please check your internet connectivity';
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: 'No Data Found!');
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

  // delete task
  Future<void> deleteTask({
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
        return;
      }
    } on HttpException catch (e) {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Error Message',
        description: e.message,
      );
      return;
    } on SocketException catch (e) {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Failed Connection',
        description: 'Check your internet connnection',
      );
      return;
    } on Exception catch (e) {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Failed',
        description: e.toString(),
      );
      return;
    }
  }

  void toEdit({
    required String taskName,
    required String taskAssignedBy,
    required String description,
    required String taskStatus,
    required String projectId,
    required int taskId,
  }) {
    _navService.navigateTo(
      Routes.addNewTaskView,
      arguments: AddNewTaskViewArguments(
        userId: userId!,
        isEdtting: true,
        taskAssignedBy: taskAssignedBy,
        description: description,
        token: token!,
        projectId: projectId,
        taskId: taskId,
        taskStatus: taskStatus,
        taskName: taskName,
      ),
    );
  }

  void toAddNewTaskView({
    required int? userId,
    required int? token,
    required String projectId,
  }) {
    if (userId == null || token == null) return;
    _navService.navigateTo(
      Routes.addCategoryView,
      id: 1,
      arguments: AddCategoryViewArguments(
        userId: userId,
        token: token,
        indes: 0,
        projectId: int.parse(projectId),
      ),
    );
  }
}
