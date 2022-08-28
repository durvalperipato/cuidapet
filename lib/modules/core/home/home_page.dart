import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../app/core/life_cycle/page_life_cycle_state.dart';
import '../../../app/core/ui/extensions/size_screen_extension.dart';
import '../../../app/core/ui/extensions/theme_extension.dart';
import '../../../app/entities/address_entity.dart';
import '../../../app/models/supplier_category_model.dart';
import '../../../app/models/supplier_nearby_me_model.dart';
import 'home_controller.dart';
import 'widgets/home_appbar.dart';

part 'widgets/home_address.dart';
part 'widgets/home_categories.dart';
part 'widgets/home_supplier_tab.dart';

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
      drawer: Drawer(
        child: TextButton(
          onPressed: () => controller.logout(),
          child: const Text('Sair'),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innexBoxIsScrolled) {
          return [
            HomeAppBar(controller),
            SliverToBoxAdapter(
              child: _HomeAddress(controller: controller),
            ),
            SliverToBoxAdapter(child: _HomeCategories(controller)),
          ];
        },
        body: _HomeSupplierTab(homeController: controller),
      ),
    );
  }
}
