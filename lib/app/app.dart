import 'package:stemcon/views/authentication/otp_view.dart';
import 'package:stemcon/views/category/add_category_view.dart';
import 'package:stemcon/views/category/dpr/dpr_view.dart';
import 'package:stemcon/views/category/selected_cat_view.dart';
import 'package:stemcon/views/category/tasks/add_new_task_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stemcon/services/api_service.dart';
import 'package:stemcon/services/shared_prefs_service.dart';
import 'package:stemcon/services/file_selector_service.dart';
import 'package:stemcon/views/projects/add_project1_view.dart';
import 'package:stemcon/views/authentication/company_code_view.dart';
import 'package:stemcon/views/home/home_view.dart';
import 'package:stemcon/views/authentication/login_view.dart';
import 'package:stemcon/views/projects/add_project2_view.dart';

import 'package:stemcon/views/authentication/startup_view.dart';

import '../views/category/dpr/add_new_dpr_view.dart';
import '../views/category/tasks/task_view.dart';

@StackedApp(routes: [
  MaterialRoute(page: StartUpView, initial: true),
  MaterialRoute(page: CompanyCodeView),
  MaterialRoute(page: LoginView),
  MaterialRoute(page: OtpView),
  MaterialRoute(page: HomeView),
  MaterialRoute(page: AddProjectView),
  MaterialRoute(page: TaskView),
  MaterialRoute(page: AddProject2View),
  MaterialRoute(page: AddCategoryView),
  MaterialRoute(page: AddNewTaskView),
  MaterialRoute(page: selectedCatViews),
  MaterialRoute(page: AddNewDprView),
  MaterialRoute(page: DprView),
], dependencies: [
// local services
  LazySingleton<NavigationService>(classType: NavigationService),
  LazySingleton<BottomSheetService>(classType: BottomSheetService),
  LazySingleton<SnackbarService>(classType: SnackbarService),
  LazySingleton<DialogService>(classType: DialogService),

  // custom services
  LazySingleton<ApiService>(classType: ApiService),
  LazySingleton<SharedPrefsservice>(classType: SharedPrefsservice),
  LazySingleton<FileSelectorService>(classType: FileSelectorService),
])
class App {}
