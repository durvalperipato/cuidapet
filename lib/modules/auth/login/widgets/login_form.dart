part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _controller = Modular.get<LoginController>();
  final _formKey = GlobalKey<FormState>();
  final _loginEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _loginEC.dispose;
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CuidapetTextFormField(
            label: 'Login',
            controller: _loginEC,
            validator: Validatorless.multiple([
              Validatorless.required('Login obrigatório'),
              Validatorless.email('E-mail inválido'),
            ]),
          ),
          const SizedBox(height: 20),
          CuidapetTextFormField(
              label: 'Senha',
              controller: _passwordEC,
              obscureText: true,
              validator: Validatorless.multiple(
                [
                  Validatorless.required('Senha obrigatória'),
                  Validatorless.min(6, 'Senha deve conter pelo menos 6 caracteres'),
                ],
              )),
          const SizedBox(height: 20),
          CuidapetDefaultButton(
            label: 'Entrar',
            onPressed: () async {
              final formValid = _formKey.currentState?.validate() ?? false;
              if (formValid) {
                await _controller.login(
                  login: _loginEC.text,
                  password: _passwordEC.text,
                );
              }
            },
          ),
          const SizedBox(height: 10),
          const _OrSeparator(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _OrSeparator extends StatelessWidget {
  const _OrSeparator();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 1,
            color: context.primaryColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'OU',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16.sp, color: context.primaryColor),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 1,
            color: context.primaryColor,
          ),
        ),
      ],
    );
  }
}
