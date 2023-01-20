import 'package:explore_hive/core/models/item.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final itemBoxProvider = FutureProvider<Box<Item>>(
  (ref) => Hive.openBox<Item>("items"),
);
