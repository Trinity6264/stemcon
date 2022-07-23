import 'dart:convert';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';
import 'package:stemcon/models/delete_project_model.dart';
import 'package:stemcon/models/new_user.dart';
import 'package:stemcon/models/project_list_model.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stemcon/services/shared_prefs_service.dart';
import 'package:stemcon/utils/color/color_pallets.dart';

enum CheckingState { editting, adding }

class HomeViewModel extends BaseViewModel {
  final _prefService = locator<SharedPrefsservice>();
  final _apiService = locator<ApiService>();
  final _navService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _snackbarService = locator<SnackbarService>();

  bool isSearch = false;
  bool isloginOut = false;
  bool isDeleting = false;

  void changedToSerach() {
    isSearch = !isSearch;
    notifyListeners();
  }

  List<ProjectListModel> datas = [];
  String errorMessage = '';
  Future<void> loadData({
    required int? userId,
    required String? token,
  }) async {
    setBusy(true);
    try {
      if (userId == null || token == null) {
        await _dialogService.showCustomDialog(
            title: 'Timeout',
            description: 'user details not found login again');
        return;
      }
      final data = await _apiService.fetchProject(
        userId: userId,
        token: token,
      );
      if (data.isNotEmpty) {
        setBusy(false);
        data.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
        datas = data.reversed.toList();
      } else {
        setBusy(false);
        errorMessage =
            'No Data Found\n Please check your internet connectivity';
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: 'Something went wrong!');
      }
    } on Exception catch (e) {
      errorMessage = 'No Data Found\n Please check your internet connectivity';
      setBusy(false);
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
  int? photoId;
  Future<void> reload() async {
    userId = await _prefService.loadUserId();
    companyCode = await _prefService.loadUserCompanyCode();
    countryCode = await _prefService.loadUserCountryCode();
    userOtpCode = await _prefService.loadUserOtp();
    adminStatus = await _prefService.loadUserIsAdmin();
    status = await _prefService.loadUserStatus();
    createdAt = await _prefService.loadUserCreatedAt();
    updatedAt = await _prefService.loadUserUpdatedAt();
    photoId = await _prefService.loadUserPhotoId();
    authenticationToken = await _prefService.loadUserAuthenticationToken();
    await _prefService.reloadData();
  }

  void toAddProjectView(
    CheckingState state, {
    String? projectName,
    String? projectStart,
    String? projectEnd,
    int? id,
    String? projectPhotoPath,
    String? projectStartTime,
    String? projectEndTime,
    String? projectAddress,
    String? projectAdmin,
    String? projectCode,
    String? projectKeyPoint,
    String? projectManHour,
    String? projectPurpose,
    String? projectStatus,
    String? projectUnit,
    String? projectTimeZone,
  }) {
    switch (state) {
      case CheckingState.adding:
        if (userId == null ||
            authenticationToken == null ||
            adminStatus == null) return;
        _navService.navigateTo(
          Routes.addProjectView,
          arguments: AddProjectViewArguments(
            userId: userId!,
            token: authenticationToken!,
            adminStatus: adminStatus!,
            state: state,
          ),
        );
        break;
      case CheckingState.editting:
        if (userId == null ||
            authenticationToken == null ||
            adminStatus == null) return;
        _navService.navigateTo(
          Routes.addProjectView,
          arguments: AddProjectViewArguments(
            userId: userId!,
            token: authenticationToken!,
            adminStatus: adminStatus!,
            state: state,
            id: id,
            projectEndTime: projectEnd,
            projectPhotoPath: projectPhotoPath,
            projectStartTime: projectStart,
            projectname: projectName,
            projectAddress: projectAddress,
            projectAdmin: projectAdmin,
            projectCode: projectCode,
            projectKeyPoint: projectKeyPoint,
            projectManHour: projectManHour,
            projectPurpose: projectPurpose,
            projectStatus: projectStatus,
            projectUnit: projectUnit,
            projectTimezone: projectTimeZone,
          ),
        );
        break;
      default:
    }
  }

  void toProjectDescription(ProjectListModel model) {
    if (userId == null || authenticationToken == null) return;
    _navService.navigateTo(
      Routes.projectDescriptionView,
      arguments: ProjectDescriptionViewArguments(
        projectModel: model,
        userId: userId.toString(),
        token: authenticationToken.toString(),
      ),
    );
  }

// search
  Future searchDatas({
    required int userId,
    required String token,
    required String value,
  }) async {
    setBusy(true);
    final response = await _apiService.searchProject(
      userId: userId,
      token: token,
      search: value,
    );
    if (response.statusCode == 200) {
      final dat = jsonDecode(response.body);
      if (dat['res_code'] == '1') {
        final List<dynamic> data = dat['res_data'];
        final dartobject =
            data.map((e) => ProjectListModel.fromJson(e)).toList();
        if (dartobject.isNotEmpty) {
          setBusy(false);
          dartobject.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          datas = dartobject.reversed.toList();
          return;
        } else {
          setBusy(false);
          datas = [];
          errorMessage = 'No Data Project found';
          notifyListeners();
          return;
        }
      } else {
        setBusy(false);
        datas = [];
        errorMessage = 'No Data Project found';
        notifyListeners();
        return;
      }
    } else {
      setBusy(false);
      datas = [];
      errorMessage = 'No Data Project found';
      notifyListeners();
      return;
    }
  }

  void toProfileView() {
    if (userId == null || authenticationToken == null) {
      return;
    } else if (photoId == null &&
        userId != null &&
        authenticationToken != null) {
      _navService.replaceWith(
        Routes.profileView,
        arguments: ProfileViewArguments(
          token: authenticationToken!,
          userId: userId!,
          photoId: '',
          checkId: 0,
        ),
      );
      return;
    } else {
      _navService.navigateTo(
        Routes.profileView,
        arguments: ProfileViewArguments(
          token: authenticationToken!,
          userId: userId!,
          photoId: photoId.toString(),
          checkId: 1,
        ),
      );
      return;
    }
  }

  void askLogoutPermission() async {
    final res = await _dialogService.showConfirmationDialog(
      title: 'Do you want to logout?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );
    if (res!.confirmed) {
      logOut();
      return;
    }
  }

  // delete project

  Future<void> deleteProject({
    required String projectId,
  }) async {
    final deleteContent = DeleteProjectModel(
      token: authenticationToken.toString(),
      userId: userId.toString(),
      projectId: projectId,
    );
    isDeleting = true;
    notifyListeners();
    final data = await _apiService.deleteProject(deleteContent: deleteContent);
    final response = jsonDecode(data.body);
    if (data.statusCode == 200) {
      if (response['res_code'] == '1') {
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: response['res_message']);
        isDeleting = false;
        loadData(token: authenticationToken.toString(), userId: userId!);
        notifyListeners();
        return;
      } else {
        isDeleting = false;
        notifyListeners();
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: response['res_message']);
        return;
      }
    } else {
      isDeleting = false;
      notifyListeners();
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: response['res_message']);
      return;
    }
  }

// logout

  void askDeletetPermission(String projectId) async {
    final res = await _dialogService.showConfirmationDialog(
      title: 'Do you want to delete this project?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );
    if (res!.confirmed) {
      deleteProject(projectId: projectId);
      return;
    }
  }

  Future<void> logOut() async {
    isloginOut = true;
    notifyListeners();
    final logOut = LogoutModel(
      token: authenticationToken.toString(),
      userId: userId.toString(),
    );
    final data = await _apiService.signOut(logoutModel: logOut);
    final response = jsonDecode(data.body);
    if (data.statusCode == 200) {
      if (response['res_code'] == '1') {
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: response['res_message']);
        _prefService.clearData();
        isloginOut = false;
        notifyListeners();
        _navService.replaceWith(Routes.companyCodeView);
        return;
      } else {
        isloginOut = false;
        notifyListeners();
        _snackbarService.registerSnackbarConfig(SnackbarConfig(
          messageColor: whiteColor,
        ));
        _snackbarService.showSnackbar(message: response['res_message']);
        return;
      }
    } else {
      isloginOut = false;
      notifyListeners();
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: response['res_message']);
      return;
    }
  }
}
