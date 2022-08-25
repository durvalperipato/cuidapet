// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../app/core/ui/extensions/size_screen_extension.dart';
import '../../../../app/core/ui/extensions/theme_extension.dart';
import '../home_controller.dart';

class HomeAppBar extends SliverAppBar {
  HomeAppBar(HomeController controller, {super.key})
      : super(
          expandedHeight: 120,
          collapsedHeight: 120,
          elevation: 0,
          flexibleSpace: _CuidapetAppBar(
            controller: controller,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          pinned: true,
        );
}

class _CuidapetAppBar extends StatelessWidget {
  final HomeController controller;

  const _CuidapetAppBar({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: Colors.grey[100]!,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 65.0),
          child: Text('Cuidapet'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 65.0),
            child: IconButton(
              onPressed: () => controller.goToAddressPage(),
              icon: const Icon(
                Icons.location_on,
                color: Colors.black,
              ),
            ),
          )
        ],
        flexibleSpace: Stack(
          children: [
            Container(
              height: 120.h,
              color: context.primaryColor,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: .9.sw,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(30),
                  child: TextFormField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: const Icon(
                        Icons.search,
                        size: 25,
                        color: Colors.grey,
                      ),
                      border: outlineInputBorder,
                      focusedBorder: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
