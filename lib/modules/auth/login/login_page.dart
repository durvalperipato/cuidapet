import 'package:cuidapet_mobile/app/core/ui/icons/cuidapet_icons.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_text_form_field.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/rounded_button_with_icon.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CuidapetTextFormField(
                label: 'Login',
                obscureText: true,
              ),
              RoundedButtonWithIcon(
                onTap: () {},
                width: 200,
                color: Colors.blue,
                icon: CuidapetIcons.facebook,
                label: 'Facebook',
              ),
              RoundedButtonWithIcon(
                onTap: () {},
                width: 200,
                color: Colors.orange,
                icon: CuidapetIcons.google,
                label: 'Google',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
