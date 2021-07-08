import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:native_features/helpers/db_helper.dart';
import '../models/places.dart';

class GreatPlacesProvider with ChangeNotifier {
  List<Places> _places = [];

  List<Places> get places {
    return [..._places];
  }

  void addPlace(String title, File image) {
    if (title != null && image != null) {
      // ......
      final newPlace = Places(
        id: DateTime.now().toString(),
        title: title,
        location: null,
        image: image,
      );

      _places.add(newPlace);
      notifyListeners();
      // Adding record to the local database
      DBHelper.insert('user_places', {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      });
    }
  }

  // Fetching the local data from db
  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _places = dataList
        .map(
          (item) => Places(
            id: item['id'],
            title: item['title'],
            location: null,
            image: File(
              item['image'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
