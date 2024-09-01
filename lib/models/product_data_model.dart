
class ProductDataModel {
  String? id;
  String? name;
  String? moq;
  String? price;
  String? discountedPrice;

  ProductDataModel({this.id, this.name, this.moq, this.price, this.discountedPrice});

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    moq = json["moq"];
    price = json["price"];
    discountedPrice = json["discounted_price"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["moq"] = moq;
    _data["price"] = price;
    _data["discounted_price"] = discountedPrice;
    return _data;
  }
}