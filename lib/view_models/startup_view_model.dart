import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/app/app.locator.dart';
import 'package:stemcon/app/app.router.dart';
import 'package:stemcon/services/shared_prefs_service.dart';
import 'package:stemcon/utils/color/color_pallets.dart';

class StartUpViewModel extends BaseViewModel {
  final _navService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final _prefsService = locator<SharedPrefsservice>();

  

  void toCompanyView() async {
    final data = await _prefsService.loadUserState() ?? 0;
    Future.delayed(const Duration(seconds: 3), () {
      if (data == 3) {
        _navService.replaceWith(Routes.homeView);
      } else {
        _navService.replaceWith(Routes.companyCodeView);
      }
    });
  }

  Future<void> toLoginView(String code, String text) async {
    if (text.isEmpty) {
      _snackbarService.registerSnackbarConfig(SnackbarConfig(
        messageColor: whiteColor,
      ));
      _snackbarService.showSnackbar(message: 'Entry can\'t be empty');
    } else {
      _navService.navigateTo(
        Routes.loginView,
        arguments: LoginViewArguments(companyCode: code),
      );
    }
  }
}
