import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../app/core/ui/extensions/size_screen_extension.dart';
import '../../../app/core/ui/extensions/theme_extension.dart';
import '../../../app/core/ui/icons/cuidapet_icons.dart';
import '../../../app/core/ui/widgets/cuidapet_default_button.dart';
import '../../../app/core/ui/widgets/cuidapet_text_form_field.dart';
import '../../../app/core/ui/widgets/rounded_button_with_icon.dart';
import '../../../app/models/social_login_type.dart';
import 'login_controller.dart';

part 'widgets/login_form.dart';
part 'widgets/login_register_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 162.w,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 20),
              const _LoginForm(),
              _LoginRegisterButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
