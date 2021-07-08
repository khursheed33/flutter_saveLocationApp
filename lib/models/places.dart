import 'dart:io';
import 'package:flutter/cupertino.dart';

class PlacesLocation {
  final double lattitude;
  final double longitude;
  final String address;

  PlacesLocation({
    @required this.lattitude,
    @required this.longitude,
    this.address,
  });
}

class Places with ChangeNotifier {
  final String id;
  final String title;
  final PlacesLocation location;
  final File image;

  Places({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
