import 'package:flutter/services.dart';
import 'package:plantify_plantshop_project/common/plant_info/plant_model.dart';
import 'package:plantify_plantshop_project/plant_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlantRepository {
  final _supabase = Supabase.instance.client;

  Future<Uint8List> getImageDataFromAsset(String path) async {
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }

  Future<String> uploadImage(String assetPath) async {
    final imageBytes = await getImageDataFromAsset(assetPath);
    final fileName = assetPath.split('/').last;
    final storagePath = 'plants/$fileName';

    await _supabase.storage
        .from('plants')
        .uploadBinary(
          storagePath,
          imageBytes,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );

    final imageUrl = _supabase.storage.from('plants').getPublicUrl(storagePath);
    return imageUrl;
  }

  Future<void> uploadPlants() async {
    for (var plant in plants) {
      List<String> imageUrls = [];

      for (String asset in plant['imageUrl'] as List<String>) {
        final url = await uploadImage(asset);
        imageUrls.add(url);
      }

      plant['imageUrl'] = imageUrls;

      await _supabase.from('plants').upsert(plant);
    }
  }

  Future<List<PlantModel>> fetchPlants() async {
    try {
      final response = await _supabase.from('plants').select();

      final data = response as List<dynamic>?;

      if (data == null) return [];
      return data.map((json) => PlantModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch plants: $e');
    }
  }
}
