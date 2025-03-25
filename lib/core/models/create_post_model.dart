class CreatePostResponse {
  String? message;
  Post? post;

  CreatePostResponse({this.message, this.post});

  CreatePostResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (post != null) {
      data['post'] = post!.toJson();
    }
    return data;
  }
}

class Post {
  String? visibility;
  int? userId;
  int? categoryId;
  String? title;
  String? description;
  String? images;
  String? videos;
  String? documents;
  String? updatedAt;
  String? createdAt;
  int? id;
  int? likesCount;
  int? commentsCount;
  bool? liked;
  bool? isFollowing;
  List<Media>? media;
  User? user;
  List<dynamic>? likes;
  List<dynamic>? comments;

  Post({
    this.visibility,
    this.userId,
    this.categoryId,
    this.title,
    this.description,
    this.images,
    this.videos,
    this.documents,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.likesCount,
    this.commentsCount,
    this.liked,
    this.isFollowing,
    this.media,
    this.user,
    this.likes,
    this.comments,
  });

  Post.fromJson(Map<String, dynamic> json) {
    visibility = json['visibility'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    title = json['title'];
    description = json['description'];
    images = json['images'];
    videos = json['videos'];
    documents = json['documents'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    liked = json['liked'];
    isFollowing = json['is_following'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    // if (json['likes'] != null) {
    //   likes = <dynamic>[];
    //   json['likes'].forEach((v) {
    //     likes!.add(likes.fromJson(v));
    //   });
    // }
    // if (json['comments'] != null) {
    //   comments = <Null>[];
    //   json['comments'].forEach((v) {
    //     comments!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['visibility'] = visibility;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['description'] = description;
    data['images'] = images;
    data['videos'] = videos;
    data['documents'] = documents;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['likes_count'] = likesCount;
    data['comments_count'] = commentsCount;
    data['liked'] = liked;
    data['is_following'] = isFollowing;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (likes != null) {
      data['likes'] = likes!.map((v) => v.toJson()).toList();
    }
    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  String? type;
  String? url;

  Media({this.type, this.url});

  Media.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['url'] = url;
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
  String? permissionId;
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
    permissionId = json['permission_id'];
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
