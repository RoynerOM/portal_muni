import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_muni/app/scroll/center_scroll.dart';
import 'package:portal_muni/app/text_field/text_field.dart';
import 'package:portal_muni/core/utils/helpers.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/actas/bloc/actas_bloc.dart';
import 'package:portal_muni/features/actas/models/acta_model.dart';
import 'package:portal_muni/features/actas/models/acuerdo_model.dart';

class RegistroAcuerdos extends StatefulWidget {
  const RegistroAcuerdos({super.key});

  @override
  State<RegistroAcuerdos> createState() => _RegistroAcuerdosState();
}

class _RegistroAcuerdosState extends State<RegistroAcuerdos> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  final _docController = TextEditingController();
  final _yearController = TextEditingController();
  final _actaController = TextEditingController();
  String? actaId;
  File? _selectedFile;
  void clear() {
    _urlController.clear();
    _docController.clear();
    _yearController.clear();
  }

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'docx',
        'xlsx', // Excel moderno
        'xls', // Excel antiguo
        'xlsm', // Excel con macros
        'csv', // Valores separados por comas
        'xlsb', // Excel binario
        'xml', // Archivos XML
        'xltx', // Plantillas de Excel sin macros
        'xltm', // Plantillas de Excel con macros
        'txt', // Archivos de texto
        'ods' // OpenDocument Spreadsheet
      ],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _docController.text = _selectedFile!.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registro de Acuerdo'),
      ),
      body: BlocConsumer<ActasBloc, ActasState>(
        listener: (context, state) {
          if (state.react == ActasReact.postSuccess) {
            showAlertSuccess(context, 'Ok', 'Elemento guardado!');
            clear();
          }
          if (state.react == ActasReact.postError) {
            showAlertError(context, 'Error', 'No se pudo guardar');
          }
        },
        builder: (context, state) {
          if (state.react == ActasReact.postLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return CenterScroll(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InputSelect(
                    labelText: 'Acta asociada',
                    controller: _actaController,
                    options: [
                      for (ActaModel acta in state.filterListActas)
                        Option(
                          id: acta.id,
                          value: acta.nombre,
                          alternativeValue: acta.tipo,
                        )
                    ],
                    onChanged: (Option option) {
                      setState(() {
                        actaId = option.id;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, selecciona un acta asociada';
                      }
                      return null;
                    },
                  ),
                  Input(
                    labelText: 'Nombre del Documento',
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa el nombre del documento';
                      }
                      return null;
                    },
                  ),
                  Input(
                    maskText: MaskText(mask: '####'),
                    labelText: 'Año de emisión',
                    controller: _yearController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa el año de emisión';
                      }
                      return null;
                    },
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _selectFile();
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Input(
                        hintText: 'Selecciona un documento para subir',
                        labelText: 'Ruta del documento',
                        controller: _docController,
                        readOnly: true,
                        enabled: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Por favor, selecciona un documento';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  UploadButton(
                    documento: _selectedFile,
                    model: AcuerdoModel(
                      id: '',
                      year: _yearController.text.trim(),
                      fecha: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      url: '',
                      nombre: _nameController.text,
                      actaId: actaId ?? '',
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class UploadButton extends StatelessWidget {
  const UploadButton({
    super.key,
    required File? documento,
    required AcuerdoModel model,
  })  : _documento = documento,
        _model = model;

  final File? _documento;
  final AcuerdoModel _model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_documento != null) {
          BlocProvider.of<ActasBloc>(context).add(
            CreateAcuerdoEvt(
              file: _documento,
              model: _model,
            ),
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 720,
        constraints: const BoxConstraints(maxWidth: 720),
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
            color: HexColor('3A85FF'), borderRadius: BorderRadius.circular(20)),
        child: const Text(
          'Guardar',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
