import 'dart:convert';

import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/api_service.dart';
import '../utils/color/color_pallets.dart';

class AddTaskViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();

  void back() {
    _navService.back();
  }

  Future<void> backHome() async {
    _navService.back();
  }

  Future<void> addTask({
    required String taskName,
    required String description,
    required String projectId,
    required int? token,
    required int? userId,
  }) async {
    if (taskName.isEmpty ||
        description.isEmpty ||
        token == null ||
        projectId.isEmpty ||
        userId == null) {
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Entry can\'t be empty');
    } else {
      setBusy(true);
      try {
        final response = await _apiService.addNewTask(
          userId: userId,
          token: token,
          taskName: taskName,
          description: description,
          taskAssignedBy: userId.toString(),
          projectId: projectId,
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          if (data['res_code'] == "1") {
            setBusy(false);
            _snackbarService.registerSnackbarConfig(SnackbarConfig(
              messageColor: whiteColor,
            ));
            _snackbarService.showSnackbar(message: 'Task Added');
            _navService.replaceWith(Routes.taskView);
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
      } on Exception catch (e) {
        setBusy(false);
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: e.toString());
        return;
      }
    }
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
      setBusy(true);
      final response = await _apiService.editNewTask(
        userId: userId,
        token: token,
        id: id.toString(),
        taskName: taskName,
        projectId: projectId,
        description: description,
        taskAssignedBy: taskAssignedBy,
      );
      setBusy(false);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['res_code'] == '1') {
          _navService.back();
          _snackbarService.registerSnackbarConfig(SnackbarConfig(
            messageColor: whiteColor,
          ));
          _snackbarService.showSnackbar(message: 'Task Editted successfully');
          _navService.replaceWith(
            Routes.taskView,
            arguments: TaskViewArguments(projectId: projectId!),
          );
          return;
        } else {
          _dialogService.showDialog(
            title: 'Error Message',
            description: data['res_message'],
          );
          return;
        }
      }
    } catch (e) {
      printInfo(info: e.toString());
      _dialogService.showDialog(
        title: 'Error Message',
        description: 'Connection Failed',
      );
      return;
    }
  }
}
