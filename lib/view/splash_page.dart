import 'package:auto_route/auto_route.dart';
import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/assets/logo_path_extension.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/navigator/app_router.dart';
import 'package:book_store_mobile/product/widgets/elevated_button.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  final String _loginButtonText = "Login";
  final String _skipButtonText = "Skip";

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
              child: Image.asset(LogoName.app_logo.path(),fit: BoxFit.contain,))),
            const Spacer(),
            ElevatedButtonProject(text: _loginButtonText,
            onPressed: () => context.router.replace(LoginRoute())),
            ElevatedButtonProject(text: _skipButtonText,
            onPressed: () => context.router.replace(LoginRoute()),backgroundColor: ProjectColors.flyByNight,textColor: ProjectColors.majoreBlue,)
          ],
        ),
      ),
    );
  }
}

