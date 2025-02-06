import 'package:flutter/material.dart';
import 'package:qrone/state/models/immutable_list.dart';

class Selector<T> extends StatelessWidget {
  const Selector({
    required this.items,
    required this.isLoading,
    required this.selected,
    required this.onSelect,
    required this.text,
    super.key,
  });
  final Widget Function(T) text;
  final ImmutableList<T> items;
  final bool isLoading;
  final T? selected;
  final void Function(T) onSelect;

  @override
  Widget build(BuildContext context) => isLoading
      ? const Center(child: CircularProgressIndicator())
      : ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: text(item),
              onTap: () => onSelect(item),
              selected: item == selected,
            );
          },
        );
}
