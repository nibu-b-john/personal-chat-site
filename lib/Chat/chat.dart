import 'package:chat_site/Chat/Widgets/messageBox.dart';
import 'package:chat_site/Chat/Widgets/setColor.dart';
import 'package:chat_site/Database/database.dart';
import 'package:chat_site/Resources/constants.dart';
import 'package:chat_site/Util/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Chat extends StatefulWidget {
  String primaryUser;
  String docId;
  Chat({super.key, required this.primaryUser, required this.docId});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _textController = TextEditingController();

  final database = DatabaseService();
  bool flag = true;
  void onSubmit() {
    _textController.text.isNotEmpty
        ? database.addChats(widget.docId,
            {"user": widget.primaryUser, "message": _textController.text})
        : null;
    _textController.clear();
  }

  Color primaryColor = Colors.greenAccent.shade700;
  Color primaryColorText = Colors.white;
  Color secondaryColor = Colors.white;
  Color secondaryColorText = Colors.black87;
  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    Size size = MediaQuery.sizeOf(context);
    void primaryChangeColor(Color color) {
      database.changeColor(
          "primaryColor", widget.docId, color.value.toString());
      setState(() => primaryColor = color);
    }

    void secondaryChangeColor(color) {
      database.changeColor(
          "secondaryColor", widget.docId, color.value.toString());
      setState(() => secondaryColor = color);
    }

    void primaryTextChangeColor(color) {
      database.changeColor(
          "primaryColorText", widget.docId, color.value.toString());
      setState(() => primaryColorText = color);
    }

    void secondaryTextChangeColor(color) {
      database.changeColor(
          "secondaryColorText", widget.docId, color.value.toString());
      setState(() => secondaryColorText = color);
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(Constants.bg_image), // Set your image path here
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Container(
              width: Responsive.isDesktop(context)
                  ? size.width * 0.7
                  : Responsive.isTablet(context)
                      ? size.width * 0.7
                      : size.width,
              height: Responsive.isDesktop(context)
                  ? size.height * 0.9
                  : Responsive.isTablet(context)
                      ? size.height * 0.9
                      : size.height * 0.9,
              padding: EdgeInsets.all(size.width * 0.02),
              decoration: BoxDecoration(
                color: colors.secondary.withOpacity(0.05),
                border: Border.all(color: colors.secondary, width: 5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.07),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SetColorWidget(
                                    color: secondaryColor,
                                    changeColor: secondaryChangeColor),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                SetColorWidget(
                                    color: secondaryColorText,
                                    changeColor: secondaryTextChangeColor),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: colors.secondary,
                                  ),
                                ),
                                Text(
                                  'CHAT',
                                  style: TextStyle(
                                      fontSize: Responsive.isDesktop(context)
                                          ? size.width * 0.015
                                          : Responsive.isTablet(context)
                                              ? size.width * 0.020
                                              : size.width * 0.038,
                                      letterSpacing: 5,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SetColorWidget(
                                    color: primaryColor,
                                    changeColor: primaryChangeColor),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                SetColorWidget(
                                    color: primaryColorText,
                                    changeColor: primaryTextChangeColor),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Divider(
                          thickness: 2,
                          color: colors.secondary,
                        ),
                        StreamBuilder(
                            stream: database.getChats(widget.docId),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text(
                                  'No Data...',
                                );
                              } else {
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;

                                return Flexible(
                                  child: ListView.builder(
                                      itemCount: data['chats'].length,
                                      itemBuilder: (_, index) => MessageBox(
                                            message: data['chats'][index]
                                                ['message'],
                                            isMe: data['chats'][index]
                                                    ['user'] ==
                                                widget.primaryUser,
                                            primaryColor: Color(int.parse(
                                                data['primaryColor'])),
                                            secondaryColor: Color(int.parse(
                                                data['secondaryColor'])),
                                            primaryColorText: Color(int.parse(
                                                data['primaryColorText'])),
                                            secondaryColorText: Color(int.parse(
                                                data['secondaryColorText'])),
                                          )),
                                );
                              }
                            })
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                        height: size.height * 0.07,
                        width: Responsive.isDesktop(context)
                            ? size.width * 0.645
                            : Responsive.isTablet(context)
                                ? size.width * 0.650
                                : size.width * 0.935,
                        decoration: BoxDecoration(
                            color: colors.primary,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                            controller: _textController,
                            onSubmitted: (_) {
                              onSubmit();
                            },
                            style: TextStyle(
                              color: colors.secondary,
                              fontSize: Responsive.isDesktop(context)
                                  ? size.width * 0.012
                                  : Responsive.isTablet(context)
                                      ? size.width * 0.015
                                      : size.width * 0.028,
                            ),
                            cursorColor: colors.secondary,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: colors.secondary,
                                fontSize: Responsive.isDesktop(context)
                                    ? size.width * 0.012
                                    : Responsive.isTablet(context)
                                        ? size.width * 0.015
                                        : size.width * 0.028,
                              ),
                              hintText: "Type here",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  onSubmit();
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: colors.secondary,
                                  size: Responsive.isDesktop(context)
                                      ? size.width * 0.015
                                      : Responsive.isTablet(context)
                                          ? size.width * 0.018
                                          : size.width * 0.028,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.0),
                              ),
                            ))),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
