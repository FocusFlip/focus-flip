import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flip/utils/widget_assets.dart';

void showConfirmationDialog(
    {required BuildContext context,
    required String title,
    required String content,
    required Function onConfirm,
    required Function onCancel}) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: widgetText(title),
        content: widgetText(content, fontSize: ScreenUtil().setSp(14)),
        actions: <Widget>[
          TextButton(
            child: widgetText('Cancel'),
            onPressed: () {
              onCancel();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: widgetText('Confirm'),
            onPressed: () {
              onConfirm();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
