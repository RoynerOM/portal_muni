import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/text_field/text_field.dart';
import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/directorio_telefonico/bloc/directorio_bloc.dart';

class FiltroDirectorio extends StatefulWidget {
  const FiltroDirectorio({super.key});

  @override
  State<FiltroDirectorio> createState() => _FiltroDirectorioState();
}

class _FiltroDirectorioState extends State<FiltroDirectorio> {
  final valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool media =
        Device.isSmallScreen(context) || Device.isMediumScreen(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Filtro por Nombre
              Container(
                width: media ? null : 1080,
                constraints: media
                    ? null
                    : const BoxConstraints(minWidth: 250, maxWidth: 1080),
                child: Input(
                  controller: valorController,
                  hintText: 'Buscar por nombre,departamento,correo',
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
                width: media ? Device.media(context) : null,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    backgroundColor: Colors.white,
                    foregroundColor: HexColor('3B86F9'),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: HexColor('3B86F9')),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    BlocProvider.of<DirectorioBloc>(context).add(
                      FiltrarDirectorioEvt(valorController.text),
                    );
                  },
                  icon: const Icon(Icons.search, size: 24),
                  label: const Text(
                    'Buscar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
