import 'dart:io';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/models/add_profile_model.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stemcon/utils/color/color_pallets.dart';

import '../app/app.locator.dart';
import '../services/file_selector_service.dart';
import '../services/shared_prefs_service.dart';

class AddProfileViewModel extends BaseViewModel {
  final _service = locator<ApiService>();
  final _snackService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  final _imagePicker = locator<FileSelectorService>();
  final _prefService = locator<SharedPrefsservice>();
  File? _imageSelected;
  File? get imageSelected => _imageSelected;
  int? userId;
  int? token;

  Future<void> picImage() async {
    final data = await _imagePicker.pickFile();
    if (data != null) {
      _imageSelected = File(data.path);
      notifyListeners();
    }
  }

  Future<void> reload() async {
    userId = await _prefService.loadUserId();
    token = await _prefService.loadUserAuthenticationToken();
    await _prefService.reloadData();
  }

  Future<void> addProfile({
    required String name,
    required String post,
    required String number,
  }) async {
    if (userId == null ||
        token == null ||
        name == '' ||
        number == '' && _imageSelected == null) {
      _snackService.registerSnackbarConfig(
        SnackbarConfig(
          messageColor: whiteColor,
        ),
      );
      _snackService.showSnackbar(
        message: 'All Entry must be field\nPlease Check!',
      );
    } else {
      setBusy(true);
      final addProfileModel = AddProfileModel(
        userId: userId.toString(),
        token: token.toString(),
        name: name,
        number: number,
        post: post,
        profileImage: _imageSelected,
      );
      final response = await _service.addProfileDetails(
        addProfile: addProfileModel,
      );
      if (response.statusCode == 200) {
        setBusy(false);
        _snackService.registerSnackbarConfig(
          SnackbarConfig(
            messageColor: whiteColor,
          ),
        );
        _snackService.showSnackbar(
          message: 'Profile Added!',
        );
      } else {
        setBusy(false);
        _dialogService.showDialog(
          title: 'Error Occured',
          buttonTitle: 'Ok',
        );
        return;
      }
    }
  }
}
