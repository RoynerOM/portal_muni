import 'package:flutter/material.dart';
import 'package:portal_muni/core/utils/device.dart';

class CustomSliverList extends StatelessWidget {
  final String appBarTitle;
  final String filterPlaceholder;
  final ValueChanged<String> onFilterChanged;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  const CustomSliverList({
    super.key,
    required this.appBarTitle,
    required this.filterPlaceholder,
    required this.onFilterChanged,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(appBarTitle),
          floating: true,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              'https://cdn.pixabay.com/photo/2024/10/14/16/51/trees-9120346_640.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: Device.media(context),
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: onFilterChanged,
              decoration: InputDecoration(
                labelText: filterPlaceholder,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
          ),
          delegate: SliverChildBuilderDelegate(
            itemBuilder,
            childCount: itemCount,
          ),
        ),
      ],
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
