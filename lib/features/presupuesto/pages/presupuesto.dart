import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/scroll/custom_scroll.dart';
import 'package:portal_muni/app/spinner/dual_ring.dart';
import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/presupuesto/bloc/presupuesto_bloc.dart';
import 'package:portal_muni/features/presupuesto/pages/registro_presupuesto.dart';
import 'package:portal_muni/features/presupuesto/widgets/filtro.dart';
import 'package:portal_muni/features/presupuesto/widgets/presupuesto_list_tile.dart';
import 'package:portal_muni/features/presupuesto/widgets/presupusto_item.dart';

class PresupuestoPage extends StatelessWidget {
  const PresupuestoPage({super.key});

  @override
  Widget build(BuildContext context) {
    void showAlertError(String title, String message) {
      Alert.error(context, title: title, message: message);
    }

    void showAlertSuccess(String title, String message) {
      Alert.success(context, title: title, message: message, pop: true);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Presupuestos Proyectados y Aprobados'),
      ),
      body: BlocConsumer<PresupuestoBloc, PresupuestoState>(
        listener: (context, state) {
          if (state.react == React.deleteSuccess) {
            showAlertSuccess('Ok', 'Elemento eliminado!');
          }
          if (state.react == React.deleteError) {
            showAlertError('Error', 'Error al eliminar!');
          }
        },
        builder: (context, state) {
          if (state.react == React.initial || state.react == React.getLoading) {
            return const Center(
              child: DualRing(
                message: 'Cargando Presupuestos',
              ),
            );
          } else if (state.react == React.deleteLoading) {
            return const Center(
              child: DualRing(
                message: 'Eliminado Presupuesto',
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    width: Device.media(context),
                    child: const FiltrosBusqueda(),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    return CenterChildList(
                      child: PresupuestoItem(
                        nombre: state.filterList[index].nombre.split('.').first,
                        tipo: state.filterList[index].tipo,
                        categoria: state.filterList[index].categoria,
                        onDelete: () {
                          BlocProvider.of<PresupuestoBloc>(context).add(
                            DeletePresupuestoEvent(state.filterList[index].id),
                          );
                        },
                      ),
                    );
                  },
                  childCount: state.filterList.length,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor('3B86F9'),
        foregroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Wrap(
              children: [
                PresupuestoListTile(
                  title: 'Nuevo Presupuesto Proyectado',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RegistroPresupuestoPage(tipo: 'Proyectado'),
                      ),
                    );
                  },
                ),
                PresupuestoListTile(
                  title: 'Nuevo Presupuesto Aprobado',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RegistroPresupuestoPage(tipo: 'Aprobado'),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
