import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quezzy/screens/onboarding_screen/onboarding_screen.dart';
import 'package:quezzy/utils/constant.dart';
import 'package:quezzy/utils/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _timerSplash();
    super.initState();
  }

  _timerSplash() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const OnboardingScreen();
          },
        ),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _SplashScreenWidget(),
    );
  }
}

class _SplashScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: ColorsHelpers.primaryColor,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 56, top: 218),
                          child: SvgPicture.asset(Images.ovalBig),
                        ),
                        SvgPicture.asset(Images.ovalWithOutlineTop)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.ovalWithOutlineBottom),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 80, bottom: 100),
                          child: SvgPicture.asset(Images.ovalMini),
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Image.asset(
                    Images.appLogo,
                    width: 124,
                    height: 166,
                  ),
                ),
              ],
            )
            //
            ));
  }
}
