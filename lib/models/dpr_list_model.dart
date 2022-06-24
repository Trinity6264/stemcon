class DprListModel {
  int? id;
  int? userId;
  String? dprTime;
  String? dprImage;
  String? dprTodayTask;
  String? dprTomorrowTask;
  String? projectId;
  String? isDeleted;
  String? createdAt;
  String? updatedAt;

  DprListModel({
    this.id,
    this.userId,
    this.dprTime,
    this.dprImage,
    this.dprTodayTask,
    this.dprTomorrowTask,
    this.projectId,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  DprListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    dprTime = json['dpr_time'];
    dprImage = json['dpr_image'];
    dprTodayTask = json['dpr_today_task'];
    dprTomorrowTask = json['dpr_tomorrow_task'];
    projectId = json['project_id'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['dpr_time'] = dprTime;
    data['dpr_image'] = dprImage;
    data['dpr_today_task'] = dprTodayTask;
    data['dpr_tomorrow_task'] = dprTomorrowTask;
    data['project_id'] = projectId;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
