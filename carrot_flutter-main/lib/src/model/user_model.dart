import '../shared/global.dart';

class UserModel {
  late int id;
  late String name;
  int? profile;
  get profileUrl => (profile != null)
      ? "${Global.baseUrl}/file/$profile"
      : "https://www.spongebobshop.com/cdn/shop/products/SB-Standees-Spong-1_1200x.jpg?v=1603744567";
  UserModel({required this.id, required this.name});
  UserModel.parse(Map m) {
    id = m['id'];
    name = m['name'];
    profile = m['profile_id'];
  }
}
