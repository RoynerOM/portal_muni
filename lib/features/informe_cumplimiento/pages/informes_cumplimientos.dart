import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/scroll/custom_scroll.dart';
import 'package:portal_muni/app/spinner/dual_ring.dart';
import 'package:portal_muni/app/tile/sheet_tile.dart';
import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/informe_cumplimiento/bloc/informe_cumplimiento_bloc.dart';
import 'package:portal_muni/features/informe_cumplimiento/pages/registro_informes_cmp.dart';
import 'package:portal_muni/features/informe_cumplimiento/widgets/ejecucion_item.dart';
import 'package:portal_muni/features/informe_cumplimiento/widgets/filtro.dart';

// Falta corregir los filtros de busqueda y anhadir un campo interno en el modelo como historico
class InformesCumplimientos extends StatelessWidget {
  const InformesCumplimientos({super.key});

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
        title: const Text('Cumplimiento de planes institucionales'),
      ),
      body: BlocConsumer<InformeCumplimientoBloc, InformeCumplimientoState>(
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
                message: 'Cargando Informes',
              ),
            );
          } else if (state.react == React.deleteLoading) {
            return const Center(
              child: DualRing(
                message: 'Eliminado Informe',
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
                        year: state.filterList[index].year,
                        onDelete: () {
                          BlocProvider.of<InformeCumplimientoBloc>(context).add(
                            DeleteInformeCumplimientoEvt(
                                state.filterList[index].id),
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
            isScrollControlled: true,
            context: context,
            constraints: const BoxConstraints(maxWidth: 800, maxHeight: 520),
            builder: (context) => ListView(
              children: [
                SheetTile(
                  title: 'Informes de cumplimiento',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistroInformeCMPPage(
                          tipo: 'Informes de cumplimiento',
                        ),
                      ),
                    );
                  },
                ),
                SheetTile(
                  title: 'Informe anual de gestión',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistroInformeCMPPage(
                          tipo: 'Informe anual de gestión',
                        ),
                      ),
                    );
                  },
                ),
                SheetTile(
                  title: 'Informe final de gestión',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistroInformeCMPPage(
                          tipo: 'Informe final de gestión',
                        ),
                      ),
                    );
                  },
                ),
                SheetTile(
                  title: 'Histórico de informes anuales',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistroInformeCMPPage(
                          tipo: 'Histórico de informes anuales',
                        ),
                      ),
                    );
                  },
                ),
                SheetTile(
                  title: 'Informes de seguimiento a las recomendaciones',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistroInformeCMPPage(
                          tipo: 'Informes de seguimiento a las recomendaciones',
                        ),
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
