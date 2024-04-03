import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/cubits/main_screen/main_screen_cubit.dart';
import 'package:focus_flip/models/app.dart';
import 'package:focus_flip/repositories/predefined_app_list_repository.dart';
import 'package:focus_flip/screens/main_screen/components/choose_app_dialog.dart';
import 'package:focus_flip/screens/main_screen/components/inline_label_list.dart';
import 'package:focus_flip/screens/trigger_app_screen/components/confirmation_dialog.dart';
import 'package:focus_flip/screens/trigger_app_screen/components/youtube_video_placeholder.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/toasts.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class InterventionTimeSettingScreen extends StatelessWidget {
  InterventionTimeSettingScreen({super.key, required this.mainScreenCubit});

  final MainScreenCubit mainScreenCubit;
  final textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: widgetText('Intervention time',
                color: Colors.black,
                fontSize: ScreenUtil().setSp(24),
                fontWeight: FontWeight.w500),
            leading: Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
              child: const BackButton(
                color: Colors.black,
              ),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(8),
                right: ScreenUtil().setHeight(8)),
            color: ColorsHelpers.grey5,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(104)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ScreenUtil().setSp(20)),
                    color: Colors.white),
                padding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(16),
                    right: ScreenUtil().setWidth(16),
                    bottom: ScreenUtil().setWidth(32)),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Transform.translate(
                            offset: Offset(0, ScreenUtil().setHeight(-6.1)),
                            child: SvgPicture.asset(Images.quizWhiteVector),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(8),
                            height: ScreenUtil().setHeight(8),
                            decoration: BoxDecoration(
                              color: ColorsHelpers.grey5,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
                      child: widgetText(
                        'Set up your intervention time',
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(20),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                      alignment: Alignment.topLeft,
                      child: widgetText(
                        'FocusFlip will intervene when you open a trigger app'
                        ' and ask you to use a healthy app for a certain time. Here, '
                        'you can set up the intervention time.',
                        color: ColorsHelpers.grey1,
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                      alignment: Alignment.topLeft,
                      child: BlocBuilder<MainScreenCubit, MainScreenState>(
                        bloc: mainScreenCubit,
                        builder: (context, state) {
                          return TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: widgetText("Intervention time (seconds)"),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorsHelpers.grey5, width: 2.5),
                                  borderRadius: BorderRadius.circular(20.0)),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              contentPadding: EdgeInsets.only(
                                top: ScreenUtil().setWidth(16),
                                bottom: ScreenUtil().setWidth(16),
                                left: ScreenUtil().setWidth(24),
                                right: ScreenUtil().setWidth(24),
                              ),
                              hintText: 'Time in seconds',
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(16),
                                  color: ColorsHelpers.grey2),
                            ),
                            initialValue:
                                state.requiredHealthyTime.inSeconds.toString(),
                            onChanged: (value) {
                              mainScreenCubit.updateRequiredHealthyTime(value);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
