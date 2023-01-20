// ignore_for_file: unused_result

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../ui/home/providers/item_box_provider.dart';
import '../../ui/home/providers/items_provider.dart';

final repositoryProvider = Provider((ref) => Repository(ref));

class Repository {
  final Ref _ref;

  Repository(this._ref);

  Future<void> deleteItem(dynamic key) async {
    final box = await _ref.read(itemBoxProvider.future);
    await box.delete(key);
    _ref.refresh(itemsProvider);
  }

   
}
