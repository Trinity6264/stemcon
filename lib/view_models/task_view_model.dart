import 'package:stemcon/models/add_task_model.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stemcon/utils/color/color_pallets.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';

class TaskViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final _apiService = locator<ApiService>();

  List<String> tasks = ['9'];

  List<AddTaskModel> datas = [];
  String errorMessage = '';
  Future<void> loadData({
    required int userId,
    required int token,
  }) async {
    setBusy(true);
    final data = await _apiService.fetchTask(userId: userId, token: token);
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

  void toAddNewTaskView({
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
        indes: 0,
        projectId: projectId,
      ),
    );
  }

  void editTask({
    required String userId,
    required String token,
    required String id,
    required String taskName,
    required String taskAssignedBy,
    required String description,
    required String taskStatus,
  }) {
    
  }
}
