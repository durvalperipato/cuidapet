part of '../address_page.dart';

class _AddressItem extends StatelessWidget {
  const _AddressItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const ListTile(
        title: Text(
          'Av. Paulista, 200',
        ),
        subtitle: Text('Complemento Xx'),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.location_on,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
