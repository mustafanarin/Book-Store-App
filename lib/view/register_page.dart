import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/extensions/image_path_extension.dart';
import 'package:book_store_mobile/product/validator/validators.dart';
import 'package:book_store_mobile/product/widgets/elevated_button.dart';
import 'package:book_store_mobile/product/widgets/large_text.dart';
import 'package:book_store_mobile/product/widgets/medium_text.dart';
import 'package:book_store_mobile/product/widgets/textFiled.dart';
import 'package:book_store_mobile/view/login_page.dart';
import 'package:flutter/material.dart';

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
              mediumText(text: _welcomeText,color: ProjectColors.grey,),
              largeText(text: _titleText),
              const Spacer(flex: 20),
              mediumText(text: _nameText),
              TextFiledProject(hintText: _tfNameHint, controller: nameController, validator: Validators().validateName, keyboardType: TextInputType.name),
              const Spacer(flex: 5,),
              mediumText(text: _emailText),
              TextFiledProject(hintText: _tfEmailHint, controller: epostController, validator: Validators().validateEmail, keyboardType: TextInputType.emailAddress,),
              const Spacer(flex: 5),
              mediumText(text: _passwordText),
              TextFiledProject(hintText: _tfPasswordHint, controller: passwordController, validator: Validators().validatePassword, keyboardType: TextInputType.visiblePassword,obscure: true,),
              const Spacer(flex: 2,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                child: Align( 
                  alignment: Alignment.centerRight,
                  child: Text(_registerText,style: const TextStyle(color: ProjectColors.majoreBlue),))),
              const Spacer(flex: 15,),
               ElevatedButtonProject(text: _loginButtonText, onPressed: () {
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


