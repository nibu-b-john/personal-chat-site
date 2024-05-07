import 'package:chat_site/Repository/colorPicker.dart';
import 'package:chat_site/Util/responsive.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class SetColorWidget extends StatelessWidget {
  Color color;
  Function changeColor;
  SetColorWidget({
    super.key,
    required this.color,
    required this.changeColor,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ColorIndicator(
      width: Responsive.isDesktop(context)
          ? size.width * 0.02
          : Responsive.isTablet(context)
              ? size.width * 0.02
              : size.width * 0.06,
      height: size.width * 0.02,
      borderRadius: 100,
      color: color,
      onSelectFocus: false,
      onSelect: () async {
        if (!(await colorPicker.colorPickerDialog(
            context, color, changeColor))) {}
      },
    );
  }
}
