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

  void back() {
    _navService.back(id: 1);
  }

  void backPop() {
    _navService.popRepeated(0);
  }

  Future<void> backHome() async {
    _navService.pushNamedAndRemoveUntil(Routes.homeView,
        predicate: (_) => false);
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
            _navService.replaceWith(TaskWrapperViewRoutes.taskView, id: 1);
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
}
