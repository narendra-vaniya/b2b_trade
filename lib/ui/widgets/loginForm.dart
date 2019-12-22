/*
 * This page body of login page
 * Login Form
 * 
 */

import 'package:b2b_trade/api/dataBaseApiConnection.dart';
import 'package:b2b_trade/api/screenInfo.dart';
import 'package:b2b_trade/ui/pages/adminPages/dashboardPage.dart';
import 'package:b2b_trade/ui/pages/loginPage.dart';
import 'package:b2b_trade/ui/pages/usersPages/userDashBoard.dart';
import 'package:b2b_trade/ui/widgets/reuseWidgets.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  //! Var
  String _email;
  String _pwd;
  bool isload = false;
  bool _checkboxvalue = false;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _screen = ScreenInfo(context);
    return Form(
      key: _key,
      child: Column(
        children: <Widget>[
          //!Form Card Box
          Card(
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(height: _screen.getHeight * 0.02),
                //!User id
                Container(
                  child: TextFormField(
                    validator: (value) {
                      return (value.isEmpty || value == null)
                          ? 'Enter user\'id'
                          : null;
                    },
                    decoration: InputDecoration(
                      hintText: 'User name',
                      hintStyle: reuse.getPlaceholderStyle(),
                      prefixIcon: Icon(Icons.person, color: reuse.getBGColor()),
                    ),
                    onSaved: (v) {
                      if (v != null || v.isEmpty)
                        setState(
                          () {
                            _email = v;
                          },
                        );
                    },
                  ),
                  margin: EdgeInsets.all(10),
                ),
                SizedBox(
                  height: _screen.getHeight * 0.01,
                ),
                //!Password
                Container(
                  child: TextFormField(
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? 'Enter password'
                          : null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: reuse.getPlaceholderStyle(),
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: reuse.getBGColor(),
                      ),
                    ),
                    onSaved: (v) {
                      setState(
                        () {
                          _pwd = v;
                        },
                      );
                    },
                  ),
                  margin: EdgeInsets.all(10),
                ),
                SizedBox(height: _screen.getHeight * 0.05),
              ],
            ),
          ),
          //!Check box
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Checkbox(
                  value: _checkboxvalue,
                  onChanged: (v) {
                    setState(() {
                      _checkboxvalue = v;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 4,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    "By clicking check box you are agree to the our Terms   \n& Conndition.",
                    style: reuse.getTextStyle2(),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: _screen.getHeight * 0.03,
          ),
          //!Login Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: RaisedButton(
                  autofocus: true,
                  textColor: Colors.white,
                  color: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: FittedBox(
                    child: Text("LOGIN"),
                  ),
                  //!Backend method for login
                  onPressed: () async {
                    print("object");

                    if (_key.currentState.validate()) {
                      if (_checkboxvalue) {
                        _key.currentState.save();
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CircularProgressIndicator(
                                    backgroundColor: reuse.getBGColor(),
                                  ),
                                ),
                              );
                            });

                        (await baseAPIDB.checkUser(_email))
                            ? (await baseAPIDB.checkAuth(_email) == "auth")
                                ? await baseAPIDB.signIn(context, _email, _pwd).whenComplete(
                                    () async {
                                      (await baseAPIDB.getUser())
                                         ?(await baseAPIDB.checkStatus(_email))
                                            ? Navigator.pushReplacementNamed(context, '/dashboard')
                                            : Navigator.pushReplacementNamed(context, '/userdashboard')
                                          :LoginPage();
                                    },
                                  )
                                : showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        elevation: 1,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        contentPadding: EdgeInsets.all(20),
                                        children: <Widget>[
                                          Text(
                                              "User is login in another device."),
                                          FlatButton(
                                            child: Text("OK"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    })
                            : showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    contentPadding: EdgeInsets.all(20),
                                    children: <Widget>[
                                      Text("User is not found."),
                                      FlatButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                      } else {
                        print("object");
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Accept The Terms & Conndition "),
                          ),
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
