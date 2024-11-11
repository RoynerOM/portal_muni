import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage._internal();
  late SharedPreferences _local;
  static final Storage _instance = Storage._internal();

  factory Storage() => _instance;

  Future<void> init() async {
    _local = await SharedPreferences.getInstance();
  }

  String get userToken => _local.getString('user_token') ?? '';
  set userToken(String value) => _local.setString('user_token', value);

  String get userId => _local.getString('user_id') ?? '';
  set userId(String value) => _local.setString('user_id', value);

  String get userEmail => _local.getString('user_email') ?? '';
  set userEmail(String value) => _local.setString('user_email', value);

  void clear() {
    userToken = '';
    userId = '';
    userEmail = '';
  }
}
