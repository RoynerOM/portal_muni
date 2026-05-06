import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/core/utils/app_modules.dart';
import 'package:portal_muni/features/access/bloc/access_bloc.dart';
import 'package:portal_muni/features/access/pages/admin_page.dart';
import 'package:portal_muni/features/access/widgets/expansion_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Portal Municipal"),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminLoginPage(),
                ),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<AccessBloc, AccessState>(
        builder: (context, state) {
          return Stack(
            children: [
              Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 280,
                    maxHeight: 230,
                    minHeight: 180,
                    minWidth: 180,
                  ),
                  child: SizedBox.expand(
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ListView(
                padding: const EdgeInsets.all(16),
                children: appModules.map((modulo) {
                  final visibles = modulo.screens
                      .where((s) => state.permisos[s] ?? false)
                      .toList();

                  if (visibles.isEmpty) return const SizedBox();

                  return ExpansionTileUI(
                    icon: modulo.icono,
                    titulo: modulo.titulo,
                    vistas: visibles,
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}








/*
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(25, 109, 133, 1)),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade100,
                    ),
                    child: ExpansionTile(
                      backgroundColor: const Color.fromRGBO(25, 109, 133, 1),
                      iconColor: Colors.white,
                      collapsedIconColor: Colors.indigo,
                      textColor: Colors.white,
                      tilePadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                      children: visibles.map((screen) {
                        return ListTile(
                          tileColor: Colors.grey.shade100,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 24),
                          title: Text(
                            screen.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          leading: const Icon(
                            Icons.circle,
                            color: Color.fromRGBO(25, 109, 133, 1),
                            size: 16,
                          ),
                          onTap: () => abrirPantalla(context, screen),
                        );
                      }).toList(),
                    ),
                  );*/