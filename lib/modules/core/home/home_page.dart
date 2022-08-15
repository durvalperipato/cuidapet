import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/modules/core/home/home_controller.dart';
import 'package:cuidapet_mobile/services/address/address_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends PageLifeCycleState<HomeController, HomePage> {
  AddressEntity? addressEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: const Text("Logout"),
            ),
            TextButton(
              onPressed: () async => await controller.goToAddressPage(),
              child: const Text("Ir para endereço"),
            ),
            TextButton(
              onPressed: () async {
                final result = await Modular.get<AddressService>().getAddressSelected();
                setState(() {
                  addressEntity = result;
                });
              },
              child: const Text("Buscar endereço"),
            ),
            Observer(
              builder: (_) => Column(
                children: [
                  Text(controller.addressEntity?.address ?? 'Nenhum endereço cadastrado'),
                  Text(controller.addressEntity?.additional ?? 'Nenhum complemento cadastrado'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
