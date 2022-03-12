import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';
import 'package:stemcon/models/project_list_model.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stemcon/services/shared_prefs_service.dart';
import 'package:stemcon/utils/color/color_pallets.dart';

class HomeViewModel extends BaseViewModel {
  final _prefService = locator<SharedPrefsservice>();
  final _apiService = locator<ApiService>();
  final _navService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();

  bool isSearch = false;

  void changedToSerach() {
    isSearch = !isSearch;
    notifyListeners();
  }

  List<ProjectListModel> datas = [];
  String errorMessage = '';
  Future<void> loadData({
    required int userId,
    required String token,
  }) async {
    setBusy(true);
    final data = await _apiService.fetchProject(userId: userId, token: token);
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

  int index = -1;

  void openContainer(int i) {
    if (index == i) {
      index = -1;
    } else {
      index = i;
    }
    notifyListeners();
  }

  int? userId;
  String? companyCode = '';
  String? countryCode = '';
  String? userOtpCode = '';
  String? adminStatus = '';
  String? status = '';
  int? authenticationToken;
  String? createdAt = '';
  String? updatedAt = '';
  Future<void> reload() async {
    userId = await _prefService.loadUserId();
    companyCode = await _prefService.loadUserCompanyCode();
    countryCode = await _prefService.loadUserCountryCode();
    userOtpCode = await _prefService.loadUserOtp();
    adminStatus = await _prefService.loadUserIsAdmin();
    status = await _prefService.loadUserStatus();
    createdAt = await _prefService.loadUserCreatedAt();
    updatedAt = await _prefService.loadUserUpdatedAt();
    authenticationToken = await _prefService.loadUserAuthenticationToken();
    await _prefService.reloadData();
  }

  void toAddProjectView() {
    if (userId == null || authenticationToken == null || adminStatus == null)return;
    _navService.navigateTo(
      Routes.addProjectView,
      arguments: AddProjectViewArguments(
        userId: userId!,
        token: authenticationToken!,
        adminStatus: adminStatus!,
      ),
    );
  }

  void toAddTaskView(String projectId) {
    if (userId == null || authenticationToken == null) return;
    _navService.navigateTo(
      Routes.selectedCatViews,
      arguments: selectedCatViewsArguments(
        userId: userId!,
        token: authenticationToken!,
        projectId: projectId,
      ),
    );
  }

// search
  Future<void> searchDatas({
    required int userId,
    required String token,
    required String value,
  }) async {
    setBusy(true);
    final data = await _apiService.searchProject(
      userId: userId,
      token: token,
      search: value,
    );
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
}
