import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Storage {
  Storage._internal();
  static final Storage _instance = Storage._internal();

  factory Storage() => _instance;

  late SharedPreferences _local;

  Future<void> init() async {
    _local = await SharedPreferences.getInstance();
  }

  static const String accesosKey = 'app_accesos';

  String get userToken => _local.getString('user_token') ?? '';
  set userToken(String value) => _local.setString('user_token', value);

  String get userId => _local.getString('user_id') ?? '';
  set userId(String value) => _local.setString('user_id', value);

  String get userEmail => _local.getString('user_email') ?? '';
  set userEmail(String value) => _local.setString('user_email', value);

  // =========================
  // 📦 MÉTODOS GENÉRICOS
  // =========================

  Future<void> setString(String key, String value) async {
    await _local.setString(key, value);
  }

  String? getString(String key) {
    return _local.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await _local.setBool(key, value);
  }

  bool? getBool(String key) {
    return _local.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    await _local.setInt(key, value);
  }

  int? getInt(String key) {
    return _local.getInt(key);
  }

  // =========================
  // 🧠 JSON (CLAVE PARA PERMISOS)
  // =========================

  Future<void> setJson(String key, Map<String, dynamic> value) async {
    final jsonString = jsonEncode(value);
    await _local.setString(key, jsonString);
  }

  Map<String, dynamic>? getJson(String key) {
    final jsonString = _local.getString(key);
    if (jsonString == null) return null;

    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  // =========================
  // 🧹 UTILIDADES
  // =========================

  Future<void> remove(String key) async {
    await _local.remove(key);
  }

  Future<void> clearAll() async {
    await _local.clear();
  }

  void clear() {
    userToken = '';
    userId = '';
    userEmail = '';
  }
}
