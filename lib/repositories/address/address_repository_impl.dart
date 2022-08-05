import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/helpers/environments.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/repositories/address/address_repository.dart';
import 'package:google_place/google_place.dart';

class AddressRepositoryImpl implements AddressRepository {
  @override
  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern) async {
    final googleApiKey = Environments.params('google_api_key');
    if (googleApiKey == null) {
      throw Failure(message: 'Google Api Key Not Found');
    }
    final googlePlace = GooglePlace(googleApiKey);
    final addressResult = await googlePlace.search.getTextSearch(addressPattern);
    final candidates = addressResult?.results;

    if (candidates != null) {
      return candidates.map<PlaceModel>((searchResult) {
        final location = searchResult.geometry?.location;
        final address = searchResult.formattedAddress;
        return PlaceModel(address: address ?? '', lat: location?.lat ?? 0, lng: location?.lng ?? 0);
      }).toList();
    }
    return <PlaceModel>[];
  }
}
