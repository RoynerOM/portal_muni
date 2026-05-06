import 'package:portal_muni/core/enums/screens.dart';
import 'package:portal_muni/core/storage/storage.dart';
import 'package:portal_muni/features/access/models/access_config.dart';

class AccesoManager {
  static final AccesoManager _instance = AccesoManager._internal();
  factory AccesoManager() => _instance;

  AccesoManager._internal();

  final Storage _storage = Storage();

  late AccesoConfig _config;

  Future<void> init() async {
    final json = _storage.getJson(Storage.accesosKey);

    if (json == null) {
      _config = AccesoConfig.defaultConfig();
      await _guardar();
    } else {
      _config = AccesoConfig.fromJson(json);
    }
  }

  bool puedeAcceder(AppScreens screen) {
    return _config.puedeVer(screen);
  }

  Future<void> setAcceso(AppScreens screen, bool value) async {
    _config.permisos[screen] = value;
    await _guardar();
  }

  Map<AppScreens, bool> get todos => _config.permisos;

  Future<void> _guardar() async {
    await _storage.setJson(Storage.accesosKey, _config.toJson());
  }
}
