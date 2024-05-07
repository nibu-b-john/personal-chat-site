import 'package:chat_site/Database/auth.dart';
import 'package:chat_site/Authentication/Register/register.dart';
import 'package:chat_site/GetEmail/getEmail.dart';
import 'package:chat_site/Repository/colorPicker.dart';
import 'package:chat_site/Resources/colorsConstants.dart';
import 'package:chat_site/Resources/constants.dart';
import 'package:chat_site/Util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;
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
    Auth()
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((error) {
      if (error == null) {
        showSnackBar('Successfully Login!');

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => GetEmail(
                      primaryUser: _emailController.text,
                    )));
      } else {
        showSnackBar(error, true);
      }
    });
  }

  void checkCurrentUserAndNavigate() {
    if (Auth().currentUser != null) {
      String email = Auth().currentUser!.email.toString();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => GetEmail(
            primaryUser: email,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkCurrentUserAndNavigate();
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
                    ? size.width * 0.6
                    : size.width,
            height: Responsive.isDesktop(context)
                ? size.height * 0.9
                : Responsive.isTablet(context)
                    ? size.height * 0.9
                    : size.height,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            decoration: BoxDecoration(
              color: colors.secondary.withOpacity(0.05),
              border: Border.all(color: colors.secondary, width: 5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: Responsive.isDesktop(context)
                        ? size.width * 0.07
                        : Responsive.isTablet(context)
                            ? size.width * 0.07
                            : size.width * 0.15,
                    height: Responsive.isDesktop(context)
                        ? size.height * 0.07
                        : Responsive.isTablet(context)
                            ? size.height * 0.07
                            : size.height * 0.15,
                    child: Image.asset('assets/logo.png')),
                Text(
                  'LOGIN',
                  style: TextStyle(
                      fontSize: Responsive.isDesktop(context)
                          ? size.width * 0.02
                          : Responsive.isTablet(context)
                              ? size.width * 0.03
                              : size.width * 0.048,
                      letterSpacing: 5),
                ),
                SizedBox(
                  height: size.height * 0.03,
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
                          borderSide:
                              BorderSide(color: colors.secondary, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: colors.secondary, width: 2.0),
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
                  height: size.height * 0.03,
                ),
                SizedBox(
                  height: size.height * 0.07,
                  child: Stack(
                    children: [
                      TextFormField(
                        obscureText: _passwordVisible ? false : true,
                        onChanged: (value) {},
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        cursorColor: colors.secondary,
                        style: TextStyle(
                          fontSize: Responsive.isDesktop(context)
                              ? size.width * 0.009
                              : Responsive.isTablet(context)
                                  ? size.width * 0.015
                                  : size.width * 0.028,
                        ),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: colors.secondary,
                                  size: Responsive.isDesktop(context)
                                      ? size.width * 0.015
                                      : Responsive.isTablet(context)
                                          ? size.width * 0.02
                                          : size.width * 0.04,
                                )),
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
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                fontSize: Responsive.isDesktop(context)
                                    ? size.width * 0.012
                                    : Responsive.isTablet(context)
                                        ? size.width * 0.015
                                        : size.width * 0.028,
                                color: colors.secondary)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                InkWell(
                  onTap: () {
                    onSubmit();
                  },
                  child: Container(
                    height: size.height * 0.07,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: colors.secondary.withOpacity(0.2),
                        border: Border.all(color: colors.secondary, width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: Responsive.isDesktop(context)
                              ? size.width * 0.012
                              : Responsive.isTablet(context)
                                  ? size.width * 0.015
                                  : size.width * 0.028,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    )),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  'Not registered yet? Register below',
                  style: TextStyle(
                      fontSize: Responsive.isDesktop(context)
                          ? size.width * 0.009
                          : Responsive.isTablet(context)
                              ? size.width * 0.015
                              : size.width * 0.025),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Register()));
                  },
                  child: Container(
                    height: size.height * 0.07,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: colors.secondary, width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                        child: Text(
                      'Register',
                      style: TextStyle(
                          fontSize: Responsive.isDesktop(context)
                              ? size.width * 0.012
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
          )),
        ],
      ),
    );
  }
}
