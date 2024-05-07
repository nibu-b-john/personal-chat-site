import 'package:chat_site/Chat/chat.dart';
import 'package:chat_site/Database/auth.dart';
import 'package:chat_site/Database/database.dart';
import 'package:chat_site/Resources/constants.dart';
import 'package:chat_site/Util/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as l;

class GetEmail extends StatefulWidget {
  String primaryUser;
  GetEmail({super.key, required this.primaryUser});

  @override
  State<GetEmail> createState() => _GetEmailState();
}

class _GetEmailState extends State<GetEmail> {
  TextEditingController _emailController = TextEditingController();
  final database = DatabaseService();
  void showSnackBar(String message, [bool error = false]) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: error ? Colors.red : Colors.green,
    ));
  }

  void onSubmit() {
    _emailController.text == widget.primaryUser
        ? showSnackBar("Try another email", true)
        : database.checkIfUserRegistered(_emailController.text).then((value) {
            if (value) {
              database
                  .linkUsers(widget.primaryUser, _emailController.text)
                  .then((val) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Chat(
                            primaryUser: widget.primaryUser,
                            docId: val.toString())));
              });
            } else {
              showSnackBar("Use a registered email id.", true);
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    Size size = MediaQuery.sizeOf(context);
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
                  ? size.width * 0.4
                  : Responsive.isTablet(context)
                      ? size.width * 0.5
                      : size.width * 0.75,
              height: size.height * 0.45,
              padding: EdgeInsets.all(size.width * 0.02),
              decoration: BoxDecoration(
                color: colors.secondary.withOpacity(0.05),
                border: Border.all(color: colors.secondary, width: 5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                          Auth().signOut().then((value) =>
                              Navigator.popAndPushNamed(context, '/login'));
                        },
                        icon: Icon(
                          Icons.output_sharp,
                          color: Colors.white,
                        )),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome ${widget.primaryUser}',
                        style: TextStyle(
                          fontSize: Responsive.isDesktop(context)
                              ? size.width * 0.01
                              : Responsive.isTablet(context)
                                  ? size.width * 0.014
                                  : size.width * 0.025,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        'Please provide the email address you wish to communicate with.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: Responsive.isDesktop(context)
                              ? size.width * 0.015
                              : Responsive.isTablet(context)
                                  ? size.width * 0.014
                                  : size.width * 0.027,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                        child: TextFormField(
                          onChanged: (value) {},
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          cursorColor: colors.secondary,
                          style: TextStyle(
                            fontSize: Responsive.isDesktop(context)
                                ? size.width * 0.009
                                : Responsive.isTablet(context)
                                    ? size.width * 0.015
                                    : size.width * 0.028,
                          ),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: colors.secondary, width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    color: colors.secondary, width: 2.0),
                              ),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.transparent,
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  fontSize: Responsive.isDesktop(context)
                                      ? size.width * 0.012
                                      : Responsive.isTablet(context)
                                          ? size.width * 0.015
                                          : size.width * 0.028,
                                  color: colors.secondary)),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          onSubmit();
                        },
                        child: Container(
                          height: size.height * 0.05,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: colors.secondary.withOpacity(0.1),
                              border:
                                  Border.all(color: colors.secondary, width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: Responsive.isDesktop(context)
                                    ? size.width * 0.009
                                    : Responsive.isTablet(context)
                                        ? size.width * 0.015
                                        : size.width * 0.028,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2),
                          )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
