class FeedsModel {
  List<DataByFeed>? data;
  int? currentPage;
  int? lastPage;
  bool? hasMore;

  FeedsModel({this.data, this.currentPage, this.lastPage, this.hasMore});

  FeedsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataByFeed>[];
      json['data'].forEach((v) {
        data!.add(DataByFeed.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    hasMore = json['has_more'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['has_more'] = hasMore;
    return data;
  }

  FeedsModel copyWith({
    List<DataByFeed>? data,
    int? currentPage,
    int? lastPage,
    bool? hasMore,
  }) {
    return FeedsModel(
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class DataByFeed {
  int? id;
  int? userId;
  String? title;
  String? description;
  String? images;
  String? videos;
  String? documents;
  int? viewsCount;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  String? visibility;
  String? password;
  int? likesCount;
  int? commentsCount;
  bool? isFollowing;
  List<MediaByFeeds>? media;
  UsersByFeeds? user;
  List<LikesByFeeds>? likes;
  List<CommentsByFeeds>? comments;

  DataByFeed({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.images,
    this.videos,
    this.documents,
    this.viewsCount,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.visibility,
    this.password,
    this.likesCount,
    this.commentsCount,
    this.isFollowing,
    this.media,
    this.user,
    this.likes,
    this.comments,
  });

  DataByFeed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    images = json['images'];
    videos = json['videos'];
    documents = json['documents'];
    viewsCount = json['views_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    visibility = json['visibility'];
    password = json['password'];
    likesCount = json['likes_count'];
    commentsCount = json['comments_count'];
    isFollowing = json['is_following'];
    if (json['media'] != null) {
      media = <MediaByFeeds>[];
      json['media'].forEach((v) {
        media!.add(MediaByFeeds.fromJson(v));
      });
    }
    user = json['user'] != null ? UsersByFeeds.fromJson(json['user']) : null;
    if (json['likes'] != null) {
      likes = <LikesByFeeds>[];
      json['likes'].forEach((v) {
        likes!.add(LikesByFeeds.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <CommentsByFeeds>[];
      json['comments'].forEach((v) {
        comments!.add(CommentsByFeeds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['description'] = description;
    data['images'] = images;
    data['videos'] = videos;
    data['documents'] = documents;
    data['views_count'] = viewsCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['category_id'] = categoryId;
    data['visibility'] = visibility;
    data['password'] = password;
    data['likes_count'] = likesCount;
    data['comments_count'] = commentsCount;
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

  DataByFeed copyWith({
    int? id,
    int? userId,
    String? title,
    String? description,
    String? images,
    String? videos,
    String? documents,
    int? viewsCount,
    String? createdAt,
    String? updatedAt,
    int? categoryId,
    String? visibility,
    String? password,
    int? likesCount,
    int? commentsCount,
    bool? isFollowing,
    List<MediaByFeeds>? media,
    UsersByFeeds? user,
    List<LikesByFeeds>? likes,
    List<CommentsByFeeds>? comments,
  }) {
    return DataByFeed(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      videos: videos ?? this.videos,
      documents: documents ?? this.documents,
      viewsCount: viewsCount ?? this.viewsCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryId: categoryId ?? this.categoryId,
      visibility: visibility ?? this.visibility,
      password: password ?? this.password,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isFollowing: isFollowing ?? this.isFollowing,
      media: media ?? this.media,
      user: user ?? this.user,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }
}

class MediaByFeeds {
  String? type;
  String? url;

  MediaByFeeds({this.type, this.url});

  MediaByFeeds.fromJson(Map<String, dynamic> json) {
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

class UsersByFeeds {
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

  UsersByFeeds({
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
  });

  UsersByFeeds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    roles = json['roles'];
    profileImage = json['profile_image'];
    backgroundImage = json['background_image'];
    emailVerifiedAt = json['email_verified_at']?.toString();
    googleId = json['google_id']?.toString();
    permissionId = json['permission_id']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    city = json['city'];
    gender = json['gender'];

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
    dateOfBirth = json['date_of_birth']?.toString();
    facebookId = json['facebook_id']?.toString();
    instagramId = json['instagram_id']?.toString();
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
    return data;
  }
}

class LikesByFeeds {
  int? id;
  int? userId;
  int? postId;
  String? createdAt;
  String? updatedAt;

  LikesByFeeds({
    this.id,
    this.userId,
    this.postId,
    this.createdAt,
    this.updatedAt,
  });

  LikesByFeeds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['post_id'] = postId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class CommentsByFeeds {
  int? id;
  int? userId;
  int? postId;
  String? content;
  String? parentId;
  String? createdAt;
  String? updatedAt;
  String? media;
  UsersByFeeds? user;

  CommentsByFeeds({
    this.id,
    this.userId,
    this.postId,
    this.content,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.media,
    this.user,
  });

  CommentsByFeeds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    content = json['content'];
    parentId = json['parent_id']?.toString();

    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
    media = json['media'];
    user = json['user'] != null ? UsersByFeeds.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['post_id'] = postId;
    data['content'] = content;
    data['parent_id'] = parentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['media'] = media;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
