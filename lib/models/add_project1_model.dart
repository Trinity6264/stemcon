import 'dart:convert';

import 'dart:io';

class AddProjectModel {
  int? userId;
  int? token;
  String? projectName;
  String? projectCode;
  File? projectPhotoPath;
  String? projectStartDate;
  String? projectEndDate;

  AddProjectModel({
    this.userId,
    this.token,
    this.projectName,
    this.projectCode,
    this.projectPhotoPath,
    this.projectStartDate,
    this.projectEndDate,
  });


  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'token': token,
      'project_name': projectName,
      'project_code': projectCode,
      'project_photo_path': projectPhotoPath!.readAsBytesSync(),
      'project_start_date': projectStartDate,
      'project_end_date': projectEndDate,
    };
  }

  factory AddProjectModel.fromMap(Map<String, dynamic> map) {
    return AddProjectModel(
      userId: map['userId']?.toInt(),
      token: map['token']?.toInt(),
      projectName: map['projectName'],
      projectCode: map['projectCode'],
      projectPhotoPath: map['projectPhotoPath'],
      projectStartDate: map['projectStartDate'],
      projectEndDate: map['projectEndDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddProjectModel.fromJson(String source) => AddProjectModel.fromMap(json.decode(source));
}
