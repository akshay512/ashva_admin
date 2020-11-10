import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sampleLoginPage/screens/dashBoard.dart';

class LoginPageIndividual extends StatefulWidget {
  @override
  _LoginPageIndividualState createState() => _LoginPageIndividualState();
}

class _LoginPageIndividualState extends State<LoginPageIndividual> {
  TextEditingController _email;
  TextEditingController _password;

  FocusNode _emailFocus;
  FocusNode _passwordFocus;

  bool checkFlag = false;
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
                        _fieldFocusChange(context, _emailFocus, _passwordFocus);
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
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashBoardPage()));
                        },
                        color: Color(0xff3C82FF),
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
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
    );
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
