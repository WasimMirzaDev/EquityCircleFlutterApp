class CreateEducationModel {
  int? userId;
  String? title;
  String? imagePath;
  String? shortDescription;
  String? description;
  String? videoUrl;
  String? updatedAt;
  String? createdAt;
  int? id;
  User? user;

  CreateEducationModel({
    this.userId,
    this.title,
    this.imagePath,
    this.shortDescription,
    this.description,
    this.videoUrl,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.user,
  });

  CreateEducationModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    title = json['title'];
    imagePath = json['image_path'];
    shortDescription = json['short_description'];
    description = json['description'];
    videoUrl = json['video_url'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['title'] = title;
    data['image_path'] = imagePath;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['video_url'] = videoUrl;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? roles;
  String? profileImage;
  String? backgroundImage;
  String? emailVerifiedAt;
  String? googleId;
  int? permissionId;
  String? createdAt;
  String? updatedAt;
  String? firstName;
  String? lastName;
  String? username;
  String? city;
  String? gender;
  String? dateOfBirth;
  String? maritalStatus;
  String? ageGroup;
  String? country;
  String? state;
  String? address;
  String? phone;
  String? websiteUrl;
  int? emailNotification;
  int? smsNotification;
  int? awardPoints;
  String? facebookId;
  String? instagramId;
  String? firebaseUid;
  String? fcmToken;

  User({
    this.id,
    this.name,
    this.email,
    this.roles,
    this.profileImage,
    this.backgroundImage,
    this.emailVerifiedAt,
    this.googleId,
    this.permissionId,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.username,
    this.city,
    this.gender,
    this.dateOfBirth,
    this.maritalStatus,
    this.ageGroup,
    this.country,
    this.state,
    this.address,
    this.phone,
    this.websiteUrl,
    this.emailNotification,
    this.smsNotification,
    this.awardPoints,
    this.facebookId,
    this.instagramId,
    this.firebaseUid,
    this.fcmToken,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    roles = json['roles'];
    profileImage = json['profile_image'];
    backgroundImage = json['background_image'];
    emailVerifiedAt = json['email_verified_at'];
    googleId = json['google_id'];
    permissionId =
        json['permission_id'] is int
            ? json['permission_id']
            : int.tryParse(json['permission_id'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    city = json['city'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    maritalStatus = json['marital_status'];
    ageGroup = json['age_group'];
    country = json['country'];
    state = json['state'];
    address = json['address'];
    phone = json['phone'];
    websiteUrl = json['website_url'];
    emailNotification = json['email_notification'];
    smsNotification = json['sms_notification'];
    awardPoints = json['award_points'];
    facebookId = json['facebook_id'];
    instagramId = json['instagram_id'];
    firebaseUid = json['firebase_uid'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['roles'] = roles;
    data['profile_image'] = profileImage;
    data['background_image'] = backgroundImage;
    data['email_verified_at'] = emailVerifiedAt;
    data['google_id'] = googleId;
    data['permission_id'] = permissionId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['username'] = username;
    data['city'] = city;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['marital_status'] = maritalStatus;
    data['age_group'] = ageGroup;
    data['country'] = country;
    data['state'] = state;
    data['address'] = address;
    data['phone'] = phone;
    data['website_url'] = websiteUrl;
    data['email_notification'] = emailNotification;
    data['sms_notification'] = smsNotification;
    data['award_points'] = awardPoints;
    data['facebook_id'] = facebookId;
    data['instagram_id'] = instagramId;
    data['firebase_uid'] = firebaseUid;
    data['fcm_token'] = fcmToken;
    return data;
  }
}
