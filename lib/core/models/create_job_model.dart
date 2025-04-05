class CreateJobModel {
  String? message;
  Job? job;

  CreateJobModel({this.message, this.job});

  CreateJobModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    job = json['job'] != null ? Job.fromJson(json['job']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (job != null) {
      data['job'] = job!.toJson();
    }
    return data;
  }
}

class Job {
  bool? isActive;
  int? userId;
  String? title;
  String? shortDescription;
  String? description;
  String? mainImage;
  String? updatedAt;
  String? createdAt;
  int? id;
  User? user;

  Job({
    this.isActive,
    this.userId,
    this.title,
    this.shortDescription,
    this.description,
    this.mainImage,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.user,
  });

  Job.fromJson(Map<String, dynamic> json) {
    isActive = json['is_active'];
    userId = json['user_id'];
    title = json['title'];
    shortDescription = json['short_description'];
    description = json['description'];
    mainImage = json['main_image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_active'] = isActive;
    data['user_id'] = userId;
    data['title'] = title;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['main_image'] = mainImage;
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
    permissionId = _safeParseInt(json['permission_id']);

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
  int? _safeParseInt(dynamic value) {
    if (value == null) return null;
    return value is int ? value : int.tryParse(value.toString());
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
