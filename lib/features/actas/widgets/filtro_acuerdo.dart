import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/text_field/text_field.dart';
import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/actas/bloc/actas_bloc.dart';

class FiltroAcuerdos extends StatefulWidget {
  const FiltroAcuerdos({super.key});

  @override
  State<FiltroAcuerdos> createState() => _FiltroAcuerdosState();
}

class _FiltroAcuerdosState extends State<FiltroAcuerdos> {
  final tipoController = TextEditingController();
  final nombreController = TextEditingController();
  final yearController =
      TextEditingController(text: DateTime.now().year.toString());
  String type = '';
  @override
  Widget build(BuildContext context) {
    bool media =
        Device.isSmallScreen(context) || Device.isMediumScreen(context);
    return BlocBuilder<ActasBloc, ActasState>(
      builder: (context, state) {
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
                  //Filtro Por Tipo
                  Container(
                    width: media ? null : 350,
                    constraints: media
                        ? null
                        : const BoxConstraints(minWidth: 250, maxWidth: 350),
                    child: InputSelect(
                      controller: tipoController,
                      hintText: 'Buscar por acta',
                      hitSearchText: 'Buscar',
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                      ),
                      options: [
                        for (var x in state.filterListActas)
                          Option(
                            id: x.id,
                            value: x.nombre,
                            alternativeValue: x.tipo,
                          ),
                      ],
                      onChanged: (Option? value) {
                        if (value != null) {
                          type = value.id!;
                          setState(() {});
                        }
                      },
                    ),
                  ),
                  // Filtro por año
                  Container(
                    width: media ? null : 350,
                    constraints: media
                        ? null
                        : const BoxConstraints(minWidth: 150, maxWidth: 150),
                    child: Input(
                      maskText: MaskText(mask: '####'),
                      hintText: 'Buscar por año',
                      controller: yearController,
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
                        BlocProvider.of<ActasBloc>(context).add(
                          FiltrosAcuerdosEvt(
                            nombreController.text,
                            yearController.text,
                            type,
                          ),
                        );
                      },
                      icon: const Icon(Icons.filter_list, size: 24),
                      label: const Text(
                        'Aplicar Filtros',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
