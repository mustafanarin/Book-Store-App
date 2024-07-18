import 'package:auto_route/auto_route.dart';
import 'package:book_store_mobile/product/color/project_colors.dart';
import 'package:book_store_mobile/product/extensions/build_context_extensions.dart';
import 'package:book_store_mobile/product/extensions/image_path_extension.dart';
import 'package:book_store_mobile/product/navigator/app_router.dart';
import 'package:book_store_mobile/product/widgets/elevated_button.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

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
            ElevatedButtonProject(text: loginButtonText,
            onPressed: () => AutoRouter.of(context).replace(LoginRoute())),
            ElevatedButtonProject(text: skipButtonText,
            onPressed: () => AutoRouter.of(context).replace(LoginRoute()),backgroundColor: ProjectColors.flyByNight,textColor: ProjectColors.majoreBlue,)
          ],
        ),
      ),
    );
  }
}

