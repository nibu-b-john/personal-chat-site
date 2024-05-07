import 'package:chat_site/Util/responsive.dart';
import 'package:flutter/material.dart';

// primaryColor: primaryColor,
//                                           secondaryColor: secondaryColor,
//                                           primaryColorText: primaryColorText,
//                                           secondaryColorText:

class MessageBox extends StatefulWidget {
  final String message;
  final bool isMe;
  Color primaryColor;
  Color secondaryColor;
  Color primaryColorText;
  Color secondaryColorText;
  MessageBox(
      {super.key,
      required this.message,
      required this.isMe,
      required this.primaryColor,
      required this.secondaryColor,
      required this.primaryColorText,
      required this.secondaryColorText});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    Size size = MediaQuery.sizeOf(context);
    if (!widget.isMe) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
                child: Container(
              decoration: BoxDecoration(
                  color: widget.secondaryColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: Padding(
                padding: EdgeInsets.all(size.height * 0.015),
                child: Text(
                  widget.message,
                  style: TextStyle(
                    color: widget.secondaryColorText,
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.isDesktop(context)
                        ? size.width * 0.01
                        : Responsive.isTablet(context)
                            ? size.width * 0.015
                            : size.width * 0.028,
                  ),
                ),
              ),
            )),
          ],
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
                child: Container(
              decoration: BoxDecoration(
                  color: widget.primaryColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: Padding(
                padding: EdgeInsets.all(size.height * 0.015),
                child: Text(
                  widget.message,
                  style: TextStyle(
                    color: widget.primaryColorText,
                    fontWeight: FontWeight.w600,
                    fontSize: Responsive.isDesktop(context)
                        ? size.width * 0.01
                        : Responsive.isTablet(context)
                            ? size.width * 0.015
                            : size.width * 0.028,
                  ),
                ),
              ),
            ))
          ],
        ),
      );
    }
  }
}
