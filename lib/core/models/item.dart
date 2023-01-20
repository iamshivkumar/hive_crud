
import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1)
class Item extends HiveObject{
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;

  Item({ this.title = "",  this.description = ""});
}
