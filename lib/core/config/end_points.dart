import 'package:equitycircle/core/config/app_config.dart';

class EndPoints {
  static const _base = AppConfig.liveBaseUrl;

  ///------- Auth --------///
  //--- LOGIN
  static const logIn = "$_base/auth/login";
  static const loginClient = "$_base/auth/login";
}
