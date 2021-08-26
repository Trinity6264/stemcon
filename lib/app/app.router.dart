// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../views/authentication/company_code_view.dart';
import '../views/authentication/login_view.dart';
import '../views/authentication/startup_view.dart';
import '../views/category/add_category_view.dart';
import '../views/category/dpr/add_new_dpr_view.dart';
import '../views/category/dpr/dpr_view.dart';
import '../views/category/selected_cat_view.dart';
import '../views/category/tasks/add_new_task_view.dart';
import '../views/category/tasks/task_view.dart';
import '../views/home/home_view.dart';
import '../views/projects/add_project1_view.dart';
import '../views/projects/add_project2_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String companyCodeView = '/company-code-view';
  static const String loginView = '/login-view';
  static const String homeView = '/home-view';
  static const String addProjectView = '/add-project-view';
  static const String taskView = '/task-view';
  static const String addProject2View = '/add-project2-view';
  static const String addCategoryView = '/add-category-view';
  static const String addNewTaskView = '/add-new-task-view';
  static const String selectedCatViews = '/selected-cat-views';
  static const String addNewDprView = '/add-new-dpr-view';
  static const String dprView = '/dpr-view';
  static const all = <String>{
    startUpView,
    companyCodeView,
    loginView,
    homeView,
    addProjectView,
    taskView,
    addProject2View,
    addCategoryView,
    addNewTaskView,
    selectedCatViews,
    addNewDprView,
    dprView,
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
    RouteDef(Routes.taskView, page: TaskView),
    RouteDef(Routes.addProject2View, page: AddProject2View),
    RouteDef(Routes.addCategoryView, page: AddCategoryView),
    RouteDef(Routes.addNewTaskView, page: AddNewTaskView),
    RouteDef(Routes.selectedCatViews, page: selectedCatViews),
    RouteDef(Routes.addNewDprView, page: AddNewDprView),
    RouteDef(Routes.dprView, page: DprView),
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
        ),
        settings: data,
      );
    },
    TaskView: (data) {
      var args = data.getArgs<TaskViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => TaskView(
          key: args.key,
          id: args.id,
          token: args.token,
          projectId: args.projectId,
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
          adminStatus: args.adminStatus,
          id: args.id,
        ),
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
        ),
        settings: data,
      );
    },
    selectedCatViews: (data) {
      var args = data.getArgs<selectedCatViewsArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => selectedCatViews(
          key: args.key,
          userId: args.userId,
          token: args.token,
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
    DprView: (data) {
      var args = data.getArgs<DprViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DprView(
          key: args.key,
          token: args.token,
          userId: args.userId,
          projectId: args.projectId,
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
  final int? companyCode;
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
  AddProjectViewArguments(
      {this.key,
      required this.userId,
      required this.token,
      required this.adminStatus});
}

/// TaskView arguments holder class
class TaskViewArguments {
  final Key? key;
  final int id;
  final int token;
  final String projectId;
  TaskViewArguments(
      {this.key,
      required this.id,
      required this.token,
      required this.projectId});
}

/// AddProject2View arguments holder class
class AddProject2ViewArguments {
  final Key? key;
  final int userId;
  final int token;
  final String adminStatus;
  final int id;
  AddProject2ViewArguments(
      {this.key,
      required this.userId,
      required this.token,
      required this.adminStatus,
      required this.id});
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

/// AddNewTaskView arguments holder class
class AddNewTaskViewArguments {
  final Key? key;
  final int userId;
  final int token;
  final String taskName;
  final String taskAssignedBy;
  final String projectId;
  AddNewTaskViewArguments(
      {this.key,
      required this.userId,
      required this.token,
      required this.taskName,
      required this.taskAssignedBy,
      required this.projectId});
}

/// selectedCatViews arguments holder class
class selectedCatViewsArguments {
  final Key? key;
  final int? userId;
  final int? token;
  final String? projectId;
  selectedCatViewsArguments(
      {this.key,
      required this.userId,
      required this.token,
      required this.projectId});
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

/// DprView arguments holder class
class DprViewArguments {
  final Key? key;
  final int token;
  final int userId;
  final String projectId;
  DprViewArguments(
      {this.key,
      required this.token,
      required this.userId,
      required this.projectId});
}
