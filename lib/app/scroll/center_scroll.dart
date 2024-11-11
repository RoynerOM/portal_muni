import 'package:flutter/material.dart';
import 'package:portal_muni/core/utils/device.dart';

class CenterScroll extends StatelessWidget {
  const CenterScroll({super.key, required this.child, this.constraints});
  final Widget child;
  final BoxConstraints? constraints;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: Device.media(context),
            constraints: constraints ?? const BoxConstraints(maxWidth: 1320),
            child: child,
          ),
        ),
      ),
    );
  }
}

class CenterListView extends StatelessWidget {
  const CenterListView(
      {super.key, this.items = const [], this.constraints, this.controller});
  final List<Widget> items;
  final BoxConstraints? constraints;
  final ScrollController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: Device.media(context),
      child: ListView.builder(
        controller: controller,
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}

class CenterGridView extends StatelessWidget {
  const CenterGridView({super.key, this.items = const [], this.constraints});
  final List<Widget> items;
  final BoxConstraints? constraints;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: constraints ?? const BoxConstraints(maxWidth: 1320),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Center(child: items[index]);
          },
        ),
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
