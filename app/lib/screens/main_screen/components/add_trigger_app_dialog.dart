import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flip/cubits/main_screen/main_screen_cubit.dart';
import 'package:focus_flip/utils/constant.dart';
import 'package:focus_flip/utils/widget_assets.dart';

import '../../../utils/toasts.dart';

class AddTriggerAppDialog extends StatefulWidget {
  final void Function(String triggerAppName) onSubmit;
  final MainScreenCubit cubit;

  const AddTriggerAppDialog(
      {super.key, required this.onSubmit, required this.cubit});

  @override
  State<StatefulWidget> createState() => _AddTriggerAppDialogState();
}

class _AddTriggerAppDialogState extends State<AddTriggerAppDialog> {
  final TextEditingController _controller = TextEditingController();

  void _blocListener(context, state) {
    if (state is EmptyNameError) {
      showToast("Enter a name of a trigger app");
    } else if (state is DuplicateNameError) {
      showToast("Trigger app with this name has already been added");
    } else if (state is TriggerAppAdded) {
      Navigator.pop(context);
      // TODO: open tutorial/further settings
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocListener(
          bloc: widget.cubit,
          listener: _blocListener,
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
                      margin:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(8)),
                      alignment: Alignment.topLeft,
                      child: widgetText(
                        'Add Trigger App',
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(16),
                        color: Colors.black,
                        align: TextAlign.start,
                      ),
                    ),
                    TextFormField(
                      controller: _controller,
                      onTap: () {},
                      decoration: InputDecoration(
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
                        hintText: 'App name',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: ScreenUtil().setSp(16),
                            color: ColorsHelpers.grey2),
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
                        () => widget.onSubmit(_controller.text),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
