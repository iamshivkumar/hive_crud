// ignore_for_file: unused_result

import 'package:explore_hive/core/models/item.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'item_box_provider.dart';
import 'items_provider.dart';

final writeItemViewModelProvider =
    ChangeNotifierProvider.autoDispose((ref) => WriteItemViewModel(ref));

class WriteItemViewModel extends ChangeNotifier {
  final Ref _ref;

  WriteItemViewModel(this._ref);

  Item item = Item();

  bool get isEditing => item.key != null;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void init(Item item){
    if(this.item.key == null){
      this.item = item;
    }
  }

  Future<void> write() async {
    loading = true;
    try {
      final box = await _ref.read(itemBoxProvider.future);
      if(isEditing){
        await box.put(item.key, item);
      } else {
        await box.add(item);
      }
      _ref.refresh(itemsProvider);
    } catch (e) {
      loading = false;
      return Future.error(e);
    }
  }
}
