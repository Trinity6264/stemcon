import 'dart:convert';

class AddProject2Model {
  int? userId;
  int? token;
  int? id;
  String? projectAddress;
  String? projectManHour;
  String? projectPurpose;
  String? projectTimezone;
  String? projectUnit;
  String? projectKeyPoint;
  String? projectAdmin;  
  String? projectStatus;
  AddProject2Model({
    this.userId,
    this.token,
    this.id,
    this.projectAddress,
    this.projectManHour,
    this.projectPurpose,
    this.projectTimezone,
    this.projectUnit,
    this.projectKeyPoint,
    this.projectAdmin,
    this.projectStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'token': token,
      'id': id,
      'project_address': projectAddress,
      'project_man_hour': projectManHour,
      'project_purpose': projectPurpose,
      'project_timezone': projectTimezone,
      'project_unit': projectUnit,
      'project_key_point': projectKeyPoint,
      'project_admin': projectAdmin,
      'project_status': projectStatus,
    };
  }

  factory AddProject2Model.fromMap(Map<String, dynamic> map) {
    return AddProject2Model(
      userId: map['userId']?.toInt(),
      token: map['token']?.toInt(),
      id: map['id']?.toInt(),
      projectAddress: map['projectAddress'],
      projectManHour: map['projectManHour'],
      projectPurpose: map['projectPurpose'],
      projectTimezone: map['projectTimezone'],
      projectUnit: map['projectUnit'],
      projectKeyPoint: map['projectKeyPoint'],
      projectAdmin: map['projectAdmin'],
      projectStatus: map['projectStatus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddProject2Model.fromJson(String source) => AddProject2Model.fromMap(json.decode(source));
}
