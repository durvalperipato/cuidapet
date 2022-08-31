import 'package:flutter/material.dart';

import '../../../app/core/ui/extensions/theme_extension.dart';

class SupplierDetail extends StatelessWidget {
  const SupplierDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          child: Center(
            child: Text(
              'Clinica Central ABC',
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: context.primaryColor,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Informações do estabelecimento',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        const ListTile(
          leading: Icon(
            Icons.location_city,
            color: Colors.black,
          ),
          title: Text('Avenida Paulista, 2000'),
        ),
        const ListTile(
          leading: Icon(
            Icons.local_phone,
            color: Colors.black,
          ),
          title: Text('(11) 9-9999-8888'),
        ),
        Divider(
          thickness: 1,
          color: context.primaryColor,
        ),
      ],
    );
  }
}
