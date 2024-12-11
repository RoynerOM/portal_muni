import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/buttons/refresh_icon.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/scroll/custom_scroll.dart';
import 'package:portal_muni/app/spinner/dual_ring.dart';
import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/informe_personal/bloc/informe_personal_bloc.dart';
import 'package:portal_muni/features/informe_personal/pages/registro_informe_personal.dart';
import 'package:portal_muni/features/informe_personal/widgets/filtro.dart';
import 'package:portal_muni/features/informe_personal/widgets/informe_personal_item.dart';

class InformesDePersonal extends StatelessWidget {
  const InformesDePersonal({super.key});

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
        // title: const Text('Informes de Personal'),
        title: const Text('Programa de actividades de jerarcas'),
        actions: [
          RefreshIcon(
            onPressed: () {
              BlocProvider.of<InformePersonalBloc>(context)
                  .add(LoadInformePersonalEvt());
            },
          )
        ],
      ),
      body: BlocConsumer<InformePersonalBloc, InformePersonalState>(
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
                      child: InformePersonalItem(
                        nombre: state.filterList[index].nombre.split('.').first,
                        year: state.filterList[index].year,
                        onDelete: () {
                          BlocProvider.of<InformePersonalBloc>(context).add(
                            DeleteInformePersonalEvt(
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegistroInformePersonalPage(
                tipo: 'Actividades',
              ),
            ),
          );
          /* showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            constraints: const BoxConstraints(maxWidth: 800, maxHeight: 220),
            builder: (context) => ListView(
              children: [
                SheetTile(
                  title: 'Programa de actividades de jerarcas',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistroInformePersonalPage(
                          tipo: 'Actividades',
                        ),
                      ),
                    );
                  },
                ),
                SheetTile(
                  title: 'Informes de viajes',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistroInformePersonalPage(
                          tipo: 'Viajes',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );*/
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
