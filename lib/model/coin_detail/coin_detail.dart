import 'package:hive/hive.dart';
part 'coin_detail.g.dart';

@HiveType(typeId: 0)
class CoinDetail extends HiveObject {
  @HiveField(0)
  String? symbol;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? price;

  @HiveField(3)
  String? about;

  @HiveField(4)
  String? image;

  CoinDetail({this.symbol, this.name, this.price, this.about, this.image});

  CoinDetail.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    name = json['name'];
    price = json['price'];
    about = json['about'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['price'] = this.price;
    data['about'] = this.about;
    data['image'] = this.image;
    return data;
  }
}
