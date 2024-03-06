import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:focus_flip/models/app.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/images.dart';
import 'package:focus_flip/utils/widget_assets.dart';

class ChooseAppDialog<T extends App> extends StatefulWidget {
  final void Function(BuildContext context, T? app) onSubmit;
  final String title;
  final List<T> apps;

  const ChooseAppDialog(
      {super.key,
      required this.onSubmit,
      required this.apps,
      required this.title});

  @override
  State<StatefulWidget> createState() => _ChooseAppDialogState<T>();
}

class _ChooseAppDialogState<T extends App> extends State<ChooseAppDialog<T>> {
  T? _selectedApp;

  /// It is possible that the app list passed in the arguments is updated
  /// and does not contain the selected app anymore. `DrowdownButton2` does not
  /// handle this case, so we need to ensure that the selected app is set to null
  /// if it is not in the list anymore.
  void _ensureSelectedAppIntegrity() {
    if (!widget.apps.contains(_selectedApp)) {
      setState(() {
        _selectedApp = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _ensureSelectedAppIntegrity();
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: AlertDialog(
          elevation: 24.0,
          insetPadding: EdgeInsets.all(ScreenUtil().setWidth(8)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          contentPadding: EdgeInsets.only(
            left: ScreenUtil().setWidth(24),
            right: ScreenUtil().setWidth(24),
            top: ScreenUtil().setHeight(24),
          ),
          actionsPadding: EdgeInsets.only(
            left: ScreenUtil().setWidth(24),
            right: ScreenUtil().setWidth(24),
            bottom: ScreenUtil().setHeight(14),
          ),
          content: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(16)),
                    alignment: Alignment.topLeft,
                    child: widgetText(
                      'Add Trigger App',
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(16),
                      color: Colors.black,
                      align: TextAlign.start,
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      scrollbarAlwaysShow: true,
                      icon: Padding(
                        padding:
                            EdgeInsets.only(right: ScreenUtil().setWidth(12)),
                        child: Visibility(
                          visible: true,
                          child: SvgPicture.asset(
                            Images.arrowBottom,
                            width: ScreenUtil().setSp(16),
                            height: ScreenUtil().setSp(16),
                          ),
                        ),
                      ),
                      hint: widgetText('Choose an app',
                          fontSize: ScreenUtil().setSp(12),
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      items: [
                        for (T app in widget.apps)
                          DropdownMenuItem(
                            value: app,
                            child: widgetText(
                              app.name,
                              fontSize: ScreenUtil().setSp(12),
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          )
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedApp = value;
                        });
                      },
                      value: _selectedApp,
                      buttonDecoration: BoxDecoration(
                          border: Border.all(color: ColorsHelpers.grey5),
                          borderRadius:
                              BorderRadius.circular(ScreenUtil().setSp(12)),
                          color: Colors.white),
                      buttonHeight: ScreenUtil().setHeight(50),
                      buttonPadding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(16),
                        right: ScreenUtil().setWidth(16),
                      ),
                      buttonWidth: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(8),
                bottom: ScreenUtil().setHeight(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: SizedBox.shrink()),
                  Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
                    child: widgetButton(
                        widgetText('Save',
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16)),
                        height: 56.0,
                        radius: 20.0,
                        () => widget.onSubmit(context, _selectedApp)),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
