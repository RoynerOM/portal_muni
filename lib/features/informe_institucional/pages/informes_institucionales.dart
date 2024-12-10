import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/scroll/custom_scroll.dart';
import 'package:portal_muni/app/spinner/dual_ring.dart';
import 'package:portal_muni/app/tile/sheet_tile.dart';
import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/informe_institucional/bloc/informe_institucional_bloc.dart';
import 'package:portal_muni/features/informe_institucional/pages/registro_informe_institucional.dart';
import 'package:portal_muni/features/informe_institucional/widgets/filtro.dart';
import 'package:portal_muni/features/informe_institucional/widgets/informe_item.dart';

class InformesInstitucionales extends StatelessWidget {
  const InformesInstitucionales({super.key});

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
        title: const Text('Informes Institucionales'),
      ),
      body: BlocConsumer<InformeInstitucionalBloc, InformeInstitucionalState>(
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
                      child: InformeItem(
                        nombre: state.filterList[index].nombre.split('.').first,
                        year: state.filterList[index].year,
                        onDelete: () {
                          BlocProvider.of<InformeInstitucionalBloc>(context)
                              .add(
                            DeleteInformeInstitucionalEvt(
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
            constraints: const BoxConstraints(maxWidth: 800, maxHeight: 220),
            builder: (context) => ListView(
              children: [
                SheetTile(
                  title: 'Informes Especiales de Auditoría',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RegistroInformeInstitucionalPage(
                          tipo: 'Especial',
                        ),
                      ),
                    );
                  },
                ),
                SheetTile(
                  title: 'Informes anuales de auditoría',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RegistroInformeInstitucionalPage(
                          tipo: 'Anual',
                        ),
                      ),
                    );
                  },
                ),
                /*
                SheetTile(
                  title: 'Informe del archivo institucional',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RegistroInformeInstitucionalPage(
                          tipo: 'Archivo',
                        ),
                      ),
                    );
                  },
                ),
                SheetTile(
                  title: 'Informes de calificación del personal',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const RegistroInformeInstitucionalPage(
                          tipo: 'Calificación de personal',
                        ),
                      ),
                    );
                  },
                ),*/
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
