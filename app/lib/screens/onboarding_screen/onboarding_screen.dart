import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/screens/login_option_screen/login_option_screen.dart';
import 'package:focus_flip/screens/sign_up_screen/sign_up_screen.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  int _current = 0;
  final _hints = const [
    'Create gamified quizzes becomes simple',
    'Find quizzes to test out your knowledge',
    'Take part in challenges with friends'
  ];

  final _illustrations = const [
    Images.illustrationOnboardingOne,
    Images.illustrationOnboardingTwo,
    Images.illustrationOnboardingThree,
  ];

  CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                        padding: const EdgeInsets.only(left: 82, top: 106),
                        child: SvgPicture.asset(Images.ovalBig),
                      ),
                      SvgPicture.asset(Images.ovalWithOutlineTopOnboarding)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 74),
                        child: SvgPicture.asset(
                            Images.ovalWithOutlineBottomOnboarding),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 80, bottom: 200),
                        child: SvgPicture.asset(Images.ovalMini),
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                  child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          height: MediaQuery.of(context).size.height,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          enableInfiniteScroll: false,
                          reverse: false,
                          initialPage: _current,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                      items: _hints.map((i) {
                        var index = _hints.indexOf(i);
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              margin: EdgeInsets.all(ScreenUtil().setWidth(16)),
                              height: double.infinity,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        SvgPicture.asset(_illustrations[index]),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(24)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: _hints
                                              .map(
                                                (eh) => Container(
                                                    margin: EdgeInsets.only(
                                                        right: ScreenUtil()
                                                            .setWidth(6),
                                                        left: ScreenUtil()
                                                            .setWidth(6)),
                                                    child: GestureDetector(
                                                      onDoubleTap: () {
                                                        // DubleTapEvent
                                                      },
                                                      child: SvgPicture.asset(
                                                        index ==
                                                                _hints
                                                                    .indexOf(eh)
                                                            ? Images
                                                                .sliderIndicatorActive
                                                            : Images
                                                                .sliderIndicator,
                                                      ),
                                                    )),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              ScreenUtil().setWidth(16)),
                                          color: Colors.white,
                                        ),
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 24),
                                              child: Text(
                                                i,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      ScreenUtil().setSp(24),
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: widgetButton(
                                                  widgetText('Sign Up',
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: ScreenUtil()
                                                          .setSp(16)),
                                                  height: 56.0,
                                                  radius: 20.0,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SignUpScreen()))),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Already have an account?',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize:
                                                        ScreenUtil().setSp(16),
                                                    color: ColorsHelpers.grey2,
                                                  ),
                                                ),
                                                GestureDetector(
                                                  child: Text(
                                                    ' Login',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: ScreenUtil()
                                                          .setSp(16),
                                                      color: ColorsHelpers
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: ((context) =>
                                                            const LoginOptionScreen()),
                                                      ),
                                                    );
                                                  },
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
