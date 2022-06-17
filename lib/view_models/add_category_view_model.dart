import 'dart:convert';

import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';
import 'package:stemcon/models/suggestion_list_model.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/view_models/home_view_model.dart';

class AddCategoryViewModel extends IndexTrackingViewModel {
  final _navService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  final _dialogService = locator<DialogService>();
  final _snackbarService = locator<SnackbarService>();

// Fetching data method
  List<SuggestionListModel> datas = [];
  String errorMessage = '';
  Future<void> loadData({
    required int userId,
    required int token,
  }) async {
    setBusy(true);
    final data =
        await _apiService.fetchSuggestion(userId: userId, token: token);
    if (data.isNotEmpty) {
      setBusy(false);
      datas = data;
    } else {
      setBusy(false);
      errorMessage = 'No Data Found\n Please check your internet connectivity';
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Something went wrong!');
    }
  }

  // Deleting data from database
  void deleteData({
    required int userId,
    required int token,
    required int id,
    required String message,
  }) async {
    final data = await _dialogService.showConfirmationDialog(
      title: 'Do you want to delete it?',
      description: '$message\n Note: you can undo after deleting it.',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );
    if (data!.confirmed == true) {
      setBusy(true);
      final response = await _apiService.deleteSuggestion(
        userId: userId,
        token: token,
        dataId: id,
      );

      final data = jsonDecode(response.body);
      if (data['res_code'] == "1") {
        loadData(userId: userId, token: token);
      } else {
        setBusy(false);
        _snackbarService.registerSnackbarConfig(
          SnackbarConfig(
            messageColor: whiteColor,
          ),
        );
        _snackbarService.showSnackbar(message: 'Data was not deleted');
      }
    }
  }

  // to add task
  void toAddTaskView({
    required int userId,
    required int token,
    required String taskName,
    required String projectId,
    required int index,
  }) {
    if (taskName == '') {
      _snackbarService.registerSnackbarConfig(
        SnackbarConfig(messageColor: whiteColor),
      );
      _snackbarService.showSnackbar(message: 'Empty field');
      return;
    }

    index == 0
        ? _navService.navigateTo(
            Routes.addNewTaskView,
            arguments: AddNewTaskViewArguments(
              userId: userId,
              token: token,
              taskName: taskName,
              taskAssignedBy: userId.toString(),
              projectId: projectId,
              isEdtting: false
            ),
          )
        : _navService.navigateTo(
            Routes.addNewDprView,
            arguments: AddNewDprViewArguments(
              userId: userId,
              token: token,
              taskName: taskName,
              projectId: projectId,
              isEditting: true,
            ),
          );
  }

  void back() {
    _navService.back();
  }
}
