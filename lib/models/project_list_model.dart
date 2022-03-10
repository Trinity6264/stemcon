class ProjectListModel {
  int? id;
  String? projectName;
  String? projectCode;
  String? projectAddress;
  String? projectManHour;
  String? projectPurpose;
  String? projectTimezone;
  String? projectUnit;
  String? projectKeyPoint;
  String? projectPhotoPath;
  String? projectAdmin;
  String? projectStatus;
  String? projectStartDate;
  String? projectEndDate;
  String? isDeleted;
  String? createdAt;
  String? updatedAt;

  ProjectListModel({
    this.id,
    this.projectName,
    this.projectCode,
    this.projectAddress,
    this.projectManHour,
    this.projectPurpose,
    this.projectTimezone,
    this.projectUnit,
    this.projectKeyPoint,
    this.projectPhotoPath,
    this.projectAdmin,
    this.projectStatus,
    this.projectStartDate,
    this.projectEndDate,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory ProjectListModel.fromJson(Map<String, dynamic> json) {
    return ProjectListModel(
      id: json['id'],
      projectName: json['project_name'],
      projectCode: json['project_code'],
      projectAddress: json['project_address'],
      projectManHour: json['project_man_hour'],
      projectPurpose: json['project_purpose'],
      projectTimezone: json['project_timezone'],
      projectUnit: json['project_unit'],
      projectKeyPoint: json['project_key_point'],
      projectPhotoPath: json['project_photo_path'],
      projectAdmin: json['project_admin'],
      projectStatus: json['project_status'],
      projectStartDate: json['project_start_date'],
      projectEndDate: json['project_end_date'],
      isDeleted: json['is_deleted'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_name'] = projectName;
    data['project_code'] = projectCode;
    data['project_address'] = projectAddress;
    data['project_man_hour'] = projectManHour;
    data['project_purpose'] = projectPurpose;
    data['project_timezone'] = projectTimezone;
    data['project_unit'] = projectUnit;
    data['project_key_point'] = projectKeyPoint;
    data['project_photo_path'] = projectPhotoPath;
    data['project_admin'] = projectAdmin;
    data['project_status'] = projectStatus;
    data['project_start_date'] = projectStartDate;
    data['project_end_date'] = projectEndDate;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
