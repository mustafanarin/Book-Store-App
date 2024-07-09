import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/extensions/image_path_extension.dart';
import 'package:book_store_mobile/product/validator/validators.dart';
import 'package:book_store_mobile/product/widgets/elevated_button.dart';
import 'package:book_store_mobile/product/widgets/large_text.dart';
import 'package:book_store_mobile/product/widgets/medium_text.dart';
import 'package:book_store_mobile/product/widgets/textFiled.dart';
import 'package:flutter/material.dart';

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
              Center(
                child: SizedBox(
                  height: context.mediumLogoHeight,
                  width: context.mediumLogoHeight,
                  child: Image.asset(ImageName.app_logo.path(),fit: BoxFit.contain,)),
              ),
              const Spacer(flex: 25),
              mediumText(text: welcomeText,),
              largeText(text: titleText),
              const Spacer(flex: 20),
              mediumText(text: emailText),
              TextFiledProject(hintText: tfEmailHint, controller: epostController, validator: Validators().validateEmail, keyboardType: TextInputType.emailAddress,),
              const Spacer(flex: 5),
              mediumText(text: passwordText),
              TextFiledProject(hintText: tfPasswordHint, controller: passwordController, validator: Validators().validatePassword, keyboardType: TextInputType.visiblePassword,obscure: true,),
              Row(
                children: [
                  Checkbox(value: check, onChanged:(value) => setState(() {
                    check = value ?? false;
                  }),
                  ),
                  Text(checkBoxText,style: const TextStyle(color: ProjectColors.majoreBlue),),
                  const Spacer(),
                  GestureDetector(
                    onTap: (){},
                    child: Text(registerText,style: const TextStyle(color: ProjectColors.majoreBlue),))
                ],
              ),
              const Spacer(flex: 40,),
               ElevatedButtonProject(text: loginButtonText, onPressed: () {
                if(_key.currentState?.validate() ?? false){
                print("okey");
              }
              },),
              const Spacer(flex: 10)
            ],
          ),
        ),
      ),
    );
  }
}


