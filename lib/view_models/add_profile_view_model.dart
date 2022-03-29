import 'dart:convert';
import 'dart:io';


import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stemcon/utils/color/color_pallets.dart';

import '../app/app.locator.dart';
import '../services/file_selector_service.dart';
import '../services/shared_prefs_service.dart';

class AddProfileViewModel extends BaseViewModel {
  final _service = locator<ApiService>();
  final _snackService = locator<SnackbarService>();
  final _dialogService = locator<DialogService>();
  final _navService = locator<NavigationService>();
  final _imagePicker = locator<FileSelectorService>();
  final _prefService = locator<SharedPrefsservice>();
  File? _imageSelected;
  File? get imageSelected => _imageSelected;
  String? profileImageUrl;
  String? profileName;
  String? profilePost;
  String? profileNumber;

  Future<void> picImage() async {
    final data = await _imagePicker.pickFile();
    if (data != null) {
      _imageSelected = File(data.path);
      notifyListeners();
    }
  }

  Future<void> downloadUserInfo({
    required String id,
    required int userId,
    required int token,
  }) async {
    setBusy(true);
    final reponse = await _service.selectProfileDetails(
      userId: userId,
      token: token,
      id: id,
    );
    setBusy(false);
    if (reponse.statusCode == 200) {
      final data = jsonDecode(reponse.body);
      profileName = data['res_data']['name'];
      profileImageUrl = data['res_data']['image_url'];
      profileNumber = data['res_data']['number'];
      profilePost = data['res_data']['post'];
      notifyListeners();
    } else {
      throw 'data not found';
    }
  }

  Future<void> addProfile({
    required String name,
    required String post,
    required String number,
    required int? userId,
    required int? token,
  }) async {
    if (userId == null ||
        token == null ||
        name == '' ||
        post == '' ||
        number == '' ||
        _imageSelected == null) {
      _snackService.registerSnackbarConfig(
        SnackbarConfig(
          messageColor: whiteColor,
        ),
      );
      _snackService.showSnackbar(
        message: 'All Entry must be field\nPlease Check!',
      );
    } else {
      try {
        setBusy(true);
        final response = await _service.addProfileDetails(
          name: name,
          number: number,
          post: post,
          profileImage: _imageSelected!,
          token: token,
          userId: userId,
        );
        final data = jsonDecode(response.body);
        print(data);
        if (response.statusCode == 200) {
          setBusy(false);
          final data = jsonDecode(response.body);

          if (data['res_code'] == '1') {
            print(data['res_code']);
            _prefService.savedUserPhotoId(data['res_data']['id']);
            _snackService.registerSnackbarConfig(
              SnackbarConfig(
                messageColor: whiteColor,
              ),
            );
            _snackService.showSnackbar(
              message: 'Profile Added!',
            );
            _navService.back();
          }
        } else {
          setBusy(false);
          final data = jsonDecode(response.body);
          _dialogService.showDialog(
            title: 'Error Occured',
            buttonTitle: 'Ok',
            description: data,
          );
          return;
        }
      } on SocketException catch (e) {
        setBusy(false);
        print(e.message);
      }
    }
  }
}
