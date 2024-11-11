import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/text_field/text_field_ui.dart';
import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/report_finance/bloc/report_finance_bloc.dart';

class FiltrosBusqueda extends StatefulWidget {
  const FiltrosBusqueda({super.key});

  @override
  State<FiltrosBusqueda> createState() => _FiltrosBusquedaState();
}

class _FiltrosBusquedaState extends State<FiltrosBusqueda> {
  final tipoController = TextEditingController();
  final nombreController = TextEditingController();
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
                width: media ? null : 350,
                constraints: media
                    ? null
                    : const BoxConstraints(minWidth: 250, maxWidth: 350),
                child: Input(
                  controller: nombreController,
                  hintText: 'Buscar por nombre o año',
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
                    BlocProvider.of<ReportFinanceBloc>(context).add(
                      FiltrosEvent(nombreController.text, tipoController.text),
                    );
                  },
                  icon: const Icon(Icons.filter_list, size: 24),
                  label: const Text(
                    'Aplicar Filtros',
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
