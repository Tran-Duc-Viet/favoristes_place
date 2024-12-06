import 'dart:io';

import 'package:uuid/uuid.dart';

final uuid = Uuid();

class PlaceLocation {
  const PlaceLocation(
      {required this.latitude, required this.longitude, required this.address});

  final double latitude;
  final double longitude;
  final String address;
}

class FavoritePlace {
  FavoritePlace({
    required this.title,
    required this.image,
    required this.location,
    String? id,
  }) : id = id ?? uuid.v4();
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;
}
