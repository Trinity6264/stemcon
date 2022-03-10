class SuggestionListModel {
  int? id;
  String? suggestionTaskName;
  String? isDeleted;
  String? createdAt;
  String? updatedAt;

  SuggestionListModel({
    this.id,
    this.suggestionTaskName,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory SuggestionListModel.fromJson(Map<String, dynamic> json) {
    return SuggestionListModel(
      id: json['id'],
      suggestionTaskName: json['suggestion_task_name'],
      isDeleted: json['is_deleted'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
