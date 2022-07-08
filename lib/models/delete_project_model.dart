import 'dart:convert';


class DeleteProjectModel {
  String? userId;
  String? token;
  String? projectId;
  DeleteProjectModel({
    required this.userId,
    required this.token,
    required this.projectId,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'token': token,
      'id': projectId,
    };
  }

  String toJson() => json.encode(toMap());
}
