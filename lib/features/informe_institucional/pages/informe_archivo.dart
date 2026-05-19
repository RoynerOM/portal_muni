import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/buttons/refresh_icon.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/scroll/custom_scroll.dart';
import 'package:portal_muni/app/spinner/dual_ring.dart';
import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/informe_institucional/bloc/informe_institucional_bloc.dart';
import 'package:portal_muni/features/informe_institucional/pages/registro_informe_institucional.dart';
import 'package:portal_muni/features/informe_institucional/widgets/filtro.dart';
import 'package:portal_muni/features/informe_institucional/widgets/informe_item.dart';

class InformesArchivo extends StatefulWidget {
  const InformesArchivo({super.key});

  @override
  State<InformesArchivo> createState() => _InformesArchivoState();
}

class _InformesArchivoState extends State<InformesArchivo> {
  @override
  void initState() {
    BlocProvider.of<InformeInstitucionalBloc>(context)
        .add(LoadInformeArchivoEvt());
    super.initState();
  }

// 0 = informes especiales
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
        title: const Text("Informe del archivo institucional"),
        actions: [
          RefreshIcon(
            onPressed: () {
              context
                  .read<InformeInstitucionalBloc>()
                  .add(LoadInformeArchivoEvt());
            },
          )
        ],
      ),
      body: BlocConsumer<InformeInstitucionalBloc, InformeInstitucionalState>(
        listener: (context, state) {
          if (state.react == React.deleteSuccess) {
            showAlertSuccess('Ok', 'Elemento eliminado!');
            context
                .read<InformeInstitucionalBloc>()
                .add(LoadInformeArchivoEvt());
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
                    child: const FiltrosBusqueda(
                      type: '',
                    ),
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
                                state.filterList[index].id,
                                state.filterList[index].tipo),
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
              builder: (context) => const RegistroInformeInstitucionalPage(
                tipo: 'Archivo',
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
