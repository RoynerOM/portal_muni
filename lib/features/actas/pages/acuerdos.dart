import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/scroll/custom_scroll.dart';
import 'package:portal_muni/app/spinner/dual_ring.dart';

import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/actas/bloc/actas_bloc.dart';
import 'package:portal_muni/features/actas/pages/registro_acuerdos.dart';
import 'package:portal_muni/features/actas/widgets/acta_item.dart';
import 'package:portal_muni/features/actas/widgets/filtro_acuerdo.dart';

class Acuerdos extends StatelessWidget {
  const Acuerdos({super.key});

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
        title: const Text('Acuerdos'),
      ),
      body: BlocConsumer<ActasBloc, ActasState>(
        listener: (context, state) {
          if (state.react == ActasReact.deleteSuccess) {
            showAlertSuccess('Ok', 'Elemento eliminado!');
          }
          if (state.react == ActasReact.deleteError) {
            showAlertError('Error', 'Error al eliminar!');
          }
        },
        builder: (context, state) {
          if (state.react == ActasReact.initial ||
              state.react == ActasReact.getLoading) {
            return const Center(
              child: DualRing(
                message: 'Cargando Acuerdos',
              ),
            );
          } else if (state.react == ActasReact.deleteLoading) {
            return const Center(
              child: DualRing(
                message: 'Eliminado Acuerdo',
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    width: Device.media(context),
                    child: const FiltroAcuerdos(),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    return CenterChildList(
                      child: ActaItem(
                        isActa: false,
                        nombre: state.filterListAcuerdos[index].nombre
                            .split('.')
                            .first,
                        year: state.filterListAcuerdos[index].fecha,
                        onDelete: () {
                          BlocProvider.of<ActasBloc>(context).add(
                            DeleteAcuerdoEvt(
                                state.filterListAcuerdos[index].id),
                          );
                        },
                      ),
                    );
                  },
                  childCount: state.filterListAcuerdos.length,
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
              builder: (context) => const RegistroAcuerdos(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
