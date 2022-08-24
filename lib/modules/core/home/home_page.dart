import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../app/core/life_cycle/page_life_cycle_state.dart';
import '../../../app/core/ui/extensions/theme_extension.dart';
import '../../../app/entities/address_entity.dart';
import 'home_controller.dart';
import 'widgets/home_appbar.dart';

part 'widgets/home_address.dart';
part 'widgets/home_categories.dart';

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
            HomeAppBar(controller),
            SliverToBoxAdapter(
              child: _HomeAddress(controller: controller),
            ),
            const SliverToBoxAdapter(child: _HomeCategories()),
          ];
        },
        body: const SizedBox.shrink(),
      ),
    );
  }
}
