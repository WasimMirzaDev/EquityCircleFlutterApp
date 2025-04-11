class JobListModel {
  Jobs? jobs;

  JobListModel({this.jobs});

  JobListModel.fromJson(Map<String, dynamic> json) {
    jobs = json['jobs'] != null ? Jobs.fromJson(json['jobs']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
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
    data =
        (json['data'] as List?)?.map((v) => DataByJobList.fromJson(v)).toList();
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    links = (json['links'] as List?)?.map((v) => Links.fromJson(v)).toList();
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['current_page'] = currentPage;
    dataMap['data'] = data?.map((v) => v.toJson()).toList();
    dataMap['first_page_url'] = firstPageUrl;
    dataMap['from'] = from;
    dataMap['last_page'] = lastPage;
    dataMap['last_page_url'] = lastPageUrl;
    dataMap['links'] = links?.map((v) => v.toJson()).toList();
    dataMap['next_page_url'] = nextPageUrl;
    dataMap['path'] = path;
    dataMap['per_page'] = perPage;
    dataMap['prev_page_url'] = prevPageUrl;
    dataMap['to'] = to;
    dataMap['total'] = total;
    return dataMap;
  }
}

class DataByJobList {
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
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    shortDescription = json['short_description'];
    description = json['description'];
    mainImage = json['main_image'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];

    // Safely handle application being a String or null
    application = json['application'] is String ? json['application'] : null;

    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['id'] = id;
    dataMap['user_id'] = userId;
    dataMap['title'] = title;
    dataMap['short_description'] = shortDescription;
    dataMap['description'] = description;
    dataMap['main_image'] = mainImage;
    dataMap['is_active'] = isActive;
    dataMap['created_at'] = createdAt;
    dataMap['updated_at'] = updatedAt;
    dataMap['deleted_at'] = deletedAt;
    dataMap['application'] = application;
    if (user != null) {
      dataMap['user'] = user!.toJson();
    }
    return dataMap;
  }
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? roles;
  final String? profileImage;
  final String? backgroundImage;
  final String? emailVerifiedAt;
  final String? googleId;
  final int? permissionId;
  final String? createdAt;
  final String? updatedAt;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? city;
  final String? gender;
  final String? dateOfBirth;
  final String? maritalStatus;
  final String? ageGroup;
  final String? country;
  final String? state;
  final String? address;
  final String? phone;
  final String? websiteUrl;
  final int? emailNotification;
  final int? smsNotification;
  final int? awardPoints;
  final String? facebookId;
  final String? instagramId;
  final String? firebaseUid;
  final String? fcmToken;

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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: safeParseInt(json['id']),
      name: json['name'],
      email: json['email'],
      roles: json['roles'],
      profileImage: json['profile_image'],
      backgroundImage: json['background_image'],
      emailVerifiedAt: json['email_verified_at'],
      googleId: json['google_id'],
      permissionId: safeParseInt(json['permission_id']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      city: json['city'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      maritalStatus: json['marital_status'],
      ageGroup: json['age_group'],
      country: json['country'],
      state: json['state'],
      address: json['address'],
      phone: json['phone']?.toString(),
      websiteUrl: json['website_url']?.toString(),
      emailNotification: safeParseInt(json['email_notification']),
      smsNotification: safeParseInt(json['sms_notification']),
      awardPoints: safeParseInt(json['award_points']),
      facebookId: json['facebook_id'],
      instagramId: json['instagram_id'],
      firebaseUid: json['firebase_uid'],
      fcmToken: json['fcm_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'roles': roles,
      'profile_image': profileImage,
      'background_image': backgroundImage,
      'email_verified_at': emailVerifiedAt,
      'google_id': googleId,
      'permission_id': permissionId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'city': city,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'marital_status': maritalStatus,
      'age_group': ageGroup,
      'country': country,
      'state': state,
      'address': address,
      'phone': phone,
      'website_url': websiteUrl,
      'email_notification': emailNotification,
      'sms_notification': smsNotification,
      'award_points': awardPoints,
      'facebook_id': facebookId,
      'instagram_id': instagramId,
      'firebase_uid': firebaseUid,
      'fcm_token': fcmToken,
    };
  }

  @override
  String toString() => 'User(id: $id, email: $email)';
}

class Links {
  final String? url;
  final String? label;
  final bool? active;

  Links({this.url, this.label, this.active});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'label': label, 'active': active};
  }

  @override
  String toString() => 'Links(label: $label)';
}

/// Shared helper function
int? safeParseInt(dynamic value) {
  if (value == null) return null;
  return value is int ? value : int.tryParse(value.toString());
}
