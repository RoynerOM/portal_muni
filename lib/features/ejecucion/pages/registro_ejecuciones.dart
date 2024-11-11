import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/scroll/center_scroll.dart';
import 'package:portal_muni/app/text_field/text_field.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/ejecucion/bloc/ejecucion_bloc.dart';
import 'package:portal_muni/features/ejecucion/models/ejecucion_model.dart';

class RegistroEjecucionPage extends StatefulWidget {
  const RegistroEjecucionPage({super.key, required this.tipo});
  final String tipo;
  @override
  State<RegistroEjecucionPage> createState() => _RegistroEjecucionPageState();
}

class _RegistroEjecucionPageState extends State<RegistroEjecucionPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  final _docController = TextEditingController();

  File? _selectedFile;
  bool _isHistorical = false;
  void clear() {
    _nameController.clear();
    _urlController.clear();
    _isHistorical = false;
  }

  Future<void> _selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _docController.text = _selectedFile!.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registro de Presupuesto ${widget.tipo}'),
      ),
      body: BlocConsumer<EjecucionBloc, EjecucionState>(
        listener: (context, state) {
          if (state.react == React.postSuccess) {
            showAlertSuccess('Ok', 'Elemento guardado!');
          }
          if (state.react == React.postError) {
            showAlertError('Error', 'No se pudo guardar');
          }
        },
        builder: (context, state) {
          if (state.react == React.postLoading) {
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
                  Input(
                    labelText: 'Nombre del Documento',
                    controller: _nameController,
                    validator: (value) {
                      //Validar el formato de normalizar
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un nombre';
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
                        hintText: 'Selecciona un documento',
                        labelText: 'Ruta de archivo',
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
                  if (widget.tipo == 'Auditorías') const SizedBox(height: 10),
                  if (widget.tipo == 'Auditorías')
                    Row(
                      children: [
                        Checkbox(
                          value: _isHistorical,
                          onChanged: (bool? value) {
                            setState(() {
                              _isHistorical = value ?? false;
                            });
                          },
                        ),
                        const Text("¿Marcar este documento como histórico?"),
                      ],
                    ),
                  const SizedBox(height: 30),
                  UploadButton(
                    documento: _selectedFile,
                    model: EjecucionModel(
                      id: '',
                      esHistorico: _isHistorical ? '1' : '0',
                      tipo: widget.tipo,
                      fecha: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      url: '',
                      nombre: _nameController.text,
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

  void showAlertError(String title, String message) {
    Alert.error(context, title: title, message: message);
  }

  void showAlertSuccess(String title, String message) {
    Alert.success(context, title: title, message: message, pop: true);
  }
}

class UploadButton extends StatelessWidget {
  const UploadButton({
    super.key,
    required File? documento,
    required EjecucionModel model,
  })  : _documento = documento,
        _model = model;

  final File? _documento;
  final EjecucionModel _model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_documento != null) {
          BlocProvider.of<EjecucionBloc>(context).add(
            CreateEjecucionEvent(
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