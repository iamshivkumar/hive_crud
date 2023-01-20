// ignore_for_file: unused_element

import 'package:explore_hive/core/models/item.dart';
import 'package:explore_hive/core/repositories/repository.dart';
import 'package:explore_hive/ui/home/providers/items_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/write_item_sheet.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final style = theme.textTheme;

    void openWriteSheet([Item? item]) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (context) => WriteItemSheet(
          item: item,
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()  {
          openWriteSheet();
        },
        icon: const Icon(Icons.add),
        label: Text("Item"),
      ),
      appBar: AppBar(
        title: const Text("Items"),
      ),
      body: ref.watch(itemsProvider).when(
            data: (items) => ListView(
              children: items.map((item) {
                print(item.key);
                return Dismissible(
                  background: Container(
                    color: scheme.errorContainer,
                    child: Row(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Center(
                            child: Icon(
                              Icons.delete,
                              color: scheme.onErrorContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  key: ValueKey(item.key),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    ref.read(repositoryProvider).deleteItem(item.key);
                  },
                  child: ListTile(
                    onTap: () {
                      openWriteSheet(item);
                    },
                    title: Text(item.title),
                    subtitle: Text(item.description),
                  ),
                );
              }).toList(),
            ),
            error: (e, s) => Center(
              child: Text(
                e.toString(),
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
