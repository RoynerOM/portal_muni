import 'package:flutter/material.dart';
import 'package:portal_muni/features/directorio_telefonico/models/contacto_model.dart';

class ContactoDialog extends StatefulWidget {
  final ContactoModel? contact;

  const ContactoDialog({super.key, this.contact});

  @override
  State<ContactoDialog> createState() => _ContactoDialogState();
}

class _ContactoDialogState extends State<ContactoDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _departamentoController;
  late TextEditingController _nombreController;
  late TextEditingController _puestoController;
  late TextEditingController _correoController;
  late TextEditingController _telefonoController;
  late TextEditingController _extController;

  @override
  void initState() {
    super.initState();
    _departamentoController =
        TextEditingController(text: widget.contact?.departamento ?? '');
    _nombreController =
        TextEditingController(text: widget.contact?.nombre ?? '');
    _puestoController =
        TextEditingController(text: widget.contact?.puesto ?? '');
    _correoController =
        TextEditingController(text: widget.contact?.email ?? '');
    _telefonoController =
        TextEditingController(text: widget.contact?.telefono ?? '');
    _extController =
        TextEditingController(text: widget.contact?.extension ?? '');
  }

  @override
  void dispose() {
    _departamentoController.dispose();
    _nombreController.dispose();
    _puestoController.dispose();
    _correoController.dispose();
    _telefonoController.dispose();
    _extController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.contact != null;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Icon(
            isEditing ? Icons.edit : Icons.person_add,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            isEditing ? 'Editar Contacto' : 'Nuevo Contacto',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, minWidth: 375),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(
                  controller: _departamentoController,
                  label: 'Departamento',
                  icon: Icons.business,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el departamento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _nombreController,
                  label: 'Nombre',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _puestoController,
                  label: 'Puesto',
                  icon: Icons.work,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el puesto';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _correoController,
                  label: 'Correo',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el correo';
                    }
                    if (!value.contains('@')) {
                      return 'Por favor ingresa un correo válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _telefonoController,
                  label: 'Teléfono',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el teléfono';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _extController,
                  label: 'Extensión',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el número de extension';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _saveContact,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text(isEditing ? 'Guardar' : 'Agregar'),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      final contactData = {
        'nombre': _nombreController.text.trim(),
        'departamento': _departamentoController.text.trim(),
        'telefono': _telefonoController.text.trim(),
        'extension': _extController.text.trim(),
        'email': _correoController.text.trim(),
        'puesto': _puestoController.text.trim(),
      };

      Navigator.of(context).pop(contactData);
    }
  }
}
