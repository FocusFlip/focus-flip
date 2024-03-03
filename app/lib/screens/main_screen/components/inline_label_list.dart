import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constant.dart';

class Label {
  final String text;
  final void Function()? onTap;
  final bool isActive;
  final Widget? trailing;

  Label({
    required this.text,
    this.onTap,
    this.isActive = false,
    this.trailing,
  });
}

class InlineLabelList extends StatelessWidget {
  final List<Label> labels;

  const InlineLabelList({super.key, required this.labels});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(labels.length, (index) {
        Label label = labels[index];

        return Padding(
          padding: EdgeInsets.only(
              right: ScreenUtil().setWidth(16),
              bottom: ScreenUtil().setHeight(8)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Material(
              borderRadius: BorderRadius.circular(16),
              color: label.isActive
                  ? ColorsHelpers.primaryColor.withOpacity(0.2)
                  : Colors.white,
              child: InkWell(
                  onTap: label.onTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(20),
                        vertical: ScreenUtil().setHeight(12)),
                    decoration: BoxDecoration(
                      border: label.isActive
                          ? null
                          : Border.all(
                              color: ColorsHelpers.grey5,
                            ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          label.text,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                        label.trailing != null
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(8)),
                                child: label.trailing)
                            : SizedBox.shrink()
                      ],
                    ),
                  )),
            ),
          ),
        );
      }),
    );
  }
}
