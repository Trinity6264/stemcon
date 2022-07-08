import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';

class ProjectDescriptionViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navService = locator<NavigationService>();

  void toDprTaskView(int index, String projectId) {
    index == 0
        ? _navService.navigateTo(Routes.taskView,
            arguments: TaskViewArguments(projectId: projectId))
        : _navService.navigateTo(Routes.dprView,
            arguments: DprViewArguments(projectId: projectId));
  }

  void toAddTaskDprView({
    required String? userId,
    required String? token,
    required int? indes,
    required String? projectId,
  }) {
    _navService.back();
    _navService.navigateTo(
      Routes.addCategoryView,
      arguments: AddCategoryViewArguments(
        userId: int.parse(userId!),
        token: int.parse(token!),
        indes: indes,
        projectId: int.parse(projectId!),
      ),
    );
  }
}
