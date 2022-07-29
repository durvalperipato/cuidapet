part of '../login_page.dart';

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          CuidapetTextFormField(label: 'Login'),
          const SizedBox(height: 20),
          CuidapetTextFormField(
            label: 'Senha',
            obscureText: true,
          ),
          const SizedBox(height: 20),
          CuidapetDefaultButton(
            label: 'Entrar',
            onPressed: () {},
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
  const _OrSeparator({Key? key}) : super(key: key);

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
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
                color: context.primaryColor),
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
