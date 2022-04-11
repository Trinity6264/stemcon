// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../view_models/home_view_model.dart';
import '../views/authentication/company_code_view.dart';
import '../views/authentication/login_view.dart';
import '../views/authentication/startup_view.dart';
import '../views/category/add_category_view.dart';
import '../views/category/dpr/add_new_dpr_view.dart';
import '../views/category/dpr/dpr_view.dart';
import '../views/category/selected_cat_view.dart';
import '../views/category/tasks/add_new_task_view.dart';
import '../views/category/tasks/task_view.dart';
import '../views/category/wrapper/dpr_wrapper_view.dart';
import '../views/category/wrapper/task_wrapper_view.dart';
import '../views/home/home_view.dart';
import '../views/profile/profile_view.dart';
import '../views/projects/add_project1_view.dart';
import '../views/projects/add_project2_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String companyCodeView = '/company-code-view';
  static const String loginView = '/login-view';
  static const String homeView = '/home-view';
  static const String addProjectView = '/add-project-view';
  static const String addProject2View = '/add-project2-view';
  static const String dprWrapper = '/dpr-wrapper';
  static const String taskWrapperView = '/task-wrapper-view';
  static const String selectedCatViews = '/selected-cat-views';
  static const String profileView = '/profile-view';
  static const all = <String>{
    startUpView,
    companyCodeView,
    loginView,
    homeView,
    addProjectView,
    addProject2View,
    dprWrapper,
    taskWrapperView,
    selectedCatViews,
    profileView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.companyCodeView, page: CompanyCodeView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.addProjectView, page: AddProjectView),
    RouteDef(Routes.addProject2View, page: AddProject2View),
    RouteDef(
      Routes.dprWrapper,
      page: DprWrapper,
      generator: DprWrapperRouter(),
    ),
    RouteDef(
      Routes.taskWrapperView,
      page: TaskWrapperView,
      generator: TaskWrapperViewRouter(),
    ),
    RouteDef(Routes.selectedCatViews, page: selectedCatViews),
    RouteDef(Routes.profileView, page: ProfileView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartUpView(),
        settings: data,
      );
    },
    CompanyCodeView: (data) {
      var args = data.getArgs<CompanyCodeViewArguments>(
        orElse: () => CompanyCodeViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => CompanyCodeView(key: args.key),
        settings: data,
      );
    },
    LoginView: (data) {
      var args = data.getArgs<LoginViewArguments>(
        orElse: () => LoginViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginView(
          key: args.key,
          companyCode: args.companyCode,
        ),
        settings: data,
      );
    },
    HomeView: (data) {
      var args = data.getArgs<HomeViewArguments>(
        orElse: () => HomeViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(key: args.key),
        settings: data,
      );
    },
    AddProjectView: (data) {
      var args = data.getArgs<AddProjectViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddProjectView(
          key: args.key,
          userId: args.userId,
          token: args.token,
          adminStatus: args.adminStatus,
          projectname: args.projectname,
          projectPhotoPath: args.projectPhotoPath,
          projectStartTime: args.projectStartTime,
          projectEndTime: args.projectEndTime,
          id: args.id,
          state: args.state,
          projectAddress: args.projectAddress,
          projectAdmin: args.projectAdmin,
          projectCode: args.projectCode,
          projectKeyPoint: args.projectKeyPoint,
          projectManHour: args.projectManHour,
          projectPurpose: args.projectPurpose,
          projectStatus: args.projectStatus,
          projectUnit: args.projectUnit,
          projectTimezone: args.projectTimezone,
        ),
        settings: data,
      );
    },
    AddProject2View: (data) {
      var args = data.getArgs<AddProject2ViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddProject2View(
          key: args.key,
          userId: args.userId,
          token: args.token,
          id: args.id,
          adminStatus: args.adminStatus,
          state: args.state,
          projectAddress: args.projectAddress,
          projectAdmin: args.projectAdmin,
          projectCode: args.projectCode,
          projectKeyPoint: args.projectKeyPoint,
          projectManHour: args.projectManHour,
          projectPurpose: args.projectPurpose,
          projectStatus: args.projectStatus,
          projectUnit: args.projectUnit,
          projectTimeZone: args.projectTimeZone,
        ),
        settings: data,
      );
    },
    DprWrapper: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DprWrapper(),
        settings: data,
      );
    },
    TaskWrapperView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const TaskWrapperView(),
        settings: data,
      );
    },
    selectedCatViews: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const selectedCatViews(),
        settings: data,
      );
    },
    ProfileView: (data) {
      var args = data.getArgs<ProfileViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ProfileView(
          key: args.key,
          userId: args.userId,
          token: args.token,
          checkId: args.checkId,
          photoId: args.photoId,
        ),
        settings: data,
      );
    },
  };
}

class DprWrapperRoutes {
  static const String dprView = '/';
  static const String addCategoryView = '/add-category-view';
  static const String addNewDprView = '/add-new-dpr-view';
  static const all = <String>{
    dprView,
    addCategoryView,
    addNewDprView,
  };
}

class DprWrapperRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(DprWrapperRoutes.dprView, page: DprView),
    RouteDef(DprWrapperRoutes.addCategoryView, page: AddCategoryView),
    RouteDef(DprWrapperRoutes.addNewDprView, page: AddNewDprView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    DprView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DprView(),
        settings: data,
      );
    },
    AddCategoryView: (data) {
      var args = data.getArgs<AddCategoryViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddCategoryView(
          key: args.key,
          userId: args.userId,
          token: args.token,
          indes: args.indes,
          projectId: args.projectId,
        ),
        settings: data,
      );
    },
    AddNewDprView: (data) {
      var args = data.getArgs<AddNewDprViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddNewDprView(
          key: args.key,
          userId: args.userId,
          token: args.token,
          projectId: args.projectId,
          taskName: args.taskName,
        ),
        settings: data,
      );
    },
  };
}

class TaskWrapperViewRoutes {
  static const String taskView = '/';
  static const String addCategoryView = '/add-category-view';
  static const String addNewTaskView = '/add-new-task-view';
  static const all = <String>{
    taskView,
    addCategoryView,
    addNewTaskView,
  };
}

class TaskWrapperViewRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(TaskWrapperViewRoutes.taskView, page: TaskView),
    RouteDef(TaskWrapperViewRoutes.addCategoryView, page: AddCategoryView),
    RouteDef(TaskWrapperViewRoutes.addNewTaskView, page: AddNewTaskView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    TaskView: (data) {
      var args = data.getArgs<TaskViewArguments>(
        orElse: () => TaskViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => TaskView(key: args.key),
        settings: data,
      );
    },
    AddCategoryView: (data) {
      var args = data.getArgs<AddCategoryViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddCategoryView(
          key: args.key,
          userId: args.userId,
          token: args.token,
          indes: args.indes,
          projectId: args.projectId,
        ),
        settings: data,
      );
    },
    AddNewTaskView: (data) {
      var args = data.getArgs<AddNewTaskViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddNewTaskView(
          key: args.key,
          userId: args.userId,
          token: args.token,
          taskName: args.taskName,
          taskAssignedBy: args.taskAssignedBy,
          projectId: args.projectId,
          state: args.state,
          description: args.description,
          taskStatus: args.taskStatus,
          taskId: args.taskId,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// CompanyCodeView arguments holder class
class CompanyCodeViewArguments {
  final Key? key;
  CompanyCodeViewArguments({this.key});
}

/// LoginView arguments holder class
class LoginViewArguments {
  final Key? key;
  final String? companyCode;
  LoginViewArguments({this.key, this.companyCode});
}

/// HomeView arguments holder class
class HomeViewArguments {
  final Key? key;
  HomeViewArguments({this.key});
}

/// AddProjectView arguments holder class
class AddProjectViewArguments {
  final Key? key;
  final int userId;
  final int token;
  final String adminStatus;
  final String? projectname;
  final String? projectPhotoPath;
  final String? projectStartTime;
  final String? projectEndTime;
  final int? id;
  final CheckingState state;
  final String? projectAddress;
  final String? projectAdmin;
  final String? projectCode;
  final String? projectKeyPoint;
  final String? projectManHour;
  final String? projectPurpose;
  final String? projectStatus;
  final String? projectUnit;
  final String? projectTimezone;
  AddProjectViewArguments(
      {this.key,
      required this.userId,
      required this.token,
      required this.adminStatus,
      this.projectname,
      this.projectPhotoPath,
      this.projectStartTime,
      this.projectEndTime,
      this.id,
      required this.state,
      this.projectAddress,
      this.projectAdmin,
      this.projectCode,
      this.projectKeyPoint,
      this.projectManHour,
      this.projectPurpose,
      this.projectStatus,
      this.projectUnit,
      this.projectTimezone});
}

/// AddProject2View arguments holder class
class AddProject2ViewArguments {
  final Key? key;
  final int userId;
  final int token;
  final int id;
  final String? adminStatus;
  final CheckingState state;
  final String? projectAddress;
  final String? projectAdmin;
  final String? projectCode;
  final String? projectKeyPoint;
  final String? projectManHour;
  final String? projectPurpose;
  final String? projectStatus;
  final String? projectUnit;
  final String? projectTimeZone;
  AddProject2ViewArguments(
      {this.key,
      required this.userId,
      required this.token,
      required this.id,
      required this.adminStatus,
      required this.state,
      this.projectAddress,
      this.projectAdmin,
      this.projectCode,
      this.projectKeyPoint,
      this.projectManHour,
      this.projectPurpose,
      this.projectStatus,
      this.projectUnit,
      this.projectTimeZone});
}

/// ProfileView arguments holder class
class ProfileViewArguments {
  final Key? key;
  final int userId;
  final int token;
  final int checkId;
  final String photoId;
  ProfileViewArguments(
      {this.key,
      required this.userId,
      required this.token,
      required this.checkId,
      required this.photoId});
}

/// AddCategoryView arguments holder class
class AddCategoryViewArguments {
  final Key? key;
  final int? userId;
  final int? token;
  final int? indes;
  final String? projectId;
  AddCategoryViewArguments(
      {this.key,
      required this.userId,
      required this.token,
      required this.indes,
      this.projectId});
}

/// AddNewDprView arguments holder class
class AddNewDprViewArguments {
  final Key? key;
  final int userId;
  final int token;
  final String projectId;
  final String taskName;
  AddNewDprViewArguments(
      {this.key,
      required this.userId,
      required this.token,
      required this.projectId,
      required this.taskName});
}

/// TaskView arguments holder class
class TaskViewArguments {
  final Key? key;
  TaskViewArguments({this.key});
}

/// AddNewTaskView arguments holder class
class AddNewTaskViewArguments {
  final Key? key;
  final int userId;
  final int token;
  final String taskName;
  final String taskAssignedBy;
  final String projectId;
  final CheckingState state;
  final String? description;
  final String? taskStatus;
  final String? taskId;
  AddNewTaskViewArguments(
      {this.key,
      required this.userId,
      required this.token,
      required this.taskName,
      required this.taskAssignedBy,
      required this.projectId,
      required this.state,
      this.description,
      this.taskStatus,
      this.taskId});
}
