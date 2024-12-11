import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal_muni/app/buttons/refresh_icon.dart';
import 'package:portal_muni/app/dialog/banner_ui.dart';
import 'package:portal_muni/app/spinner/dual_ring.dart';
import 'package:portal_muni/core/utils/device.dart';
import 'package:portal_muni/core/utils/hexcolor.dart';

import 'package:portal_muni/features/report_finance/bloc/report_finance_bloc.dart';
import 'package:portal_muni/features/report_finance/pages/registro_reporte.dart';
import 'package:portal_muni/features/report_finance/widgets/filtro.dart';
import 'package:portal_muni/features/report_finance/widgets/presupusto_item.dart';

class ReporteFinancieroPage extends StatelessWidget {
  const ReporteFinancieroPage({super.key});

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
        title: const Text('Reporte Anual Financiero'),
        actions: [
          RefreshIcon(
            onPressed: () {
              BlocProvider.of<ReportFinanceBloc>(context)
                  .add(LoadReportFinanceEvt());
            },
          )
        ],
      ),
      body: BlocConsumer<ReportFinanceBloc, ReportFinanceState>(
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
                message: 'Cargando',
              ),
            );
          } else if (state.react == React.deleteLoading) {
            return const Center(
              child: DualRing(
                message: 'Eliminado...',
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
                      child: ReporteItem(
                        nombre: state.filterList[index].nombre.split('.').first,
                        year: state.filterList[index].year,
                        onDelete: () {
                          BlocProvider.of<ReportFinanceBloc>(context).add(
                            DeleteReportFinanceEvt(state.filterList[index].id),
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
              builder: (context) => const RegistroReportePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CenterChildList extends StatelessWidget {
  const CenterChildList({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Device.media(context),
        child: child,
      ),
    );
  }
}
