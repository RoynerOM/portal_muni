import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/scroll/custom_scroll.dart';
import 'package:portal_muni/app/spinner/dual_ring.dart';
import 'package:portal_muni/app/tile/sheet_tile.dart';
import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/ejecucion/bloc/ejecucion_bloc.dart';
import 'package:portal_muni/features/ejecucion/pages/registro_ejecuciones.dart';
import 'package:portal_muni/features/ejecucion/widgets/ejecucion_item.dart';
import 'package:portal_muni/features/ejecucion/widgets/filtro.dart';

class EjecucionesPage extends StatelessWidget {
  const EjecucionesPage({super.key, this.isFinanciero = true});
  final bool isFinanciero;
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
        title: const Text('Ejecuciones de Presupuesto'),
      ),
      body: BlocConsumer<EjecucionBloc, EjecucionState>(
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
                message: 'Cargando Ejecuciones Presupuestarias',
              ),
            );
          } else if (state.react == React.deleteLoading) {
            return const Center(
              child: DualRing(
                message: 'Eliminado Ejecucion Presupuestaria',
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
                      child: EjecucionItem(
                        nombre: state.filterList[index].nombre.split('.').first,
                        tipo: state.filterList[index].tipo,
                        onDelete: () {
                          BlocProvider.of<EjecucionBloc>(context).add(
                            DeleteEjecucionEvent(state.filterList[index].id),
                          );
                        },
                        esHistorio: '',
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
            isScrollControlled: true,
            context: context,
            constraints: BoxConstraints(
                maxWidth: 800, maxHeight: isFinanciero ? 220 : 100),
            builder: (context) => ListView(
              children: (isFinanciero)
                  ? [
                      SheetTile(
                        title: 'Nuevo Informe Parcial',
                        icon: Icons.add,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegistroEjecucionPage(tipo: 'Parcial'),
                            ),
                          );
                        },
                      ),
                      SheetTile(
                        title: 'Nuevo Informe de Fin de Año',
                        icon: Icons.add,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegistroEjecucionPage(tipo: 'Final'),
                            ),
                          );
                        },
                      ),
                      /*
                      SheetTile(
                        title: 'Nuevo Histórico Aprobado y Ejecutado',
                        icon: Icons.add,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistroEjecucionPage(
                                tipo: 'Histórico',
                              ),
                            ),
                          );
                        },
                      ),*/
                    ]
                  : [
                      SheetTile(
                        title: 'Nueva Auditoría del Gasto Público',
                        icon: Icons.add,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistroEjecucionPage(
                                  tipo: 'Auditorías'),
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
