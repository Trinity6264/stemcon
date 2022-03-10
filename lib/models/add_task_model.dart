class AddTaskModel {
  int? id;
  String? taskName;
  String? projectId;
  String? taskDoneBy;
  String? taskAssignedBy;
  String? description;
  String? taskStatus;
  String? isDeleted;
  String? createdAt;
  String? updatedAt;

  AddTaskModel({
    this.id,
    this.taskName,
    this.projectId,
    this.taskDoneBy,
    this.taskAssignedBy,
    this.description,
    this.taskStatus,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory AddTaskModel.fromJson(Map<String, dynamic> json) {
    return AddTaskModel(
      id: json['id'],
      taskName: json['task_name'],
      projectId: json['project_id'],
      taskDoneBy: json['task_done_by'],
      taskAssignedBy: json['task_assigned_by'],
      description: json['description'],
      taskStatus: json['task_status'],
      isDeleted: json['is_deleted'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task_name'] = taskName;
    data['project_id'] = projectId;
    data['task_done_by'] = taskDoneBy;
    data['task_assigned_by'] = taskAssignedBy;
    data['description'] = description;
    data['task_status'] = taskStatus;
    data['is_deleted'] = isDeleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
