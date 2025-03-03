import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseurl = dotenv.env['API_URL'] ?? 'http://your-default-url.com';
const String user1 = 'assets/images/user/1.jpg';

String getProfileImageUrl(Map<String, dynamic>? user) {
  if (user == null || user['profile_image'] == null) return user1;

  return user['profile_image'].startsWith('http')
      ? user['profile_image']
      : '$baseurl/images/${user['profile_image']}';
}

String getBackgroundProfileImageUrl(Map<String, dynamic>? user) {
  if (user == null || user['background_image'] == null) return user1;

  return user['background_image'].startsWith('http')
      ? user['background_image']
      : '$baseurl/images/backgroundprofilepic/${user['background_image']}';
}
