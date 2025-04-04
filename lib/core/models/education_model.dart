class EducationModel {
  int? id;
  int? userId;
  String? title;
  String? imagePath;
  String? shortDescription;
  String? description;
  String? videoUrl;
  String? createdAt;
  String? updatedAt;
  User? user;

  EducationModel({
    this.id,
    this.userId,
    this.title,
    this.imagePath,
    this.shortDescription,
    this.description,
    this.videoUrl,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  EducationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    imagePath = json['image_path'];
    shortDescription = json['short_description'];
    description = json['description'];
    videoUrl = json['video_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['image_path'] = imagePath;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['video_url'] = videoUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;

  User({this.id, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
