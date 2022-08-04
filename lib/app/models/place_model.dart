// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlaceModel {
  String address;
  double lat;
  double lng;

  PlaceModel({
    required this.address,
    required this.lat,
    required this.lng,
  });

  @override
  String toString() => 'PlaceModel(address: $address, latitude: $lat, longitude: $lng)';
}
