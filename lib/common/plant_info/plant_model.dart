import 'package:plantify_plantshop_project/common/plant_info/care_guide_model.dart';

class PlantModel {
  int id;
  String name;
  double originalPrice;
  // double salePrice;
  String height;
  String category;
  int stock;
  String temperature;
  String pot;
  List<String> imageUrl;
  String description;
  Map<String, CareGuideModel>? careGuide;

  PlantModel({
    required this.id,
    required this.name,
    required this.originalPrice,
    // required this.salePrice,
    required this.height,
    required this.category,
    required this.stock,
    required this.temperature,
    required this.pot,
    required this.imageUrl,
    required this.description,
    this.careGuide,
  });

  // double get discountPercent {
  //   return ((originalPrice - salePrice) / originalPrice) * 100;
  // }

  static PlantModel empty() => PlantModel(
    id: 0,
    name: '',
    originalPrice: 0.0,
    // salePrice: 0.0,
    height: '',
    category: '',
    stock: 3,
    temperature: '',
    pot: '',
    imageUrl: [],
    description: '',
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': originalPrice,
      // 'salePrice': salePrice,
      'height': height,
      'category': category,
      'stock': stock,
      'temperature': temperature,
      'pot': pot,
      'imageUrl': imageUrl,
      'description': description,
      'careGuide': careGuide?.map(
        (key, value) => MapEntry(key, {
          'title': value.title,
          'description': value.description,
        }),
      ),
    };
  }

  factory PlantModel.fromJson(Map<String, dynamic> json) {
    Map<String, CareGuideModel>? careGuideMap;
    if (json['careGuide'] != null) {
      careGuideMap = (json['careGuide'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          CareGuideModel(
            title: value['title'] ?? '',
            description: value['description'] ?? '',
          ),
        ),
      );
    }

    return PlantModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      originalPrice: (json['price'] ?? 0).toDouble(),
      // salePrice: (json['salePrice'] ?? 0).toDouble(),
      height: json['height'] ?? '',
      category: json['category'] ?? '',
      stock: json['stock'] ?? 0,
      temperature: json['temperature'] ?? '',
      pot: json['pot'] ?? '',
      imageUrl: json['imageUrl'] != null
          ? List<String>.from(json['imageUrl'])
          : [],
      description: json['description'] ?? '',
      careGuide: careGuideMap,
    );
  }
}
