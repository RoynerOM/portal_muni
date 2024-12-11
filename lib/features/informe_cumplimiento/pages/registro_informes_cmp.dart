import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/scroll/center_scroll.dart';
import 'package:portal_muni/app/text_field/text_field.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/informe_cumplimiento/bloc/informe_cumplimiento_bloc.dart';
import 'package:portal_muni/features/informe_cumplimiento/models/informe_cumplimiento_model.dart';

class RegistroInformeCMPPage extends StatefulWidget {
  const RegistroInformeCMPPage({super.key, required this.tipo});
  final String tipo;
  @override
  State<RegistroInformeCMPPage> createState() => _RegistroInformeCMPPageState();
}

class _RegistroInformeCMPPageState extends State<RegistroInformeCMPPage> {
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

  String getTipo() {
    if (widget.tipo == "Plan estratégico/ institucional") {
      return 'Plan Estratégico Municipal ${DateTime.now().year}- ';
    }

    if (widget.tipo == "Plan anual operativo") {
      return 'Plan Anual Operativo ${DateTime.now().year} ';
    }

    return '';
  }

  bool isInformeCumplimiento() {
    return widget.tipo == 'Informes de cumplimiento';
  }

  bool isInformeAnual() {
    return widget.tipo == 'Informe anual de gestión';
  }

  bool isInformeFinal() {
    return widget.tipo == 'Informe final de gestión';
  }

  bool isInformeHistorico() {
    return widget.tipo == 'Histórico de informes anuales';
  }

  bool isInformeSeguimientos() {
    return widget.tipo == 'Informes de seguimiento a las recomendaciones';
  }

  @override
  void initState() {
    _nameController.text = getTipo();
    _yearController.text = DateTime.now().year.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registro de ${widget.tipo}'),
      ),
      body: BlocConsumer<InformeCumplimientoBloc, InformeCumplimientoState>(
        listener: (context, state) {
          if (state.react == React.postSuccess) {
            showAlertSuccess('Ok', 'Elemento guardado!');
            clear();
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
                  if (isInformeCumplimiento() ||
                      isInformeAnual() ||
                      isInformeFinal() ||
                      isInformeSeguimientos())
                    InputSelect(
                        labelText: 'Tipo de informe',
                        options: [
                          if (isInformeCumplimiento())
                            Option(value: 'INFORME AUTOEVALUACION SCI'),
                          if (isInformeCumplimiento())
                            Option(value: 'INFORME MU-PI-INF-'),
                          if (isInformeCumplimiento())
                            Option(value: 'INFORME SEVRI'),
                          if (isInformeAnual())
                            Option(value: 'INFORME MU-ALM-INF-'),
                          if (isInformeFinal())
                            Option(
                                value: 'INFORME FINAL GESTION MAUREN FALLAS '),
                          if (isInformeSeguimientos())
                            Option(value: 'MU-AI-INFO-'),
                          if (isInformeSeguimientos())
                            Option(value: 'ADVERTENCIA MU-AI-SAD-'),
                          if (isInformeSeguimientos())
                            Option(value: 'SEGUIMIENTO MU-AI-SE-'),
                        ],
                        onChanged: (Option opc) {
                          _nameController.text = opc.value;
                        }),
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
                    labelText: 'Año de emisión',
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
                  onSend(),
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

  Widget onSend() => InkWell(
        onTap: () {
          if (_formKey.currentState!.validate() && _selectedFile != null) {
            BlocProvider.of<InformeCumplimientoBloc>(context).add(
              CreateInformeCumplimientoEvt(
                file: _selectedFile!,
                model: InformeCumplimientoModel(
                  id: '',
                  year: _yearController.text.trim(),
                  fecha: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  url: '',
                  nombre: _nameController.text,
                  tipo: widget.tipo,
                ),
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
              color: HexColor('3A85FF'),
              borderRadius: BorderRadius.circular(20)),
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
