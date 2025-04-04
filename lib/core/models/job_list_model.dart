class JobListModel {
  Jobs? jobs;

  JobListModel({this.jobs});

  JobListModel.fromJson(Map<String, dynamic> json) {
    jobs = json['jobs'] != null ? Jobs.fromJson(json['jobs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (jobs != null) {
      data['jobs'] = jobs!.toJson();
    }
    return data;
  }
}

class Jobs {
  int? currentPage;
  List<DataByJobList>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Jobs({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Jobs.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <DataByJobList>[];
      json['data'].forEach((v) {
        data!.add(DataByJobList.fromJson(v));
      });
    }
    data =
        (json['data'] as List?)?.map((v) {
          print('Parsing job data');
          return DataByJobList.fromJson(v);
        }).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class DataByJobList {
  String? safeParseString(dynamic value) {
    if (value == null) return null;
    return value is String ? value : value.toString();
  }

  int? id;
  int? userId;
  String? title;
  String? shortDescription;
  String? description;
  String? mainImage;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? application;
  User? user;

  DataByJobList({
    this.id,
    this.userId,
    this.title,
    this.shortDescription,
    this.description,
    this.mainImage,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.application,
    this.user,
  });

  DataByJobList.fromJson(Map<String, dynamic> json) {
    id = _safeParseInt(json['id']);
    userId = _safeParseInt(json['user_id']);
    title = json['title'];
    shortDescription = json['short_description'];
    description = json['description'];
    mainImage = json['main_image'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    application = json['application'];

    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int? _safeParseInt(dynamic value) {
    if (value == null) return null;
    return value is int ? value : int.tryParse(value.toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['main_image'] = mainImage;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['application'] = application;
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

    emailNotification = _safeParseInt(json['email_notification']);
    smsNotification = _safeParseInt(json['sms_notification']);
    permissionId = _safeParseInt(json['permission_id']);
    awardPoints = json['award_points'];

    phone = json['phone']?.toString();
    websiteUrl = json['website_url']?.toString();
    facebookId = json['facebook_id']?.toString();
    instagramId = json['instagram_id']?.toString();
    firebaseUid = json['firebase_uid']?.toString();
    fcmToken = json['fcm_token']?.toString();
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

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
