import 'dart:convert';

import 'package:core/core.dart';

import 'package:media/src/media/data/mappers/map_from_access_model.dart';
import 'package:media/src/media/domain/entities/space_media_entity.dart';

import '../../domain/repositories/media_repository.dart';
import '../datasources/interfaces/media_datasource.dart';

class MediaRepository implements IMediaRepository {
  final IMediaDataSource _mediaDataSource;

  MediaRepository({
    required IMediaDataSource mediaDataSource,
  }) : _mediaDataSource = mediaDataSource;

  @override
  Future<SpaceMediaEntity> getSpaceMedia({String? date}) async {
    try {
      SpaceMediaEntity spaceMediaEntity =
          (await _mediaDataSource.getSpaceMedia(date: date))
              .toSpaceMediaEntity();

      return spaceMediaEntity;
    } on Exception catch (e) {
      Log.error(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<SpaceMediaEntity>> getListSpaceMedia(
      {String? startDate, String? endDate, String? thumbs, int? count}) async {
    try {
      List<SpaceMediaEntity> listSpaceMediaEntity =
          (await _mediaDataSource.getListSpaceMedia(
                  startDate: startDate,
                  endDate: endDate,
                  thumbs: thumbs,
                  count: count))
              .map((e) => e.toSpaceMediaEntity())
              .toList();

      return listSpaceMediaEntity;
    } on Exception catch (e) {
      Log.error(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<SpaceMediaEntity>> setFavoriteSpaceMedia(
      SpaceMediaEntity spaceMedia) async {
    try {
      final box = await Hive.openBox<String>('favorites');

      List<SpaceMediaEntity> favorites = [];
      final String? favoritesJson = box.get('favorites');
      if (favoritesJson != null) {
        favorites = (json.decode(favoritesJson) as List)
            .map((i) => SpaceMediaEntity.fromJson(i))
            .toList();
      }

      // Verifica se já existe um item com a mesma data
      final exists = favorites.any((item) => item.date == spaceMedia.date);
      if (!exists) {
        favorites.add(spaceMedia);
        await box.put('favorites',
            json.encode(favorites.map((e) => e.toJson()).toList()));
      }
      await box.close();

      return favorites;
    } on Exception catch (e) {
      Log.error(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<SpaceMediaEntity>> removeFavoriteSpaceMedia(
      SpaceMediaEntity spaceMedia) async {
    try {
      final box = await Hive.openBox<String>('favorites');

      List<SpaceMediaEntity> favorites = [];
      final String? favoritesJson = box.get('favorites');
      if (favoritesJson != null) {
        favorites = (json.decode(favoritesJson) as List)
            .map((i) => SpaceMediaEntity.fromJson(i))
            .toList();
      }

      favorites.removeWhere((item) => item.date == spaceMedia.date);
      await box.put(
          'favorites', json.encode(favorites.map((e) => e.toJson()).toList()));
      await box.close();

      return favorites;
    } on Exception catch (e) {
      Log.error(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> isFavorite(SpaceMediaEntity spaceMedia) async {
    try {
      final box = await Hive.openBox<String>('favorites');

      final String? favoritesJson = box.get('favorites');
      await box.close();

      if (favoritesJson != null) {
        List<SpaceMediaEntity> favorites = (json.decode(favoritesJson) as List)
            .map((i) => SpaceMediaEntity.fromJson(i))
            .toList();
        return favorites.any((item) => item.date == spaceMedia.date);
      } else {
        return false;
      }
    } on Exception catch (e) {
      Log.error(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<SpaceMediaEntity>> getListFavorites() async {
    try {
      final box = await Hive.openBox<String>('favorites');

      final String? favoritesJson = box.get('favorites');
      await box.close();

      if (favoritesJson != null) {
        List<SpaceMediaEntity> favorites = (json.decode(favoritesJson) as List)
            .map((i) => SpaceMediaEntity.fromJson(i))
            .toList();
        return favorites;
      } else {
        return [];
      }
    } on Exception catch (e) {
      Log.error(e.toString());
      rethrow;
    }
  }
}
