import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/scroll/center_scroll.dart';
import 'package:portal_muni/app/spinner/dual_ring.dart';
import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/helpers.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/directorio_telefonico/bloc/directorio_bloc.dart';
import 'package:portal_muni/features/directorio_telefonico/models/contacto_model.dart';
import 'package:portal_muni/features/directorio_telefonico/widgets/contacto_card.dart';
import 'package:portal_muni/features/directorio_telefonico/widgets/contacto_dialog.dart';
import 'package:portal_muni/features/directorio_telefonico/widgets/filtro_directorio.dart';

class ListaDirectorio extends StatefulWidget {
  const ListaDirectorio({super.key});

  @override
  State<ListaDirectorio> createState() => _ListaDirectorioState();
}

class _ListaDirectorioState extends State<ListaDirectorio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Directorio Telefónico"),
      ),
      body: BlocConsumer<DirectorioBloc, DirectorioState>(
        listener: (context, state) {
          if (state.react == DirectorioReact.deleteSuccess) {
            showAlertSuccess(context, 'Ok', 'Elemento eliminado!');
          }
          if (state.react == DirectorioReact.deleteError) {
            showAlertError(context, 'Error', 'Error al eliminar!');
          }
          if (state.react == DirectorioReact.postSuccess) {
            showAlertSuccess(context, 'Ok', 'Elemento Guargado!');
          }
          if (state.react == DirectorioReact.postError) {
            showAlertError(context, 'Error', 'Error al Guardar!');
          }
          if (state.react == DirectorioReact.updateSuccess) {
            showAlertSuccess(context, 'Ok', 'Elemento Guargado!');
          }
          if (state.react == DirectorioReact.updateError) {
            showAlertError(context, 'Error', 'Error al editar!');
          }
        },
        builder: (context, state) {
          if (state.react == DirectorioReact.initial ||
              state.react == DirectorioReact.getLoading) {
            return const Center(
              child: DualRing(
                message: 'Cargando Directorios',
              ),
            );
          }

          if (state.react == DirectorioReact.deleteLoading) {
            return const Center(
              child: DualRing(
                message: 'Eliminando Directorio',
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    width: Device.media(context),
                    child: const FiltroDirectorio(),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.filterListDirectorio.length,
                  (_, index) {
                    final d = state.filterListDirectorio[index];
                    return CenterChildList(
                      child: ContactCard(
                        contact: d,
                        onEdit: () => _editContact(context, d),
                        onDelete: () => _deleteContact(context, d),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('3B86F9'),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () => _addContact(context),
      ),
    );
  }

  Future<void> _addContact(context) async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => const ContactoDialog(),
    );

    if (result != null) {
      final newContact = ContactoModel(
          id: 0,
          departamento: result['departamento']!,
          nombre: result['nombre']!,
          puesto: result['puesto']!,
          email: result['email']!,
          telefono: result['telefono']!,
          extension: result["extension"]);

      BlocProvider.of<DirectorioBloc>(context)
          .add(CreateDirectorioEvt(newContact));
    }
  }

  Future<void> _editContact(context, ContactoModel model) async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => ContactoDialog(contact: model),
    );

    if (result != null) {
      final updatedContact = model.copyWith(
        departamento: result['departamento']!,
        nombre: result['nombre']!,
        puesto: result['puesto']!,
        email: result['email']!,
        telefono: result['telefono']!,
        extension: result["extension"],
      );

      BlocProvider.of<DirectorioBloc>(context)
          .add(UpdateDirectorioEvt(updatedContact));
    }
  }

  Future<void> _deleteContact(context, ContactoModel contact) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.orange),
            SizedBox(width: 8),
            Text('Confirmar Eliminación'),
          ],
        ),
        content: Text(
          '¿Estás seguro de que deseas eliminar a ${contact.nombre}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      BlocProvider.of<DirectorioBloc>(context)
          .add(DeleteDirectorioEvt(contact.id.toString()));
    }
  }
}
