import 'dart:convert';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:stemcon/models/add_project2_model.dart';
import 'package:stemcon/models/add_task_model.dart';
import 'package:stemcon/models/dpr_list_model.dart';
import 'package:stemcon/models/new_user.dart';
import 'package:stemcon/models/suggestion_list_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:stemcon/models/project_list_model.dart';

import '../models/delete_project_model.dart';

class ApiService {
  // create an account
  Future<http.Response> createAccount({required NewUser userModel}) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/login';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: userModel.toJson(),
    );
    return response;
  }

  // add profile details
  Future<http.Response> addProfileDetails({
    required int userId,
    required int token,
    required String name,
    required String number,
    required String post,
    required File profileImage,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/profile/add';

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      Uri.parse(serverUrl),
    );
    final mimeTypeData =
        lookupMimeType(profileImage.path, headerBytes: [0xFF, 0xD8])!
            .split('/');
    final file = await http.MultipartFile.fromPath(
        'profile_image', profileImage.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['user_id'] = userId.toString();
    imageUploadRequest.fields['token'] = token.toString();
    imageUploadRequest.fields['name'] = name;
    imageUploadRequest.fields['post'] = post;
    imageUploadRequest.fields['number'] = number;
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  Future<http.Response> editAllProfileDetails({
    required int userId,
    required int token,
    required String name,
    required String number,
    required String post,
    required int id,
    required File profileImage,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/profile/edit';
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      Uri.parse(serverUrl),
    );
    final mimeTypeData =
        lookupMimeType(profileImage.path, headerBytes: [0xFF, 0xD8])!
            .split('/');
    final file = await http.MultipartFile.fromPath(
        'profile_image', profileImage.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['user_id'] = userId.toString();
    imageUploadRequest.fields['token'] = token.toString();
    imageUploadRequest.fields['id'] = id.toString();
    imageUploadRequest.fields['name'] = name;
    imageUploadRequest.fields['post'] = post;
    imageUploadRequest.fields['number'] = number;
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  // edit profile deatails
  Future<http.Response> editProfileDetails({
    required int userId,
    required int token,
    required int id,
    required String name,
    required String number,
    required String post,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/profile/edit';
    final editBody = {
      'user_id': userId,
      'token': token,
      'id': id,
      'name': name,
      'number': number,
      'post': post,
    };
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(editBody),
    );
    return response;
  }

  // delete profile details
  Future<http.Response> deleteProfileDetails({
    required String userId,
    required String token,
    required String id,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/profile/delete';
    final _data = {'user_id': userId, 'token': token, 'id': id};
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(_data),
    );
    return response;
  }

  // select user profile

  Future<http.Response> selectProfileDetails({
    required int userId,
    required int token,
    required String id,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/profile/select';
    final _data = {'user_id': userId, 'token': token, 'id': id};
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(_data),
    );
    return response;
  }

  // logout
  Future<http.Response> signOut({required LogoutModel logoutModel}) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/logout';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: logoutModel.toJson(),
    );
    return response;
  }

  // confirm otp
  Future<http.Response> cornfirmOtp({required ConfirmOtp cornfirmOtp}) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/matchOTP';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: cornfirmOtp.toJson(),
    );
    return response;
  }

  // add members to project

  Future<http.Response> addMember({
    required String projectId,
    required String memberName,
    required String memberMobileNumber,
    required String token,
    required String userId,
  }) async {
    const String serverUrl =
        'http://stemcon.likeview.in/api/project/addProjectStep3';
    final content = {
      'project_id': projectId,
      'member_name': memberName,
      'member_mobile_number': memberMobileNumber,
      'token': token,
      'user_id': userId,
    };
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(content),
    );
    return response;
  }

  // Add project 1
  Future<Response> addProject1({
    required int userId,
    required int token,
    required String projectName,
    required String projectCode,
    required File projectPhotoPath,
    required String projectStartDate,
    required String projectEndDate,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/project/addStep1';
    String fileName = projectPhotoPath.path.split('/').last;
    Dio _dio = Dio();
    FormData _data = FormData.fromMap({
      'user_id': userId,
      'token': token,
      'project_name': projectName,
      'project_code': projectCode,
      'project_photo': await MultipartFile.fromFile(
        projectPhotoPath.path,
        filename: fileName,
      ),
      'project_start_date': projectStartDate,
      'project_end_date': projectEndDate,
    });
    final response = await _dio.post(serverUrl, data: _data,
        onSendProgress: (sent, receive) {
      final results = sent * receive / 100;
      debugPrint('$results');
    });
    return response;
  }

  // Add project 2
  Future<http.Response> addProject2({
    required AddProject2Model postContent,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/project/addStep2';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: postContent.toJson(),
    );
    return response;
  }

  // todo:: edit project
  // Edit project 1
  Future<http.Response> editProject1({
    required int userId,
    required int token,
    required String id,
    required String? projectName,
    required String? projectCode,
    required File? projectPhotoPath,
    required String? projectStartDate,
    required String? projectEndDate,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/project/editStep1';
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      Uri.parse(serverUrl),
    );
    final mimeTypeData =
        lookupMimeType(projectPhotoPath?.path ?? '', headerBytes: [0xFF, 0xD8])!
            .split('/');
    final file = await http.MultipartFile.fromPath(
      'project_photo',
      projectPhotoPath!.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    );
    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['user_id'] = userId.toString();
    imageUploadRequest.fields['token'] = token.toString();
    imageUploadRequest.fields['id'] = id;
    imageUploadRequest.fields['project_name'] = projectName ?? '';
    imageUploadRequest.fields['project_code'] = projectCode ?? '';
    imageUploadRequest.fields['project_start_date'] = projectStartDate ?? '';
    imageUploadRequest.fields['project_end_date'] = projectEndDate ?? '';
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  Future<http.Response> editProject1Only({
    required int userId,
    required int token,
    required String id,
    required String? projectName,
    required String? projectCode,
    required String? projectStartDate,
    required String? projectEndDate,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/project/editStep1';
    final body = {
      'user_id': userId,
      'token': token,
      'id': id,
      'project_name': projectName,
      'project_code': projectCode,
      'project_start_date': projectStartDate,
      'project_end_date': projectEndDate,
    };
    final res = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'Application/json'},
      body: jsonEncode(body),
    );
    return res;
  }

  // Edit project 2
  Future<http.Response> editProject2({
    required AddProject2Model postContent,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/project/editStep2';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: postContent.toJson(),
    );
    return response;
  }

  // delete project
  Future<http.Response> deleteProject({
    required DeleteProjectModel deleteContent,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/project/delete';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: deleteContent.toJson(),
    );
    return response;
  }

  // Fetch Projects
  Future<List<ProjectListModel>> fetchProject({
    required int userId,
    required String token,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/project/list';
    final data = {"user_id": userId, "token": token};
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final datas = jsonDecode(response.body);
      if (datas['res_code'] == '1') {
        final List<dynamic> data = datas['res_data'];
        return data.map((e) {
          return ProjectListModel.fromJson(e);
        }).toList();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  // fetch all task view data
  Future<List<AddTaskModel>> fetchTask({
    required int userId,
    required int token,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/task/list';
    final data = {"user_id": userId, "token": token};
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final datas = jsonDecode(response.body);
      if (datas['res_code'] == '1') {
        final List<dynamic> data = datas['res_data'];
        return data.map((e) {
          return AddTaskModel.fromJson(e);
        }).toList();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

// TODO: Suggestion Apis
//Get all suggestion

  Future<List<SuggestionListModel>> fetchSuggestion({
    required int userId,
    required int token,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/suggestion/list';
    final data = {"user_id": userId, "token": token};
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final datas = jsonDecode(response.body);
      if (datas['res_code'] == '1') {
        final List<dynamic> data = datas['res_data'];
        return data.map((e) {
          return SuggestionListModel.fromJson(e);
        }).toList();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  // delete suggestions
  Future<http.Response> deleteSuggestion({
    required int userId,
    required int token,
    required int dataId,
  }) async {
    final _data = {'user_id': userId, 'token': token, 'id': dataId};
    const String serverUrl = 'http://stemcon.likeview.in/api/suggestion/delete';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(_data),
    );
    return response;
  }

  // todo: add new task
  Future<http.Response> addNewTask({
    required int userId,
    required int token,
    required String taskName,
    required String description,
    required String projectId,
    required String taskAssignedBy,
  }) async {
    final _data = {
      'user_id': userId,
      'token': token,
      'description': description,
      'task_name': taskName,
      'task_assigned_by': taskAssignedBy,
      'task_status': 'active',
      'project_id': projectId,
    };
    const String serverUrl = 'http://stemcon.likeview.in/api/task/add';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(_data),
    );
    return response;
  }

  // edit task
  Future<http.Response> editNewTask({
    required String userId,
    required String token,
    required String id,
    required String? taskName,
    required String? projectId,
    required String? description,
    required String? taskAssignedBy,
  }) async {
    final _data = {
      'user_id': userId,
      'token': token,
      'id': id,
      'project_id': projectId,
      'description': description,
      'task_name': taskName,
      'task_assigned_by': taskAssignedBy,
      'task_status': 'active',
    };
    const String serverUrl = 'http://stemcon.likeview.in/api/task/edit';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(_data),
    );
    return response;
  }

  // edit task
  Future<http.Response> deleteTask({
    required int userId,
    required int token,
    required int id,
  }) async {
    final _data = {
      'user_id': userId,
      'token': token,
      'id': id,
    };
    const String serverUrl = 'http://stemcon.likeview.in/api/task/delete';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(_data),
    );
    return response;
  }

  // todo: dpr pov
  //  Fecth data
  Future<List<DprListModel>> fetchDprList({
    required int userId,
    required int token,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/dpr/list';
    final data = {"user_id": userId, "token": token};
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final datas = jsonDecode(response.body);
      if (datas['res_code'] == '1') {
        final List<dynamic> data = datas['res_data'];
        return data.map((e) {
          return DprListModel.fromJson(e);
        }).toList();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  // add dpr
  Future<http.Response> addDpr({
    required int userId,
    required int token,
    required String dprTime,
    required File dprImage,
    required String tomorrowTask,
    required String todayTask,
    required String projectId,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/dpr/add';
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      Uri.parse(serverUrl),
    );
    final mimeTypeData =
        lookupMimeType(dprImage.path, headerBytes: [0xFF, 0xD8])!.split('/');
    final file = await http.MultipartFile.fromPath('dpr_image', dprImage.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));

    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['user_id'] = userId.toString();
    imageUploadRequest.fields['token'] = token.toString();
    imageUploadRequest.fields['dpr_time'] = dprTime;
    imageUploadRequest.fields['dpr_tomorrow_task'] = tomorrowTask;
    imageUploadRequest.fields['dpr_today_task'] = todayTask;
    imageUploadRequest.fields['project_id'] = projectId;
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  //  edit dpr
  // ! Image only

  Future<http.Response> editDprImage({
    required int userId,
    required int token,
    required String id,
    required File dprPdf,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/dpr/edit';
    final imageUploadRequest = http.MultipartRequest(
      'POST',
      Uri.parse(serverUrl),
    );
    final mimeTypeData =
        lookupMimeType(dprPdf.path, headerBytes: [0xFF, 0xD8])!.split('/');
    final file = await http.MultipartFile.fromPath(
      'dpr_image',
      dprPdf.path,
      contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
    );
    imageUploadRequest.files.add(file);
    imageUploadRequest.fields['user_id'] = userId.toString();
    imageUploadRequest.fields['token'] = token.toString();
    imageUploadRequest.fields['id'] = id;
    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  Future<http.Response> editDpr({
    required int userId,
    required int token,
    required String id,
    required String? dprTime,
    required String? tomorrowTask,
    required String? todayTask,
    required String? projectId,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/dpr/edit';
    final _body = {
      'user_id': userId.toString(),
      'token': token.toString(),
      'dpr_time': dprTime.toString(),
      'id': id,
      'dpr_tomorrow_task': tomorrowTask,
      'dpr_today_task': todayTask,
      'project_id': projectId,
    };

    final res = await http.post(
      Uri.parse(serverUrl),
      body: _body,
      // headers: {'Content-Type': 'application/json'},
    );
    return res;
  }

  // delete suggestions
  Future<http.Response> deleteDpr({
    required int userId,
    required int token,
    required int id,
  }) async {
    final _data = {'user_id': userId, 'token': token, 'id': id};
    const String serverUrl = 'http://stemcon.likeview.in/api/dpr/delete';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(_data),
    );
    return response;
  }

  // TODO search

  Future<http.Response> searchProject({
    required int userId,
    required String token,
    required String search,
  }) async {
    const String serverUrl = 'http://stemcon.likeview.in/api/project/search';
    final data = {"user_id": userId, "token": token, 'search': search};
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return response;
  }
}
