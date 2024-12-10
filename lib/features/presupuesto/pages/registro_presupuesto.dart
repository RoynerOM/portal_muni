import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/scroll/center_scroll.dart';
import 'package:portal_muni/app/text_field/text_field.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/presupuesto/bloc/presupuesto_bloc.dart';
import 'package:portal_muni/features/presupuesto/models/presupuesto_model.dart';

class RegistroPresupuestoPage extends StatefulWidget {
  const RegistroPresupuestoPage({super.key, required this.tipo});
  final String tipo;
  @override
  State<RegistroPresupuestoPage> createState() =>
      _RegistroPresupuestoPageState();
}

class _RegistroPresupuestoPageState extends State<RegistroPresupuestoPage> {
  final _formKey = GlobalKey<FormState>();
  final _yearController = TextEditingController();
  final _tipoController = TextEditingController();
  final _fechaController = TextEditingController();
  final _nameController = TextEditingController();
  final _urlController = TextEditingController();
  final _docController = TextEditingController();
  final _categoryController = TextEditingController();
  String prefix = '';
  File? _selectedFile;

  void clear() {
    _nameController.clear();
    _tipoController.clear();
    _urlController.clear();
    _yearController.clear();
    _fechaController.clear();
    _categoryController.clear();
    _docController.clear();
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
    _nameController.text = widget.tipo == 'Proyectado'
        ? 'Presupuesto Inicial ${DateTime.now().year}'
        : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registro de Presupuesto ${widget.tipo}'),
      ),
      body: BlocConsumer<PresupuestoBloc, PresupuestoState>(
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
                  if (widget.tipo == 'Aprobado')
                    InputSelect(
                      labelText: 'Tipo de presupuesto',
                      controller: _categoryController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, selecciona un tipo';
                        }
                        return null;
                      },
                      options: [
                        Option(value: 'Ordinario'),
                        Option(value: 'Extraordinario'),
                        Option(value: 'Modificación Presupuestaria')
                      ],
                      onChanged: (Option value) {
                        if (value.value == 'Ordinario') {
                          _nameController.text =
                              'Presupuesto Ordinario ${DateTime.now().year} aprobado';
                        }
                        if (value.value == 'Extraordinario') {
                          _nameController.text =
                              'Presupuesto Extraordinario ${DateTime.now().year}';
                        }

                        if (value.value == 'Modificación Presupuestaria') {
                          _nameController.text = 'Modificación Presupuestaria';
                        }
                      },
                    ),
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
                    labelText: 'Año de Emisión',
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
                    model: PresupuestoModel(
                      id: '',
                      categoria: _categoryController.text.trim(),
                      year: _yearController.text.trim(),
                      tipo: widget.tipo,
                      fecha: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                      url: '',
                      nombre: _nameController.text.trim(),
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
    required PresupuestoModel model,
  })  : _documento = documento,
        _model = model;

  final File? _documento;
  final PresupuestoModel _model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_documento != null) {
          BlocProvider.of<PresupuestoBloc>(context).add(
            CreatePresupuestoEvent(
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
