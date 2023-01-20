

import 'package:explore_hive/core/models/item.dart';
import 'package:explore_hive/ui/home/providers/item_box_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final itemsProvider = FutureProvider<List<Item>>((ref) async {
  final box = await ref.watch(itemBoxProvider.future);
  return box.values.toList();
});