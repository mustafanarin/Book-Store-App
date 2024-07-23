import 'package:auto_route/auto_route.dart';
import 'package:book_store_mobile/product/extensions/assets/logo_path_extension.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/navigator/app_router.dart';
import 'package:book_store_mobile/product/validator/validators.dart';
import 'package:book_store_mobile/product/widgets/elevated_button.dart';
import 'package:book_store_mobile/product/widgets/large_text.dart';
import 'package:book_store_mobile/product/widgets/medium_text.dart';
import 'package:book_store_mobile/product/widgets/textFiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class LoginPage extends HookWidget {
  const LoginPage({super.key});

  final String _welcomeText = "Welcome back!";
  final String _titleText = "Login to your account";
  final String _emailText = "E-mail";
  final String _tfEmailHint = "jhon@gmail.com";
  final String _passwordText = "Password";
  final String _tfPasswordHint = "● ● ● ● ● ●";
  final String _checkBoxText = "Remember me";
  final String _registerText = "Register";
  final String _loginButtonText = "Login";

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final epostController = useTextEditingController();
    final passwordController = useTextEditingController();
    final check = useState(false);

    return Scaffold(
      body: Padding(
        padding: context.paddingColumnHorizontalLow2,
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 10,),
              const _ScreenLogo(),
              const Spacer(flex: 25),
              MediumText(text: _welcomeText,),
              LargeText(text: _titleText),
              const Spacer(flex: 20),
              MediumText(text: _emailText),
              _TextFiledEmail(tfEmailHint: _tfEmailHint, epostController: epostController),
              const Spacer(flex: 5),
              MediumText(text: _passwordText,),
              _TextFieldPassword(tfPasswordHint: _tfPasswordHint, passwordController: passwordController),
              Row(
                children: [
                  Checkbox(
                    value: check.value,
                    onChanged: (value) => check.value = value ?? false,
                  ),
                  _CheckBoxText(checkBoxText: _checkBoxText),
                  const Spacer(),
                  _GoRegisterPageText(registerText: _registerText)
                ],
              ),
              const Spacer(flex: 40,),
              _LoginButton(loginButtonText: _loginButtonText, formKey: formKey),
              const Spacer(flex: 10)
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends HookWidget {
  const _LoginButton({
    required this.loginButtonText,
    required this.formKey,
  });

  final String loginButtonText;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonProject(
      text: loginButtonText,
      onPressed: () {
        if (formKey.currentState?.validate() ?? false) {
          context.router.replaceAll([const CatalogRoute()]);
        }
      },
    );
  }
}
class _ScreenLogo extends StatelessWidget {
  const _ScreenLogo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: context.mediumLogoHeight,
        width: context.mediumLogoHeight,
        child: Image.asset(LogoName.app_logo.path(),fit: BoxFit.contain,)),
    );
  }
}

class _TextFiledEmail extends StatelessWidget {
  const _TextFiledEmail({
    required this.tfEmailHint,
    required this.epostController,
  });

  final String tfEmailHint;
  final TextEditingController epostController;

  @override
  Widget build(BuildContext context) {
    return TextFiledProject(hintText: tfEmailHint, controller: epostController, validator: Validators().validateEmail, keyboardType: TextInputType.emailAddress,);
  }
}

class _TextFieldPassword extends StatelessWidget {
  const _TextFieldPassword({
    required this.tfPasswordHint,
    required this.passwordController,
  });

  final String tfPasswordHint;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFiledProject(hintText: tfPasswordHint, controller: passwordController, validator: Validators().validatePassword, keyboardType: TextInputType.visiblePassword,obscure: true,);
  }
}

class _CheckBoxText extends StatelessWidget {
  const _CheckBoxText({
    required this.checkBoxText,
  });

  final String checkBoxText;

  @override
  Widget build(BuildContext context) {
    return Text(checkBoxText,style: Theme.of(context).textTheme.titleSmall,);
  }
}

class _GoRegisterPageText extends StatelessWidget {
  const _GoRegisterPageText({
    required this.registerText,
  });

  final String registerText;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:() => context.pushRoute(const RegisterRoute()),
      child: Text(registerText,style: Theme.of(context).textTheme.titleSmall));
  }
}

