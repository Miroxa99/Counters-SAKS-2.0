import 'package:hive/hive.dart';

part 'data.g.dart';

@HiveType(typeId: 0)
class Data {
  @HiveField(0)
  String flexNumberData;
  @HiveField(1)
  String dataCountData;
  @HiveField(2)
  String lampTextData;

  Data({required this.flexNumberData, required this.dataCountData, required this.lampTextData});

}