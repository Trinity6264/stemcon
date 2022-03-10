class DprListModel {
  int? id;
  String? dprTime;
  String? dprPdf;
  String? dprDescription;
  String? projectId;
  String? isDeleted;
  String? createdAt;
  String? updatedAt;

  DprListModel({
    this.id,
    this.dprTime,
    this.dprPdf,
    this.dprDescription,
    this.projectId,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory DprListModel.fromJson(Map<String, dynamic> json) {
    return DprListModel(
      id: json['id'],
      dprTime: json['dpr_time'],
      dprPdf: json['dpr_pdf'],
      dprDescription: json['dpr_description'],
      projectId: json['project_id'],
      isDeleted: json['is_deleted'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
