import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sampleLoginPage/screens/dashBoard.dart';
import 'package:sampleLoginPage/services/httpRequestBody.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      if (value.getBool('loginStatus') != null &&
          value.getBool('loginStatus')) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => DashBoardPage()));
      }
    });
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  String validatePassword(String value) {
    // String patttern = r'(^[a-zA-Z]*$)';
    // RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "password is Required";
    }
    // else if (!regExp.hasMatch(value)) {
    //   return "Location is not valid";
    // }
    return null;
  }

  bool checkFlag = false;
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Container(
          width: _media.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 120,
                  ),
                  Text("Admin Panel",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(fontSize: 26),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text("admin access to ashva the fitness app",
                      style: GoogleFonts.roboto(
                        textStyle:
                            TextStyle(fontSize: 14, color: Color(0xff8B959A)),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  // Text(
                  //   "Enter via social networks",
                  //   style: TextStyle(fontSize: 13, color: Color(0xff8B959A)),
                  // ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: <Widget>[
                  //     Container(
                  //       height: _media.height * .07,
                  //       width: _media.width * .43,
                  //       child: RaisedButton(
                  //         onPressed: () {},
                  //         color: Color(0xff76A9EA),
                  //         child: Icon(
                  //           MdiIcons.twitter,
                  //           color: Colors.white,
                  //           size: 40,
                  //         ),
                  //       ),
                  //     ),
                  //     Spacer(),
                  //     Container(
                  //       height: _media.height * .07,
                  //       width: _media.width * .43,
                  //       child: RaisedButton(
                  //         onPressed: () {},
                  //         color: Color(0xff475993),
                  //         child: Icon(
                  //           MdiIcons.facebook,
                  //           color: Colors.white,
                  //           size: 40,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  // Text(
                  //   "or login with email",
                  //   style: TextStyle(fontSize: 13, color: Color(0xff8B959A)),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(children: [
                    Container(
                      child: TextFormField(
                        controller: _email,
                        validator: validateEmail,
                        focusNode: _emailFocus,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffE2E6EA),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            labelText: "Email"),
                        onFieldSubmitted: (value) {
                          _fieldFocusChange(
                              context, _emailFocus, _passwordFocus);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      child: TextFormField(
                        controller: _password,
                        focusNode: _passwordFocus,
                        validator: validatePassword,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffE2E6EA),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            labelText: "Password"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        // child: Row(
                        //   children: <Widget>[
                        //     SizedBox(
                        //       height: 30,
                        //       width: 30,
                        //       child: Checkbox(
                        //           value: checkFlag,
                        //           onChanged: (value) {
                        //             setState(() {
                        //               checkFlag = value;
                        //             });
                        //           }),
                        //     ),
                        //     Text("Remember me",
                        //         style: GoogleFonts.roboto(
                        //           textStyle: TextStyle(
                        //               fontSize: 15, color: Color(0xff696969)),
                        //         )),
                        //     Spacer(),
                        //     Text("Forgot password?",
                        //         style: GoogleFonts.roboto(
                        //           textStyle: TextStyle(
                        //               fontSize: 15, color: Color(0xff696969)),
                        //         ))
                        //   ],
                        // ),
                        ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: _media.height * .07,
                      width: _media.width,
                      child: RaisedButton(
                          onPressed: !isLoading
                              ? () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await postLogin({
                                      "password": _password.text,
                                      "username": _email.text
                                    });

                                    // Navigator.pushReplacementNamed(context, '/bottomNav');
                                  }
                                }
                              : () {},
                          // onPressed: () {
                          //   Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => DashBoardPage()));
                          // },
                          color: Color(0xff3C82FF),
                          child: !isLoading
                              ? Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                )
                              : CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Text(
                    //       "Don’t have an acoount ?",
                    //       style:
                    //           TextStyle(fontSize: 13, color: Color(0xff8B959A)),
                    //     ),
                    //     SizedBox(
                    //       width: 5,
                    //     ),
                    //     Text(
                    //       "Sign Up",
                    //       style: TextStyle(
                    //         fontSize: 13,
                    //         color: Color(0xff3C82FF),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> postLogin(Map<String, dynamic> requestBody) async {
    try {
      Response response =
          await newHttpPost(uri: uriList['employeeAuth'], body: requestBody);
      Map<String, dynamic> responseBody = json.decode(response.body);

      await prefs.setBool('loginStatus', true);
      await prefs.setString('auth_token', responseBody['token']);
      print("corporate login state set" +
          prefs.get('corporate_login').toString());
      print("auth token set" + prefs.get('auth_token'));

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashBoardPage()));
        Fluttertoast.showToast(msg: "Login sucessful");
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: responseBody['errorDesc']);
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "login up failed");
      setState(() {
        isLoading = false;
      });
    }
    print("loading done for login up");
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
