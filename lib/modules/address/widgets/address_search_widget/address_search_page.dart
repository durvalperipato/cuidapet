// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../address_page.dart';

typedef AddressSelectedCallback = void Function(PlaceModel);

class _AddressSearchPage extends StatefulWidget {
  final AddressSelectedCallback addresSelectedCallback;
  final PlaceModel? place;
  const _AddressSearchPage({
    super.key,
    required this.addresSelectedCallback,
    required this.place,
  });

  @override
  State<_AddressSearchPage> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchPage> {
  final _searchTextEC = TextEditingController();
  final _searchTextFN = FocusNode();
  final controller = Modular.get<AddressSearchController>();

  @override
  void initState() {
    if (widget.place != null) {
      _searchTextEC.text = widget.place!.address;
      _searchTextFN.requestFocus();
    }
    super.initState();
  }

  @override
  void dispose() {
    _searchTextEC.dispose();
    _searchTextFN.dispose();
    super.dispose();
  }

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
          controller: _searchTextEC,
          focusNode: _searchTextFN,
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

  Future<List<PlaceModel>> _suggestionsCallback(String pattern) async {
    /* if (pattern.isNotEmpty) {
      return controller.searchAddress(pattern);
    } */
    return <PlaceModel>[
      PlaceModel(address: 'Avenida Paulista, 2000', lat: 250, lng: 201),
      PlaceModel(address: 'Avenida Paulista 2, 2020', lat: 250, lng: 201),
      PlaceModel(address: 'Avenida Paulista 3, 2040', lat: 250, lng: 201),
    ];
  }

  void _onSuggestionSelected(PlaceModel suggestion) {
    _searchTextEC.text = suggestion.address;
    widget.addresSelectedCallback(suggestion);
  }
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
