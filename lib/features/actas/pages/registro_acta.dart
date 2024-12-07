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

class RegistroActa extends StatefulWidget {
  const RegistroActa({super.key, required this.tipo});
  final String tipo;
  @override
  State<RegistroActa> createState() => _RegistroActaState();
}

class _RegistroActaState extends State<RegistroActa> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  final _docController = TextEditingController();
  final _yearController = TextEditingController();

  File? _selectedFile;
  void clear() {
    _urlController.clear();
    _docController.clear();
    _yearController.clear();
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registro de ${widget.tipo}'),
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
                  Input(
                    labelText: 'Nombre del Documento',
                    controller: _nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor, ingresa un nombre';
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
                        return 'Por favor, ingresa un año';
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
                  const SizedBox(height: 30),
                  UploadButton(
                    documento: _selectedFile,
                    model: ActaModel(
                      id: '',
                      year: _yearController.text.trim(),
                      fecha: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      url: '',
                      nombre: _nameController.text,
                      tipo: widget.tipo,
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
    required ActaModel model,
  })  : _documento = documento,
        _model = model;

  final File? _documento;
  final ActaModel _model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_documento != null) {
          BlocProvider.of<ActasBloc>(context).add(
            CreateActaEvt(
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
