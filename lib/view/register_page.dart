import 'package:auto_route/auto_route.dart';
import 'package:book_store_mobile/product/color/project_colors.dart';
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
class RegisterPage extends HookWidget {
  const RegisterPage({super.key});

  final String _welcomeText = "Welcome";
  final String _titleText = "Register an account";
  final String _nameText = "Name";
  final String _tfNameHint = "Jhon Doe";
  final String _emailText = "E-mail";
  final String _tfEmailHint = "jhon@gmail.com";
  final String _passwordText = "Password";
  final String _tfPasswordHint = "● ● ● ● ● ●";
  final String _registerText = "Login";
  final String _loginButtonText = "Register";

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final epostController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView( 
          child: ConstrainedBox( 
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
            ),
            child: IntrinsicHeight( 
              child: Padding(
                padding: context.paddingColumnHorizontalLow2,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(flex: 10),
                      const _ScreenLogo(),
                      const Spacer(flex: 25),
                      MediumText(text: _welcomeText, color: ProjectColors.grey),
                      LargeText(text: _titleText),
                      const Spacer(flex: 20),
                      MediumText(text: _nameText),
                      _TfName(tfNameHint: _tfNameHint, nameController: nameController),
                      const Spacer(flex: 5),
                      MediumText(text: _emailText),
                      _TfEmail(tfEmailHint: _tfEmailHint, epostController: epostController),
                      const Spacer(flex: 5),
                      MediumText(text: _passwordText),
                      _TfPassword(tfPasswordHint: _tfPasswordHint, passwordController: passwordController),
                      const Spacer(flex: 2),
                      _TextButtonGoLogin(registerText: _registerText),
                      const Spacer(flex: 15),
                      _ElevatedButtonRegister(loginButtonText: _loginButtonText, formKey: formKey),
                      const Spacer(flex: 10)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
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
        child: Image.asset(LogoName.app_logo.path(), fit: BoxFit.contain),
      ),
    );
  }
}

class _TfName extends StatelessWidget {
  const _TfName({
    required String tfNameHint,
    required this.nameController,
  }) : _tfNameHint = tfNameHint;

  final String _tfNameHint;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFiledProject(hintText: _tfNameHint, controller: nameController, validator: Validators().validateName, keyboardType: TextInputType.name);
  }
}

class _TfEmail extends StatelessWidget {
  const _TfEmail({
    required String tfEmailHint,
    required this.epostController,
  }) : _tfEmailHint = tfEmailHint;

  final String _tfEmailHint;
  final TextEditingController epostController;

  @override
  Widget build(BuildContext context) {
    return TextFiledProject(hintText: _tfEmailHint, controller: epostController, validator: Validators().validateEmail, keyboardType: TextInputType.emailAddress);
  }
}

class _TfPassword extends StatelessWidget {
  const _TfPassword({
    required String tfPasswordHint,
    required this.passwordController,
  }) : _tfPasswordHint = tfPasswordHint;

  final String _tfPasswordHint;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFiledProject(hintText: _tfPasswordHint, controller: passwordController, validator: Validators().validatePassword, keyboardType: TextInputType.visiblePassword, obscure: true);
  }
}

class _TextButtonGoLogin extends StatelessWidget {
  const _TextButtonGoLogin({
    required String registerText,
  }) : _registerText = registerText;

  final String _registerText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => context.maybePop(),
        child: Text(_registerText, style: Theme.of(context).textTheme.titleSmall)),
    );
  }
}

class _ElevatedButtonRegister extends HookWidget {
  const _ElevatedButtonRegister({
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