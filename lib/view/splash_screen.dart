import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/extensions/image_path_extension.dart';
import 'package:book_store_mobile/product/widgets/elevated_button.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final String loginButtonText = "Login";
  final String skipButtonText = "Skip";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.flyByNight,
      body: Padding(
        padding: context.paddingAllLow2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Center(child: SizedBox(
              height: context.highLogoHeight,
              width: context.highLogoHeight,
              child: Image.asset(ImageName.app_logo.path(),fit: BoxFit.contain,))),
            const Spacer(),
            ElevatedButtonProject(text: loginButtonText,onPressed: (){},),
            ElevatedButtonProject(text: skipButtonText,onPressed: (){},backgroundColor: ProjectColors.flyByNight,textColor: ProjectColors.majoreBlue,)
          ],
        ),
      ),
    );
  }
}

