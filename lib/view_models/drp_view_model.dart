import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/models/dpr_list_model.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.router.dart';
import '../utils/color/color_pallets.dart';

class DprViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _navService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  List<DprListModel> datas = [];
  String errorMessage = '';
  Future<void> loadData({
    required int userId,
    required int token,
  }) async {
    setBusy(true);
    final data = await _apiService.fetchDprList(userId: userId, token: token);
    if (!data.isEmpty) {
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
}
