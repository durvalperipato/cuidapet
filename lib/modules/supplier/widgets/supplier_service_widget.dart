import 'package:flutter/material.dart';

import '../../../app/core/ui/extensions/theme_extension.dart';

class SupplierServiceWidget extends StatelessWidget {
  const SupplierServiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.pets),
      ),
      title: const Text('Banho'),
      subtitle: const Text(r'R$ 10,00'),
      trailing: Icon(
        Icons.add_circle,
        color: context.primaryColor,
        size: 30,
      ),
    );
  }
}
