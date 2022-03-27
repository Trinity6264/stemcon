import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class AddProfileModel {
  String? userId;
  String? token;
  String? name;
  String? number;
  String? post;
  File? profileImage;
  AddProfileModel({
    required this.userId,
    required this.token,
    required this.name,
    required this.number,
    required this.post,
    required this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'token': token,
      'name': name,
      'number': number,
      'post': post,
      'profile_image': MultipartFile.fromFile(
        profileImage!.path,
        filename: profileImage!.path.split('/').last,
      ),
    };
  }

  String toJson() => json.encode(toMap());
}
