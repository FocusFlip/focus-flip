import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flip/screens/trigger_app_screen/trigger_app_screen.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class MainScreenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.5, 0.5],
                colors: [
                  ColorsHelpers.primaryColor,
                  Colors.white,
                ],
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                color: ColorsHelpers.primaryColor,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(60)),
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(24),
                          right: ScreenUtil().setWidth(24)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 20.0,
                                    color: ColorsHelpers.pinkAccent,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(8)),
                                    child: widgetText('WE CHANGE YOUR HABITS',
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(12),
                                        color: ColorsHelpers.pinkAccent),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(5)),
                                child: widgetText('FocusFlip',
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(24),
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                      padding: const EdgeInsets.all(24),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(32),
                              topLeft: Radius.circular(32))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widgetText('Set up your intervention',
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(20),
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                                align: TextAlign.left),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(16)),
                              child: listItem(
                                  Icon(
                                    Icons.app_blocking,
                                    size: ScreenUtil().setHeight(30),
                                    color: ColorsHelpers.orange,
                                  ),
                                  'Trigger App',
                                  'Instagram', () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TriggerAppScreen()));
                              }, Colors.white, Colors.black,
                                  ColorsHelpers.grey2),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(16)),
                              child: listItem(
                                  Icon(
                                    Icons.school,
                                    size: ScreenUtil().setHeight(30),
                                    color: ColorsHelpers.green,
                                  ),
                                  'Healthy App',
                                  'Not chosen yet', () {
                                throw UnimplementedError();
                              }, Colors.white, Colors.black, ColorsHelpers.red),
                            ),
                            listItem(
                                Icon(
                                  Icons.timer,
                                  size: ScreenUtil().setHeight(30),
                                  color: ColorsHelpers.dullLavender,
                                ),
                                'Intervention time',
                                '5 seconds', () {
                              throw UnimplementedError();
                            }, Colors.white, Colors.black, ColorsHelpers.grey2),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
