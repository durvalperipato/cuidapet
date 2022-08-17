import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/modules/core/home/home_controller.dart';
import 'package:cuidapet_mobile/modules/core/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';

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
      backgroundColor: Colors.grey[100],
      drawer: const Drawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innexBoxIsScrolled) {
          return [
            const HomeAppBar(),
          ];
        },
        body: const SizedBox.shrink(),
      ),
    );
  }
}
