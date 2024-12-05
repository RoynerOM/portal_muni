import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/scroll/custom_scroll.dart';
import 'package:portal_muni/app/spinner/dual_ring.dart';
import 'package:portal_muni/app/tile/sheet_tile.dart';
import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';
import 'package:portal_muni/features/actas/bloc/actas_bloc.dart';
import 'package:portal_muni/features/actas/pages/registro_acta.dart';
import 'package:portal_muni/features/actas/widgets/acta_item.dart';
import 'package:portal_muni/features/actas/widgets/filtro.dart';

class Actas extends StatelessWidget {
  const Actas({super.key});

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
        title: const Text('Actas y ordenes del dia'),
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
                message: 'Cargando actas',
              ),
            );
          } else if (state.react == ActasReact.deleteLoading) {
            return const Center(
              child: DualRing(
                message: 'Eliminado acta',
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: SizedBox(
                    width: Device.media(context),
                    child: const FiltroActas(),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    return CenterChildList(
                      child: ActaItem(
                        nombre: state.filterListActas[index].nombre
                            .split('.')
                            .first,
                        year: state.filterListActas[index].year,
                        onDelete: () {
                          BlocProvider.of<ActasBloc>(context).add(
                            DeleteActaEvt(state.filterListActas[index].id),
                          );
                        },
                      ),
                    );
                  },
                  childCount: state.filterListActas.length,
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
                  title: 'Acta',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistroActa(
                          tipo: 'Acta',
                        ),
                      ),
                    );
                  },
                ),
                SheetTile(
                  title: 'Orden del dia',
                  icon: Icons.add,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistroActa(
                          tipo: 'Orden del dia',
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
