import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validatorless/validatorless.dart';

import '../../../app/core/ui/extensions/size_screen_extension.dart';
import '../../../app/core/ui/widgets/cuidapet_default_button.dart';
import '../../../app/core/ui/widgets/cuidapet_text_form_field.dart';
import 'register_controller.dart';

part 'widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Usuário'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 162.w,
                fit: BoxFit.fill,
              ),
            ),
            const _RegisterForm(),
          ],
        ),
      ),
    );
  }
}
