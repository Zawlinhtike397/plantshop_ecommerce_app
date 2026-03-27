import 'package:plantify_plantshop_project/common/plant_info/plant_model.dart';
import 'package:plantify_plantshop_project/utils/storage/app_local_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavouriteRepository {
  final _supabase = Supabase.instance.client;

  Future<List<int>> getFavouriteIds() async {
    return await AppLocalStorage.getFavouriteIds();
  }

  Future<void> toggleFavourite(int plantId) async {
    List<int> ids = await AppLocalStorage.getFavouriteIds();

    if (ids.contains(plantId)) {
      ids.remove(plantId);
    } else {
      ids.add(plantId);
    }

    await AppLocalStorage.saveFavouriteIds(ids);
  }

  Future<List<PlantModel>> getFavouritePlants() async {
    List<int> ids = await AppLocalStorage.getFavouriteIds();

    if (ids.isEmpty) return [];

    final response = await _supabase
        .from('plants')
        .select()
        .inFilter('id', ids);

    // final data = response as List;

    return response.map((e) => PlantModel.fromJson(e)).toList();
  }

  Future<bool> isFavourite(int plantId) async {
    List<int> ids = await AppLocalStorage.getFavouriteIds();
    return ids.contains(plantId);
  }
}
