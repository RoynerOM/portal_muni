import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/core/utils/app_modules.dart';
import 'package:portal_muni/features/access/bloc/access_bloc.dart';

class AdminConfigPage extends StatelessWidget {
  const AdminConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Administrador"),
        centerTitle: true,
      ),
      body: BlocBuilder<AccessBloc, AccessState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: appModules.map((modulo) {
              return Container(
                margin: const EdgeInsets.only(bottom: 22),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color.fromRGBO(25, 109, 133, 1)),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                ),
                child: ExpansionTile(
                  backgroundColor: const Color.fromRGBO(25, 109, 133, 1),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.indigo,
                  textColor: Colors.white,
                  tilePadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  childrenPadding: const EdgeInsets.only(bottom: 0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  collapsedShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  title: Text(
                    modulo.titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(modulo.icono),
                  children: modulo.screens.map((screen) {
                    final activo = state.permisos[screen] ?? false;

                    return SwitchListTile(
                      tileColor: Colors.grey.shade100,
                      title: Text(
                        screen.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      value: activo,
                      onChanged: (value) {
                        context.read<AccessBloc>().add(
                              ChangeAccess(screen, value),
                            );
                      },
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
