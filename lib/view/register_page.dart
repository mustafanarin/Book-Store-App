import 'package:auto_route/auto_route.dart';
import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/extensions/image_path_extension.dart';
import 'package:book_store_mobile/product/navigator/app_router.dart';
import 'package:book_store_mobile/product/validator/validators.dart';
import 'package:book_store_mobile/product/widgets/elevated_button.dart';
import 'package:book_store_mobile/product/widgets/large_text.dart';
import 'package:book_store_mobile/product/widgets/medium_text.dart';
import 'package:book_store_mobile/product/widgets/textFiled.dart';
import 'package:flutter/material.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController epostController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool check = false;
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
                  key: _key,
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
                      _ElevatedButtonRegister(loginButtonText: _loginButtonText, formKey: _key),
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
  const _ScreenLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: context.mediumLogoHeight,
        width: context.mediumLogoHeight,
        child: Image.asset(ImageName.app_logo.path(), fit: BoxFit.contain),
      ),
    );
  }
}

class _TfName extends StatelessWidget {
  const _TfName({
    super.key,
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
    super.key,
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
    super.key,
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
    super.key,
    required String registerText,
  }) : _registerText = registerText;

  final String _registerText;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => context.router.maybePop(),
        child: Text(_registerText, style: const TextStyle(color: ProjectColors.majoreBlue))),
    );
  }
}

class _ElevatedButtonRegister extends StatelessWidget {
  const _ElevatedButtonRegister({
    super.key,
    required String loginButtonText,
    required GlobalKey<FormState> formKey,
  }) : _loginButtonText = loginButtonText, _key = formKey;

  final String _loginButtonText;
  final GlobalKey<FormState> _key;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonProject(
      text: _loginButtonText,
      onPressed: () {
        if (_key.currentState?.validate() ?? false) {
            AutoRouter.of(context).replaceAll([const CatalogRoute()]);
        }
      },
    );
  }
}