var desc =
    "This is a Special type of thime, often served with cheese, lettuce, tomato, onion, chillis, pickels";

class FoodModel {
  final String imageCard;
  final String id;
  final String imageDetails;
  final String name;
  final double price;
  final double rate;
  final String specialItems;
  final String category;
  final int kcal;
  final String time;

  FoodModel({
    required this.imageCard,
    required this.id,
    required this.imageDetails,
    required this.name,
    required this.price,
    required this.rate,
    required this.specialItems,
    required this.category,
    required this.kcal,
    required this.time,
});
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
        imageCard: json['imageCard'] ?? "",
        id: json['id'] ?? "",
        imageDetails: json['imageDetails'] ?? "",
        name: json['name'] ?? 'Unknown',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
        specialItems: json['specialItems'] ?? "",
        category: json['category'] ?? "",
        kcal: json['kcal'] ?? "",
        time: json['time'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageCard': imageCard,
      'imageDetails': imageDetails,
      'name': name,
      'price': price,
      'rate': rate,
      'specialItems': specialItems,
      'category': category,
      'kcal': kcal,
      'time': time
    };
  }



}