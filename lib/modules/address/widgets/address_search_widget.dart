// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../address_page.dart';

class _AddressSearchWidget extends StatefulWidget {
  const _AddressSearchWidget({Key? key}) : super(key: key);

  @override
  State<_AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchWidget> {
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        style: BorderStyle.none,
      ),
    );

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      child: TypeAheadFormField<PlaceModel>(
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.location_on),
            hintText: 'Insira um endereço',
            border: border,
            enabledBorder: border,
            focusedBorder: border,
          ),
        ),
        itemBuilder: (_, item) {
          return _ItemTile(address: item.address);
        },
        onSuggestionSelected: _onSuggestionSelected,
        suggestionsCallback: _suggestionsCallback,
      ),
    );
  }

  FutureOr<Iterable<PlaceModel>> _suggestionsCallback(String pattern) {
    return [PlaceModel(address: 'Avenida José Arruda', lat: 123.0, lng: 12154.0)];
  }

  void _onSuggestionSelected(suggestion) {}
}

class _ItemTile extends StatelessWidget {
  final String address;

  const _ItemTile({
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(address),
    );
  }
}
