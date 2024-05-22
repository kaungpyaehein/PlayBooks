import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:playbooks_flutter/persistence/hive_constants.dart';

part 'buy_link_vo.g.dart';

@HiveType(typeId: kHiveTypeBuyLinkVO, adapterName: kAdapterNameBuyLinkVO)
@JsonSerializable()
class BuyLinkVO {
  @HiveField(0)
  @JsonKey(name: "name")
  String? name;

  @HiveType(typeId: 1)
  @JsonKey(name: "url")
  String? url;

  BuyLinkVO({
    this.name,
    this.url,
  });

  factory BuyLinkVO.fromJson(Map<String, dynamic> json) =>
      _$BuyLinkVOFromJson(json);

  Map<String, dynamic> toJson() => _$BuyLinkVOToJson(this);
}
