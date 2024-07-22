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

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController epostController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool check = false;
  final String welcomeText = "Welcome back!";
  final String titleText = "Login to your account";
  final String emailText = "E-mail";
  final String tfEmailHint = "jhon@gmail.com";
  final String passwordText = "Password";
  final String tfPasswordHint = "● ● ● ● ● ●";
  final String checkBoxText = "Remember me";
  final String registerText = "Register";
  final String loginButtonText = "Login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: context.paddingColumnHorizontalLow2,
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 10,),
              const _ScreenLogo(),
              const Spacer(flex: 25),
              MediumText(text: welcomeText,),
              LargeText(text: titleText),
              const Spacer(flex: 20),
              MediumText(text: emailText),
              _TextFiledEmail(tfEmailHint: tfEmailHint, epostController: epostController),
              const Spacer(flex: 5),
              MediumText(text: passwordText,),
              _TextFieldPassword(tfPasswordHint: tfPasswordHint, passwordController: passwordController),
              Row(
                children: [
                  _CheckBox(),
                  _CheckBoxText(checkBoxText: checkBoxText),
                  const Spacer(),
                  _GoRegisterPageText(registerText: registerText)
                ],
              ),
              const Spacer(flex: 40,),
               _LoginButton(loginButtonText: loginButtonText, formkey: _key),
              const Spacer(flex: 10)
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Checkbox _CheckBox() {
    return Checkbox(value: check, onChanged:(value) => setState(() {
            check = value ?? false;
              }),
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

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.loginButtonText,
    required GlobalKey<FormState> formkey,
  }) : _key = formkey;

  final String loginButtonText;
  final GlobalKey<FormState> _key;

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonProject(text: loginButtonText, onPressed: () {
     if(_key.currentState?.validate() ?? false){
      context.router.replaceAll([const CatalogRoute()]);
}
 },);
  }
}


