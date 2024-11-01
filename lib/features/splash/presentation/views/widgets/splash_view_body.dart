import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'sliding_text.dart';

import '../../../../../core/utils/assets.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> animation;

  @override
  void initState() {
    initSlidingAnimation();
    navigateToHome();
    // animation.addListener(() {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          child: Image.asset(
            AssetsData.logo,
            fit: BoxFit.fill,
          ),
        ),
        SlidingText(animation: animation),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation =
        Tween<Offset>(begin: const Offset(0, 7), end: const Offset(0, 0))
            .animate(animationController);

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        GoRouter.of(context).push("/HomeView");
        // Get.to(
        //       () => const HomeView(),
        //   transition: Transition.fade,
        //   duration: const Duration(seconds: 5),
        // );
      },
    );
  }
}
