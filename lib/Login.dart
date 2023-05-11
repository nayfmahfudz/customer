import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer/component/fom.dart';
import 'package:customer/menu.dart';
import 'package:customer/setting.dart';

import 'component/api.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  var namaController = new TextEditingController();
  var passwordController = new TextEditingController();
  var hide = true;
  var error = "";
  var sales = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: putih,
        body: Row(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: tinggi(context) * 0.4),
                      // Text("ONLINE SHOPPING",
                      //     style: GoogleFonts.montserrat(
                      //         textStyle: Theme.of(context).textTheme.bodyLarge,
                      //         fontSize: 30,
                      //         fontWeight: FontWeight.w600,
                      //         color: orange)),
                      Expanded(child: Image.asset("assets/login.png"))
                    ],
                  ),
                )),
            sales
                ? Text("Before Get Started, you must login",
                    style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: abu))
                : Expanded(
                    flex: 3,
                    child: Container(
                      height: tinggi(context),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        // shadowColor: Color.fromRGBO(237, 155, 12, 1),
                      ),
                      child: Form(
                          key: formKey,
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(tinggi(context) * 0.05),
                            children: <Widget>[
                              SizedBox(height: tinggi(context) * 0.04),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: lebar(context) * 0.2),
                                child: Text("Login Sales",
                                    style: GoogleFonts.montserrat(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600,
                                        color: hitam)),
                              ),
                              SizedBox(height: tinggi(context) * 0.01),
                              Text("Before Get Started, you must login",
                                  style: GoogleFonts.montserrat(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyLarge,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: abu)),
                              SizedBox(height: tinggi(context) * 0.05),
                              password(
                                  passwordController, hide, "Insert Token"),
                              SizedBox(height: tinggi(context) * 0.05),
                              GestureDetector(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      login(namaController.text,
                                              passwordController.text, context)
                                          .then(
                                        (value) {
                                          if (value) {
                                            replaceToNextScreen(
                                                context, Menu());
                                          }
                                        },
                                      );
                                    }
                                  },
                                  child: loginButton('Login', orange, putih)),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text("OR",
                                      style: GoogleFonts.montserrat(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: abu)),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      login(namaController.text,
                                              passwordController.text, context)
                                          .then(
                                        (value) {
                                          if (value) {
                                            replaceToNextScreen(
                                                context, Menu());
                                          }
                                        },
                                      );
                                    }
                                  },
                                  child: loginButton(
                                      'Login as Sales', abu, putih)),
                            ],
                          )),
                    ),
                  ),
            // Expanded(flex: 1, child: Container()),
          ],
        ));
  }
}
