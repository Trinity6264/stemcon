import 'dart:convert';
import 'dart:io';

class AddDprModel {
  int? token;
  int? userId;
  String? dprTime;
  File? dprPdf;
  String? dprDescription;
  String? projectId;
  AddDprModel({
    this.token,
    this.userId,
    this.dprTime,
    this.dprPdf,
    this.dprDescription,
    this.projectId,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'user_id': userId,
      'dpr_time': dprTime,
      'dpr_pdf': dprPdf,
      'dpr_description': dprDescription,
      'project_id': projectId,
    };
  }

  factory AddDprModel.fromMap(Map<String, dynamic> map) {
    return AddDprModel(
      token: map['token']?.toInt(),
      userId: map['userId']?.toInt(),
      dprTime: map['dprTime'],
      dprPdf: map['dprPdf'],
      dprDescription: map['dprDescription'],
      projectId: map['ProjectId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddDprModel.fromJson(String source) => AddDprModel.fromMap(json.decode(source));
}
