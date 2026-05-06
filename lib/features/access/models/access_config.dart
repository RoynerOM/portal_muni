import 'package:portal_muni/core/enums/screens.dart';

class AccesoConfig {
  final Map<AppScreens, bool> permisos;

  AccesoConfig({required this.permisos});

  bool puedeVer(AppScreens screen) {
    return permisos[screen] ?? false;
  }

  Map<String, dynamic> toJson() {
    return permisos.map(
      (key, value) => MapEntry(key.name, value),
    );
  }

  factory AccesoConfig.fromJson(Map<String, dynamic> json) {
    final Map<AppScreens, bool> permisosMap = {};

    for (var screen in AppScreens.values) {
      permisosMap[screen] = json.containsKey(screen.name)
          ? (json[screen.name] as bool? ?? false)
          : false;
    }

    return AccesoConfig(permisos: permisosMap);
  }

  factory AccesoConfig.defaultConfig() {
    return AccesoConfig(
      permisos: {
        for (var screen in AppScreens.values) screen: false,
      },
    );
  }
}
