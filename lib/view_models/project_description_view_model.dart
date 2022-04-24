import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';

class ProjectDescriptionViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _navService = locator<NavigationService>();

  void toDprTaskView(int index) {
    _navService.navigateTo(index == 0 ? Routes.taskView : Routes.dprView);
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
        projectId: projectId,
      ),
    );
  }
}
