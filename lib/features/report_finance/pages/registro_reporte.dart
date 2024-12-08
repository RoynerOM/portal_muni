import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/scroll/center_scroll.dart';
import 'package:portal_muni/app/text_field/text_field.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/report_finance/bloc/report_finance_bloc.dart';
import 'package:portal_muni/features/report_finance/models/report_finance_model.dart';

class RegistroReportePage extends StatefulWidget {
  const RegistroReportePage({super.key});

  @override
  State<RegistroReportePage> createState() => _RegistroReportePageState();
}

class _RegistroReportePageState extends State<RegistroReportePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _yearController = TextEditingController();
  final _docController = TextEditingController();

  File? _selectedFile;

  void clear() {
    _nameController.clear();
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
    _nameController.text = 'Informe de evaluación presupuestaria';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registro de Reporte Anual Finciero'),
      ),
      body: BlocConsumer<ReportFinanceBloc, ReportFinanceState>(
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
                  Input(
                    maskText: MaskText(mask: '####'),
                    labelText: 'Año',
                    controller: _yearController,
                    validator: (value) {
                      //Validar el formato de normalizar
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
                    model: ReportFinanceModel(
                      id: '',
                      fecha: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      url: '',
                      nombre: _nameController.text,
                      year: _yearController.text,
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
    required ReportFinanceModel model,
  })  : _documento = documento,
        _model = model;

  final File? _documento;
  final ReportFinanceModel _model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_documento != null) {
          BlocProvider.of<ReportFinanceBloc>(context).add(
            CreateReportFinanceEvt(
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
